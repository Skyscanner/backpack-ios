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

/// Shareable player controller. Owns one AVPlayer instance and can be injected
/// into multiple views simultaneously for continuous playback across transitions.
public final class BPKVideoPlayerController: ObservableObject {
    public let player: AVPlayer

    @Published public private(set) var isPlaying: Bool = false
    @Published public private(set) var event: BPKVideoPlayerEvent = .loading

    /// True while the video is loading or rebuffering — use to drive a spinner.
    public var isLoading: Bool {
        event == .loading || event == .buffering
    }

    private let shouldAutoPlay: Bool
    private let shouldLoop: Bool
    private let loadTimeout: TimeInterval

    private var playerLooper: AVPlayerLooper?
    private var currentItemObservation: NSKeyValueObservation?
    private var statusObservation: NSKeyValueObservation?
    private var timeControlObservation: NSKeyValueObservation?
    private var reduceMotionObserver: NSObjectProtocol?
    private var foregroundObserver: NSObjectProtocol?
    private var backgroundObserver: NSObjectProtocol?
    private var eventHandlers: [(BPKVideoPlayerEvent) -> Void] = []
    private var loadTimeoutTask: DispatchWorkItem?

    // Tracks whether we were playing before backgrounding so foreground resume
    // works correctly — pause() sets isPlaying = false via timeControlStatus,
    // which would otherwise prevent the foreground resume guard from firing.
    private var wasPlayingBeforeBackground = false

    // MARK: - Init

    public init(url: URL, autoPlay: Bool = true, loop: Bool = true, loadTimeout: TimeInterval = 7) {
        self.shouldAutoPlay = autoPlay
        self.shouldLoop = loop
        self.loadTimeout = loadTimeout

        let asset = AVAsset(url: url)
        let templateItem = AVPlayerItem(asset: asset)

        if loop {
            let queuePlayer = AVQueuePlayer()
            self.player = queuePlayer
            // AVPlayerLooper manages its own item copies — observe currentItem instead
            self.playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: templateItem)
        } else {
            self.player = AVPlayer(playerItem: templateItem)
        }

        setupObservations()
        setupReduceMotionObserver()
        configureAudioSession()
        setupLifecycleObservers()
    }

    deinit {
        currentItemObservation?.invalidate()
        statusObservation?.invalidate()
        timeControlObservation?.invalidate()
        [reduceMotionObserver, foregroundObserver, backgroundObserver]
            .compactMap { $0 }
            .forEach { NotificationCenter.default.removeObserver($0) }
        // Do NOT call setActive(false) here — the audio session is process-wide
        // and deactivating it would affect other controllers and unrelated audio.
    }

    // MARK: - Public controls

    /// Start playback. No-op when reduce motion is enabled.
    public func play() {
        guard !UIAccessibility.isReduceMotionEnabled else { return }
        player.play()
    }

    /// Pause playback.
    public func pause() {
        player.pause()
    }

    /// Toggle between play and pause.
    public func toggle() {
        isPlaying ? pause() : play()
    }

    /// Seek to a specific time.
    public func seek(to time: CMTime) {
        player.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
    }

    /// Pause and seek back to the beginning. Useful for carousel items that should
    /// show the first frame when they scroll back into view.
    public func resetToStart() {
        pause()
        seek(to: .zero)
    }

    /// Register a handler called on every event. Multiple handlers are all called.
    public func addEventHandler(_ handler: @escaping (BPKVideoPlayerEvent) -> Void) {
        eventHandlers.append(handler)
    }

    // MARK: - Internal (called by PlayerLayerView)

    /// Called by `PlayerLayerView` when `AVPlayerLayer.isReadyForDisplay` first becomes true.
    func notifyFirstFrameRendered() {
        emit(.firstFrameRendered)
    }

    // MARK: - Private setup

    private func setupObservations() {
        currentItemObservation = player.observe(\.currentItem, options: [.new, .initial]) { [weak self] player, _ in
            DispatchQueue.main.async {
                self?.observeCurrentItemStatus(player.currentItem)
            }
        }

        timeControlObservation = player.observe(\.timeControlStatus, options: [.new]) { [weak self] player, _ in
            DispatchQueue.main.async {
                self?.handleTimeControlStatus(player.timeControlStatus)
            }
        }
    }

    private func observeCurrentItemStatus(_ item: AVPlayerItem?) {
        statusObservation?.invalidate()
        guard let item else { return }

        statusObservation = item.observe(\.status, options: [.new, .initial]) { [weak self] item, _ in
            DispatchQueue.main.async {
                self?.handleItemStatus(item.status)
            }
        }
    }

    private func setupReduceMotionObserver() {
        reduceMotionObserver = NotificationCenter.default.addObserver(
            forName: UIAccessibility.reduceMotionStatusDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            if UIAccessibility.isReduceMotionEnabled {
                self?.pause()
            }
        }
    }

    private func configureAudioSession() {
        // Use .ambient so the player does not interrupt the user's background music.
        // We only set the category — we do not call setActive(false) on deinit because
        // the session is process-wide and deactivating it would affect other audio.
        try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    private func setupLifecycleObservers() {
        backgroundObserver = NotificationCenter.default.addObserver(
            forName: UIScene.didEnterBackgroundNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            // Snapshot isPlaying before pausing — pause() will set it to false
            // via timeControlStatus, which would break the foreground resume guard.
            self.wasPlayingBeforeBackground = self.isPlaying
            self.pause()
        }

        foregroundObserver = NotificationCenter.default.addObserver(
            forName: UIScene.willEnterForegroundNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self, self.wasPlayingBeforeBackground else { return }
            self.wasPlayingBeforeBackground = false
            self.play()
        }
    }

    private func handleItemStatus(_ status: AVPlayerItem.Status) {
        switch status {
        case .readyToPlay:
            loadTimeoutTask?.cancel()
            emit(.readyToPlay)
            if shouldAutoPlay && !UIAccessibility.isReduceMotionEnabled {
                play()
            }
        case .failed:
            loadTimeoutTask?.cancel()
            let error = player.currentItem?.error ?? NSError(domain: "BPKVideoPlayer", code: -1)
            emit(.failed(error))
        case .unknown:
            emit(.loading)
            scheduleLoadTimeout()
        @unknown default:
            break
        }
    }

    private func handleTimeControlStatus(_ status: AVPlayer.TimeControlStatus) {
        switch status {
        case .playing:
            isPlaying = true
            emit(.playing)
        case .paused:
            isPlaying = false
            if event == .playing { emit(.paused) }
        case .waitingToPlayAtSpecifiedRate:
            emit(.buffering)
        @unknown default:
            break
        }
    }

    private func scheduleLoadTimeout() {
        loadTimeoutTask?.cancel()
        guard loadTimeout > 0 else { return }
        let task = DispatchWorkItem { [weak self] in
            guard let self, self.event == .loading || self.event == .buffering else { return }
            self.emit(.failed(NSError(
                domain: "BPKVideoPlayer",
                code: NSURLErrorTimedOut,
                userInfo: [NSLocalizedDescriptionKey: "Video load timed out"]
            )))
        }
        loadTimeoutTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + loadTimeout, execute: task)
    }

    private func emit(_ newEvent: BPKVideoPlayerEvent) {
        event = newEvent
        eventHandlers.forEach { $0(newEvent) }
    }

    /// Test-only — forces published state for snapshot testing without AVFoundation.
    func testOnly_setState(event: BPKVideoPlayerEvent, isPlaying: Bool) {
        self.event = event
        self.isPlaying = isPlaying
    }
}
