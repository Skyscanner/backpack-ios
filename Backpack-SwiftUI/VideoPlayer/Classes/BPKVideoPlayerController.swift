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
    ///   `player.play()`/`player.pause()` directly — direct calls bypass state tracking.
    public let player: AVPlayer

    /// The current playback state. Drives all UI — spinner, play/pause icon, error view.
    @Published public private(set) var state: BPKVideoPlayerState = .loading

    private let autoPlay: Bool
    private let loop: Bool
    private let loadTimeout: TimeInterval

    private var playerLooper: AVPlayerLooper?
    private var itemStatusObservation: NSKeyValueObservation?
    private var timeControlObservation: NSKeyValueObservation?
    private var currentItemObservation: NSKeyValueObservation?
    private var loadTimeoutTask: DispatchWorkItem?
    private var lifecycleTokens: [NSObjectProtocol] = []

    // MARK: - Init

    public init(url: URL, autoPlay: Bool = true, loop: Bool = true, loadTimeout: TimeInterval = 7) {
        self.autoPlay = autoPlay
        self.loop = loop
        self.loadTimeout = loadTimeout

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
        state.isPlaying ? pause() : play()
    }

    public func seek(to time: CMTime) {
        player.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
    }

    /// Pause and seek to the beginning — use for carousel items that reset on scroll-off.
    public func resetToStart() {
        pause()
        seek(to: .zero)
    }

    // MARK: - Private

    private func observePlayer() {
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
        guard let item else { return }
        itemStatusObservation = item.observe(\.status, options: [.new, .initial]) { [weak self] item, _ in
            DispatchQueue.main.async { self?.handle(itemStatus: item.status) }
        }
    }

    private func handle(itemStatus: AVPlayerItem.Status) {
        switch itemStatus {
        case .readyToPlay:
            loadTimeoutTask?.cancel()
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

    // MARK: - Test support

    func testOnly_setState(_ newState: BPKVideoPlayerState) {
        state = newState
    }
}
