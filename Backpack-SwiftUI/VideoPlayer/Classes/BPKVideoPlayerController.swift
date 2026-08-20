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

protocol BPKVideoPlayerPeriodicTimeObserving {
    func addPeriodicTimeObserver(
        to player: AVPlayer,
        interval: CMTime,
        queue: DispatchQueue,
        using callback: @escaping (CMTime) -> Void
    ) -> Any

    func removePeriodicTimeObserver(_ token: Any, from player: AVPlayer)
}

struct BPKVideoPlayerPeriodicTimeObserver: BPKVideoPlayerPeriodicTimeObserving {
    func addPeriodicTimeObserver(
        to player: AVPlayer,
        interval: CMTime,
        queue: DispatchQueue,
        using callback: @escaping (CMTime) -> Void
    ) -> Any {
        player.addPeriodicTimeObserver(forInterval: interval, queue: queue, using: callback)
    }

    func removePeriodicTimeObserver(_ token: Any, from player: AVPlayer) {
        player.removeTimeObserver(token)
    }
}

typealias BPKVideoPlayerDurationProvider = (AVPlayerItem?) -> TimeInterval?

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

// MARK: - Controller

/// Shareable player controller. Owns one AVPlayer instance and can be injected
/// into multiple views simultaneously for continuous playback across transitions.
public final class BPKVideoPlayerController: ObservableObject {

    /// The underlying AVPlayer instance.
    ///
    /// - Warning: Use `play()`, `pause()`, and `toggle()` rather than calling
    ///   the equivalent methods on `player` directly. Direct playback and seeking
    ///   calls bypass controller state and playback-progress tracking.
    public let player: AVPlayer

    /// The current playback state. Drives all UI — spinner, play/pause icon, error view.
    @Published public private(set) var state: BPKVideoPlayerState = .loading

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
    private let loop: Bool
    private let loadTimeout: TimeInterval
    private let periodicTimeObserver: BPKVideoPlayerPeriodicTimeObserving
    private let durationProvider: BPKVideoPlayerDurationProvider
    private let notificationCenter: NotificationCenter
    private var progressAccumulator = BPKVideoPlayerProgressAccumulator()
    private let progressSubject = CurrentValueSubject<BPKVideoPlayerProgress?, Never>(nil)

    private var playerLooper: AVPlayerLooper?
    private var itemStatusObservation: NSKeyValueObservation?
    private var timeControlObservation: NSKeyValueObservation?
    private var currentItemObservation: NSKeyValueObservation?
    private var periodicTimeObserverToken: Any?
    private var itemCompletionToken: NSObjectProtocol?
    private var loadTimeoutTask: DispatchWorkItem?
    private var lifecycleTokens: [NSObjectProtocol] = []

    // MARK: - Init

    public convenience init(url: URL, autoPlay: Bool = true, loop: Bool = true, loadTimeout: TimeInterval = 7) {
        self.init(
            url: url,
            autoPlay: autoPlay,
            loop: loop,
            loadTimeout: loadTimeout,
            periodicTimeObserver: BPKVideoPlayerPeriodicTimeObserver(),
            durationProvider: Self.liveDuration,
            notificationCenter: .default
        )
    }

    init(
        url: URL,
        autoPlay: Bool,
        loop: Bool,
        loadTimeout: TimeInterval,
        periodicTimeObserver: BPKVideoPlayerPeriodicTimeObserving,
        durationProvider: @escaping BPKVideoPlayerDurationProvider,
        notificationCenter: NotificationCenter
    ) {
        self.autoPlay = autoPlay
        self.loop = loop
        self.loadTimeout = loadTimeout
        self.periodicTimeObserver = periodicTimeObserver
        self.durationProvider = durationProvider
        self.notificationCenter = notificationCenter

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
        player.play()
    }

    public func pause() {
        player.pause()
    }

    public func toggle() {
        if state.isPlaying {
            pause()
        } else {
            play()
        }
    }

    public func seek(to time: CMTime) {
        updateProgress { $0.beginSeek() }
        player.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero) { [weak self] _ in
            DispatchQueue.main.async {
                guard let self else { return }
                self.updateProgress {
                    $0.endSeek(
                        at: self.player.currentTime().seconds,
                        duration: self.durationProvider(self.player.currentItem)
                    )
                }
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
        periodicTimeObserverToken = periodicTimeObserver.addPeriodicTimeObserver(
            to: player,
            interval: CMTime(seconds: 0.25, preferredTimescale: 600),
            queue: .main
        ) { [weak self] time in
            guard let self else { return }
            self.updateProgress {
                $0.record(
                    playhead: time.seconds,
                    duration: self.durationProvider(self.player.currentItem),
                    isLooping: self.loop
                )
            }
        }

        // timeControlStatus is the primary playing/paused/buffering signal
        timeControlObservation = player.observe(\.timeControlStatus, options: [.new]) { [weak self] player, _ in
            DispatchQueue.main.async { self?.handle(timeControlStatus: player.timeControlStatus) }
        }

        // currentItem changes when AVPlayerLooper swaps in a new copy — re-observe status
        currentItemObservation = player.observe(\.currentItem, options: [.new, .initial]) { [weak self] player, _ in
            DispatchQueue.main.async { self?.observeItemStatus(player.currentItem) }
        }
    }

    private func observeItemStatus(_ item: AVPlayerItem?) {
        itemStatusObservation?.invalidate()
        if let itemCompletionToken {
            notificationCenter.removeObserver(itemCompletionToken)
            self.itemCompletionToken = nil
        }
        guard let item else { return }

        itemCompletionToken = notificationCenter.addObserver(
            forName: AVPlayerItem.didPlayToEndTimeNotification,
            object: item,
            queue: .main
        ) { [weak self, weak item] _ in
            guard let self else { return }
            self.updateProgress {
                $0.complete(duration: self.durationProvider(item), isLooping: self.loop)
            }
        }

        itemStatusObservation = item.observe(\.status, options: [.new, .initial]) { [weak self] item, _ in
            DispatchQueue.main.async { self?.handle(itemStatus: item.status) }
        }
    }

    private func handle(itemStatus: AVPlayerItem.Status) {
        switch itemStatus {
        case .readyToPlay:
            loadTimeoutTask?.cancel()
            updateProgress { $0.setDuration(durationProvider(player.currentItem)) }
            transition(to: .readyToPlay)
            if autoPlay && !UIAccessibility.isReduceMotionEnabled { play() }
        case .failed:
            loadTimeoutTask?.cancel()
            let error = player.currentItem?.error ?? NSError(domain: "BPKVideoPlayer", code: -1)
            transition(to: .failed(error))
        case .unknown:
            transition(to: .loading)
            scheduleTimeout()
        @unknown default:
            break
        }
    }

    private func handle(timeControlStatus: AVPlayer.TimeControlStatus) {
        switch timeControlStatus {
        case .playing:
            transition(to: .playing)
        case .paused:
            // Suppress .paused during initial load — only meaningful after we were playing
            if state == .playing { transition(to: .paused) }
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

    private func updateProgress(_ update: (inout BPKVideoPlayerProgressAccumulator) -> Void) {
        update(&progressAccumulator)
        progressSubject.send(progressAccumulator.progress)
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
        try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
        try? AVAudioSession.sharedInstance().setActive(true)
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

    private static func liveDuration(for item: AVPlayerItem?) -> TimeInterval? {
        guard let duration = item?.duration,
            duration.isNumeric,
            duration.seconds.isFinite,
            duration.seconds > 0 else {
            return nil
        }
        return duration.seconds
    }

    // MARK: - Test support

    func testOnly_setState(_ newState: BPKVideoPlayerState) {
        state = newState
    }
}
