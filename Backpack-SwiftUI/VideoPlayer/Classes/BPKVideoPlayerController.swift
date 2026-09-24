/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import AVFoundation
import Combine
import UIKit

// MARK: - Playback state

/// Normalised failure categories emitted by a video player.
///
/// Codes are aligned with the web video-player taxonomy so cross-platform
/// New Relic dashboards can group events by the same string value.
public enum BPKVideoPlayerError: Error, Equatable, Sendable {
    case aborted
    case network
    case decode
    case sourceNotSupported
    case loadTimeout
    case hlsChunkLoadFailed
    case hlsNetwork
    case hlsMedia
    case hlsMux
    case hlsOther
    case hlsNotSupported
    case hlsUnknown
    case unknown

    /// The string code to emit when logging this error to operational observability tools.
    public var code: String {
        switch self {
        case .aborted: "MEDIA_ERR_ABORTED"
        case .network: "MEDIA_ERR_NETWORK"
        case .decode: "MEDIA_ERR_DECODE"
        case .sourceNotSupported: "MEDIA_ERR_SRC_NOT_SUPPORTED"
        case .loadTimeout: "LOAD_TIMEOUT"
        case .hlsChunkLoadFailed: "HLS_CHUNK_LOAD_FAILED"
        case .hlsNetwork: "HLS_NETWORK_ERROR"
        case .hlsMedia: "HLS_MEDIA_ERROR"
        case .hlsMux: "HLS_MUX_ERROR"
        case .hlsOther: "HLS_OTHER_ERROR"
        case .hlsNotSupported: "HLS_NOT_SUPPORTED"
        case .hlsUnknown: "HLS_UNKNOWN_ERROR"
        case .unknown: "UNKNOWN_ERROR"
        }
    }
}

/// The current playback state of a `BPKVideoPlayerController`.
/// A single published value drives all UI — no separate `isPlaying`/`isLoading` flags needed.
public enum BPKVideoPlayerState: Equatable {
    case loading
    case readyToPlay
    case playing
    case paused
    case buffering
    case failed(BPKVideoPlayerError)

    public var isLoading: Bool {
        self == .loading || self == .buffering
    }

    public var isPlaying: Bool {
        self == .playing
    }

    public var isActive: Bool {
        self == .playing || self == .buffering
    }

    public static func == (lhs: BPKVideoPlayerState, rhs: BPKVideoPlayerState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.readyToPlay, .readyToPlay),
            (.playing, .playing), (.paused, .paused), (.buffering, .buffering):
            return true
        case (.failed, .failed):
            return true
        default:
            return false
        }
    }
}

/// Controls how a video player's audio interacts with the device audio session.
public enum BPKVideoPlayerAudioSessionPolicy: Sendable {
    /// Treats video audio as non-primary, respecting the Ring/Silent switch.
    case ambient

    /// Treats video audio as content playback, so it continues when the Ring/Silent switch is on.
    case playback
}

// MARK: - Controller

/// Shareable player controller. Owns one AVPlayer instance and can be injected
/// into multiple views simultaneously for continuous playback across transitions.
@MainActor
public final class BPKVideoPlayerController: ObservableObject {

    /// The underlying AVPlayer instance.
    ///
    /// - Warning: Use `play()`, `pause()`, and `toggle()` rather than calling
    ///   the equivalent methods on `player` directly. Direct playback and seeking
    ///   calls bypass controller state and playback-progress tracking.
    public let player: AVPlayer

    /// The current playback state. Drives all UI — spinner, play/pause icon, error view.
    @Published public private(set) var state: BPKVideoPlayerState = .loading

    /// Whether the player is muted. Drives custom mute controls.
    @Published public private(set) var isMuted = false

    /// Cumulative bytes transferred from the network for the current player item.
    ///
    /// Sourced from `AVPlayerItem.accessLog()`. Resets to `0` when a new item begins loading.
    /// `nil` is never published — before the first access-log entry the value is `0`.
    ///
    /// - Note: AVFoundation's asset networking is not observed by New Relic Mobile's URLSession
    ///   instrumentation. This property is the only iOS route to video data-transfer metrics.
    @Published public private(set) var numberOfBytesTransferred: Int64 = 0

    // MARK: - Playback progress

    /// The latest playback progress, or `nil` until duration is known.
    public var progress: BPKVideoPlayerProgress? {
        progressSubject.value
    }

    /// Emits the current complete snapshot and subsequent distinct updates.
    /// Values are delivered on the main queue.
    public var progressPublisher: AnyPublisher<BPKVideoPlayerProgress, Never> {
        progressSubject
            .compactMap { $0 }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Configuration and observations

    private let autoPlay: Bool
    let loop: Bool
    private let loadTimeout: TimeInterval
    private let audioSessionPolicy: BPKVideoPlayerAudioSessionPolicy
    let periodicTimeObserver: BPKVideoPlayerPeriodicTimeObserving
    let durationProvider: BPKVideoPlayerDurationProvider
    let notificationCenter: NotificationCenter
    let audioSession: BPKVideoPlayerAudioSessionManaging
    var progressAccumulator = BPKVideoPlayerProgressAccumulator()
    let progressSubject = CurrentValueSubject<BPKVideoPlayerProgress?, Never>(nil)
    var hasCompletedPlayback = false
    var progressSeekID = 0
    private var isLoopItemTransitioning = false
    private var observedItem: AVPlayerItem?
    private var hasLoadedInitialItem = false
    private var hasExplicitPauseRequest = false

    private var playerLooper: AVPlayerLooper?
    private var mutedObservation: NSKeyValueObservation?
    private var itemStatusObservation: NSKeyValueObservation?
    private var timeControlObservation: NSKeyValueObservation?
    private var currentItemObservation: NSKeyValueObservation?
    var periodicTimeObserverToken: Any?
    var itemCompletionToken: NSObjectProtocol?
    private var loadTimeoutTask: DispatchWorkItem?
    private var lifecycleTokens: [NSObjectProtocol] = []
    private var accessLogToken: NSObjectProtocol?

    // MARK: - Init

    public convenience init(
        url: URL,
        autoPlay: Bool = true,
        loop: Bool = true,
        loadTimeout: TimeInterval = 7,
        audioSessionPolicy: BPKVideoPlayerAudioSessionPolicy = .ambient
    ) {
        self.init(
            url: url,
            autoPlay: autoPlay,
            loop: loop,
            loadTimeout: loadTimeout,
            audioSessionPolicy: audioSessionPolicy,
            periodicTimeObserver: BPKVideoPlayerPeriodicTimeObserver(),
            durationProvider: Self.liveDuration,
            notificationCenter: .default,
            audioSession: AVAudioSession.sharedInstance()
        )
    }

    init(
        url: URL,
        autoPlay: Bool,
        loop: Bool,
        loadTimeout: TimeInterval,
        audioSessionPolicy: BPKVideoPlayerAudioSessionPolicy = .ambient,
        periodicTimeObserver: BPKVideoPlayerPeriodicTimeObserving,
        durationProvider: @escaping BPKVideoPlayerDurationProvider,
        notificationCenter: NotificationCenter,
        audioSession: BPKVideoPlayerAudioSessionManaging = AVAudioSession.sharedInstance()
    ) {
        self.autoPlay = autoPlay
        self.loop = loop
        self.loadTimeout = loadTimeout
        self.audioSessionPolicy = audioSessionPolicy
        self.periodicTimeObserver = periodicTimeObserver
        self.durationProvider = durationProvider
        self.notificationCenter = notificationCenter
        self.audioSession = audioSession

        let item = AVPlayerItem(asset: AVAsset(url: url))
        if loop {
            let queuePlayer = AVQueuePlayer()
            player = queuePlayer
            playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: item)
        } else {
            player = AVPlayer(playerItem: item)
        }

        observePlayer()
        configureAudioSession()
        observeLifecycle()
    }

    deinit {
        itemStatusObservation?.invalidate()
        timeControlObservation?.invalidate()
        currentItemObservation?.invalidate()
        mutedObservation?.invalidate()
        if let periodicTimeObserverToken {
            periodicTimeObserver.removePeriodicTimeObserver(periodicTimeObserverToken, from: player)
        }
        if let itemCompletionToken {
            notificationCenter.removeObserver(itemCompletionToken)
        }
        if let accessLogToken {
            notificationCenter.removeObserver(accessLogToken)
        }
        loadTimeoutTask?.cancel()
        lifecycleTokens.forEach { NotificationCenter.default.removeObserver($0) }
    }

    // MARK: - Public controls

    public func play() {
        guard !UIAccessibility.isReduceMotionEnabled else { return }
        hasExplicitPauseRequest = false
        if hasCompletedPlayback {
            seek(to: .zero)
        }
        player.play()
    }

    public func pause() {
        hasExplicitPauseRequest = true
        isLoopItemTransitioning = false
        player.pause()
        if state.isActive {
            transition(to: .paused)
        }
    }

    public func toggle() {
        if state.isPlaying {
            pause()
        } else {
            play()
        }
    }

    /// Mutes the player.
    public func mute() {
        setMuted(true)
    }

    /// Unmutes the player.
    public func unmute() {
        setMuted(false)
    }

    /// Toggles the player muted state.
    public func toggleMute() {
        setMuted(player.isMuted == false)
    }

    private func setMuted(_ muted: Bool) {
        player.isMuted = muted
        handle(muted: player.isMuted)
    }

    public func seek(to time: CMTime) {
        let seekID = prepareProgressForSeek(to: time)
        player.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero) { [weak self] finished in
            guard finished else { return }
            DispatchQueue.main.async {
                self?.finishProgressSeek(id: seekID)
            }
        }
    }

    /// Pause and seek to the beginning — use for carousel items that reset on scroll-off.
    public func resetToStart() {
        pause()
        seek(to: .zero)
    }

    // MARK: - Private

    private func observePlayer() {
        startProgressObserving()

        mutedObservation = player.observe(\.isMuted, options: [.initial, .new]) { [weak self] player, _ in
            DispatchQueue.main.async { self?.handle(muted: player.isMuted) }
        }

        // timeControlStatus is the primary playing/paused/buffering signal
        timeControlObservation = player.observe(\.timeControlStatus, options: [.new]) { [weak self] player, _ in
            DispatchQueue.main.async { self?.handle(timeControlStatus: player.timeControlStatus) }
        }

        // currentItem changes when AVPlayerLooper swaps in a new copy — re-observe status
        currentItemObservation = player.observe(\.currentItem, options: [.new, .initial]) { [weak self] player, _ in
            DispatchQueue.main.async { self?.handleCurrentItemChange(player.currentItem) }
        }
    }

    private func observeItemStatus(_ item: AVPlayerItem?) {
        itemStatusObservation?.invalidate()
        observedItem = item
        observeProgressCompletion(for: item)
        guard let item else { return }

        itemStatusObservation = item.observe(\.status, options: [.new, .initial]) { [weak self] item, _ in
            DispatchQueue.main.async { self?.handle(itemStatus: item.status, for: item) }
        }
    }

    private func handle(muted: Bool) {
        guard isMuted != muted else { return }
        isMuted = muted
    }

    private func handleCurrentItemChange(_ item: AVPlayerItem?) {
        numberOfBytesTransferred = 0
        if let accessLogToken {
            notificationCenter.removeObserver(accessLogToken)
            self.accessLogToken = nil
        }

        guard item != nil else {
            isLoopItemTransitioning = false
            observeItemStatus(nil)
            if player.timeControlStatus == .paused && state.isActive {
                transition(to: .paused)
            }
            return
        }

        markLoopItemTransitionIfNeeded()
        observeItemStatus(item)
        updateBytesTransferred(for: item)
        accessLogToken = notificationCenter.addObserver(
            forName: .AVPlayerItemNewAccessLogEntry,
            object: item,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.updateBytesTransferred(for: item)
            }
        }
    }

    private func markLoopItemTransitionIfNeeded() {
        guard loop, hasLoadedInitialItem, let currentItem = player.currentItem else { return }
        if observedItem !== currentItem {
            isLoopItemTransitioning = true
        }
    }

    private func handle(itemStatus: AVPlayerItem.Status, for item: AVPlayerItem) {
        guard player.currentItem === item else { return }

        switch itemStatus {
        case .readyToPlay:
            handleReadyItem()
        case .failed:
            loadTimeoutTask?.cancel()
            let error = item.error ?? NSError(domain: "BPKVideoPlayer", code: -1)
            isLoopItemTransitioning = false
            transition(to: .failed(Self.normalise(error as NSError)))
        case .unknown:
            transition(to: isLoopItemTransitioning ? .buffering : .loading)
            scheduleTimeout()
        @unknown default:
            break
        }
    }

    private func handleReadyItem() {
        let isInitialLoad = !hasLoadedInitialItem
        let isWaitingForPlayback = player.timeControlStatus == .waitingToPlayAtSpecifiedRate
        // Keep the timeout active when the item is ready but transport is still waiting:
        // AVFoundation can report readyToPlay before data is available to play. The timeout
        // must remain scheduled until the first playing/paused/readyToPlay state is reached.
        if !isInitialLoad || !isWaitingForPlayback {
            loadTimeoutTask?.cancel()
        }
        updateProgressDuration()
        let wasLoopItemTransitioning = isLoopItemTransitioning
        isLoopItemTransitioning = false
        let shouldAutoPlay = isInitialLoad && autoPlay &&
            !hasExplicitPauseRequest && !UIAccessibility.isReduceMotionEnabled
        if !isWaitingForPlayback {
            hasLoadedInitialItem = true
        }

        switch player.timeControlStatus {
        case .playing:
            completeInitialLoad()
            transition(to: .playing)
        case .waitingToPlayAtSpecifiedRate:
            // Item is ready but playback has not started. Treat as still loading so the
            // configured timeout continues to run, aligned with Android BpkVideoPlayer
            // which keeps LoadTimeout eligible until STATE_READY with isPlaying=true.
            if hasLoadedInitialItem {
                transition(to: .buffering)
            } else {
                transition(to: .loading)
                scheduleTimeout()
            }
        case .paused:
            if wasLoopItemTransitioning && state.isActive {
                transition(to: .buffering)
            } else if state != .paused {
                completeInitialLoad()
                transition(to: .readyToPlay)
            }
            if shouldAutoPlay { play() }
        @unknown default:
            transition(to: .readyToPlay)
        }
    }

    private func handle(timeControlStatus: AVPlayer.TimeControlStatus) {
        markLoopItemTransitionIfNeeded()
        switch timeControlStatus {
        case .playing:
            completeInitialLoad()
            transition(to: .playing)
        case .paused:
            // AVPlayerLooper briefly reports `.paused` while it replaces a completed item.
            // Wait for the replacement item's status before publishing a state change.
            let shouldPublishPause = state.isActive ||
                (hasExplicitPauseRequest && state == .readyToPlay)
            let replacementIsStillLoading = isLoopItemTransitioning &&
                player.currentItem?.status == .unknown
            if !replacementIsStillLoading && shouldPublishPause {
                // A paused transport is an external stop once the replacement
                // item is ready. Clear the handoff guard so ready-item handling
                // cannot turn the state back into buffering.
                isLoopItemTransitioning = false
                transition(to: .paused)
            }
        case .waitingToPlayAtSpecifiedRate:
            // Same logic as in handleReadyItem: during the initial load, keep the
            // state as .loading so the configured timeout remains active.
            if hasLoadedInitialItem {
                transition(to: .buffering)
            } else {
                transition(to: .loading)
                scheduleTimeout()
            }
        @unknown default:
            break
        }
    }

    private func transition(to newState: BPKVideoPlayerState) {
        guard state != newState else { return }
        state = newState
    }

    private func scheduleTimeout() {
        loadTimeoutTask?.cancel()
        guard loadTimeout > 0 else { return }
        let task = DispatchWorkItem { [weak self] in
            guard let self, self.state.isLoading else { return }
            self.transition(to: .failed(.loadTimeout))
        }
        loadTimeoutTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + loadTimeout, execute: task)
    }

    // MARK: - Access log / bytes transferred

    private func updateBytesTransferred(for item: AVPlayerItem?) {
        numberOfBytesTransferred = item?.accessLog()?.events
            .reduce(into: Int64.zero) { total, event in
                total += event.numberOfBytesTransferred
            } ?? 0
    }

    // MARK: - Timeout helpers

    /// Called when playback transitions to a definitive non-loading state for the first time.
    /// Marks the initial load complete and cancels any pending load-timeout task.
    private func completeInitialLoad() {
        guard !hasLoadedInitialItem else { return }
        hasLoadedInitialItem = true
        loadTimeoutTask?.cancel()
    }

    // MARK: - Error normalisation

    /// Maps an `NSError` from AVFoundation or the URL layer to a normalised `BPKVideoPlayerError`
    /// so consumers do not need to own their own AVFoundation mapping.
    private static func normalise(_ error: NSError) -> BPKVideoPlayerError {
        if error.domain == NSURLErrorDomain {
            if error.code == NSURLErrorCancelled {
                return .aborted
            }
            return .network
        }

        guard error.domain == AVFoundationErrorDomain else { return .unknown }

        switch error.code {
        case AVError.Code.operationInterrupted.rawValue:
            return .aborted
        case AVError.Code.decoderNotFound.rawValue,
             AVError.Code.decodeFailed.rawValue:
            return .decode
        case AVError.Code.fileFormatNotRecognized.rawValue:
            return .sourceNotSupported
        default:
            return .unknown
        }
    }

    private func configureAudioSession() {
        try? audioSession.setCategory(
            audioSessionPolicy.category,
            mode: audioSessionPolicy.mode,
            options: [.mixWithOthers]
        )
        try? audioSession.setActive(true, options: [])
    }

    private func observeLifecycle() {
        // Pause on background, resume on foreground — no flag needed, just react
        lifecycleTokens = [
            NotificationCenter.default.addObserver(
                forName: UIScene.didEnterBackgroundNotification,
                object: nil, queue: .main
            ) { [weak self] _ in self?.pause() },

            NotificationCenter.default.addObserver(
                forName: UIScene.didActivateNotification,
                object: nil, queue: .main
            ) { [weak self] _ in self?.play() },

            NotificationCenter.default.addObserver(
                forName: UIAccessibility.reduceMotionStatusDidChangeNotification,
                object: nil, queue: .main
            ) { [weak self] _ in
                if UIAccessibility.isReduceMotionEnabled { self?.pause() }
            }
        ]
    }

    // MARK: - Test support

    func testOnly_setState(_ newState: BPKVideoPlayerState) {
        state = newState
    }

    func testOnly_handleCurrentItemChange(_ item: AVPlayerItem?) {
        handleCurrentItemChange(item)
    }

    var testOnly_isLoopItemTransitioning: Bool {
        isLoopItemTransitioning
    }
}

private extension BPKVideoPlayerAudioSessionPolicy {
    var category: AVAudioSession.Category {
        switch self {
        case .ambient:
            .ambient
        case .playback:
            .playback
        }
    }

    var mode: AVAudioSession.Mode {
        switch self {
        case .ambient:
            .default
        case .playback:
            .moviePlayback
        }
    }
}

protocol BPKVideoPlayerAudioSessionManaging: AnyObject {
    func setCategory(
        _ category: AVAudioSession.Category,
        mode: AVAudioSession.Mode,
        options: AVAudioSession.CategoryOptions
    ) throws
    func setActive(_ active: Bool, options: AVAudioSession.SetActiveOptions) throws
}

extension AVAudioSession: BPKVideoPlayerAudioSessionManaging {}
