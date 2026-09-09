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

/// The current playback state of a `BPKVideoPlayerController`.
/// A single published value drives all UI — no separate `isPlaying`/`isLoading` flags needed.
public enum BPKVideoPlayerState: Equatable {
    case loading
    case readyToPlay
    case playing
    case paused
    case buffering
    case failed(Error)

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
            transition(to: .failed(error))
        case .unknown:
            transition(to: isLoopItemTransitioning ? .buffering : .loading)
            scheduleTimeout()
        @unknown default:
            break
        }
    }

    private func handleReadyItem() {
        loadTimeoutTask?.cancel()
        updateProgressDuration()
        let wasLoopItemTransitioning = isLoopItemTransitioning
        isLoopItemTransitioning = false
        let shouldAutoPlay = !hasLoadedInitialItem && autoPlay &&
            !hasExplicitPauseRequest && !UIAccessibility.isReduceMotionEnabled
        hasLoadedInitialItem = true

        switch player.timeControlStatus {
        case .playing:
            transition(to: .playing)
        case .waitingToPlayAtSpecifiedRate:
            transition(to: .buffering)
        case .paused:
            if wasLoopItemTransitioning && state.isActive {
                transition(to: .buffering)
            } else if state != .paused {
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
            transition(to: .buffering)
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
            self.transition(to: .failed(NSError(
                domain: "BPKVideoPlayer",
                code: NSURLErrorTimedOut,
                userInfo: [NSLocalizedDescriptionKey: "Video load timed out"]
            )))
        }
        loadTimeoutTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + loadTimeout, execute: task)
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
