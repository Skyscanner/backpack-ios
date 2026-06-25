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
import SwiftUI

// MARK: - BPKVideoPlayer

/// A SwiftUI video player with built-in play/pause controls and a loading spinner.
///
/// Pass a `BPKVideoPlayerController` to drive playback and observe events.
/// The controller is an `ObservableObject` — it can be shared across multiple
/// views simultaneously, enabling continuous playback across transitions
/// (e.g. a card expanding into a fullscreen sheet without resetting playback).
///
/// ```swift
/// @StateObject private var controller = BPKVideoPlayerController(
///     url: videoURL, autoPlay: true, loop: true
/// )
///
/// BPKVideoPlayer(controller: controller)
/// ```
///
/// To suppress the built-in controls (e.g. when embedding inside `BPKGraphicPromo`
/// with custom overlays), use `BPKVideoPlayerSurface` directly.
public struct BPKVideoPlayer: View {
    @StateObject private var controller: BPKVideoPlayerController
    private let showDefaultControls: Bool

    /// Creates a video player that owns its controller.
    /// - Parameters:
    ///   - url: The video URL to play.
    ///   - autoPlay: Start playback as soon as the video is ready. Default `false`.
    ///   - loop: Loop the video continuously. Default `false`.
    ///   - showDefaultControls: Show the built-in play/pause button and loading spinner. Default `true`.
    public init(
        url: URL,
        autoPlay: Bool = false,
        loop: Bool = false,
        showDefaultControls: Bool = true
    ) {
        _controller = StateObject(wrappedValue: BPKVideoPlayerController(
            url: url,
            autoPlay: autoPlay,
            loop: loop
        ))
        self.showDefaultControls = showDefaultControls
    }

    /// Creates a video player with an externally owned controller.
    ///
    /// Use this when you need to share a controller across multiple views
    /// for continuous playback across transitions. The controller retains
    /// its own `autoPlay` and `loop` settings.
    /// - Parameters:
    ///   - controller: A `BPKVideoPlayerController` instance to drive playback.
    ///   - showDefaultControls: Show the built-in play/pause button and loading spinner. Default `true`.
    public init(controller: BPKVideoPlayerController, showDefaultControls: Bool = true) {
        _controller = StateObject(wrappedValue: controller)
        self.showDefaultControls = showDefaultControls
    }

    public var body: some View {
        ZStack {
            BPKVideoPlayerSurface(controller: controller)

            if showDefaultControls {
                if controller.isLoading {
                    BPKSpinner(.lg, style: .onDarkSurface)
                        .accessibilityLabel("Loading video")
                } else {
                    playPauseButton
                }
            }
        }
    }

    private var playPauseButton: some View {
        Button(action: controller.toggle) {
            BPKIconView(controller.isPlaying ? .pause : .play, size: .large)
                .foregroundColor(.init(.textOnDarkColor))
                .padding(.sm)
                .background(Color(.scrimColor).opacity(0.6))
                .clipShape(Circle())
        }
        .accessibilityLabel(controller.isPlaying ? "Pause video" : "Play video")
        .accessibilityValue(controller.isPlaying ? "Playing" : "Paused")
        .accessibilityHint("Toggles video playback")
    }
}

// MARK: - BPKVideoPlayerSurface

/// The raw video rendering surface — scale-to-fill, freeform sizing, no built-in controls.
///
/// Use this when you need full control over the overlay UI, for example when
/// embedding video as the background of a `BPKGraphicPromo`. For standard use
/// with built-in play/pause controls, prefer `BPKVideoPlayer`.
///
/// ### Why `UIViewRepresentable`?
/// `AVPlayerLayer` is a `CALayer` subclass — it must be hosted in a `UIView`
/// to integrate with Core Animation. The `UIViewRepresentable` bridge is the
/// standard SwiftUI pattern for this.
///
/// ### First-frame handling
/// The layer starts with `opacity = 0` to prevent the black frame that appears
/// while HLS loads its first segment. `AVPlayerLayer.isReadyForDisplay` is the
/// only reliable signal that a decoded frame is ready to show — the layer fades in
/// at that point, and the controller emits `.firstFrameRendered` so consumers
/// can hide any poster image without a flash.
public struct BPKVideoPlayerSurface: UIViewRepresentable {
    private let controller: BPKVideoPlayerController

    public init(controller: BPKVideoPlayerController) {
        self.controller = controller
    }

    public func makeUIView(context: Context) -> PlayerLayerView {
        let view = PlayerLayerView()
        view.playerLayer.player = controller.player
        view.onFirstFrameRendered = { [weak controller] in
            controller?.notifyFirstFrameRendered()
        }
        return view
    }

    public func updateUIView(_ uiView: PlayerLayerView, context: Context) {
        uiView.playerLayer.player = controller.player
    }
}

// MARK: - PlayerLayerView

public final class PlayerLayerView: UIView {
    override public class var layerClass: AnyClass { AVPlayerLayer.self }

    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer } // swiftlint:disable:this force_cast

    /// Called exactly once when the first video frame is visible on screen.
    var onFirstFrameRendered: (() -> Void)?

    private var readyForDisplayObservation: NSKeyValueObservation?
    private var hasNotifiedFirstFrame = false

    override public init(frame: CGRect) {
        super.init(frame: frame)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.opacity = 0
        clipsToBounds = true
        observeReadyForDisplay()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    deinit {
        readyForDisplayObservation?.invalidate()
    }

    override public var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        // Disable implicit CALayer animation so the frame snaps to fill immediately
        // rather than interpolating from the video's native size (causes letterbox hiccup).
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        playerLayer.frame = bounds
        CATransaction.commit()
    }

    private func observeReadyForDisplay() {
        readyForDisplayObservation = playerLayer.observe(\.isReadyForDisplay, options: [.new]) { [weak self] layer, _ in
            guard layer.isReadyForDisplay else { return }
            DispatchQueue.main.async {
                self?.handleFirstFrameReady()
            }
        }
    }

    private func handleFirstFrameReady() {
        guard !hasNotifiedFirstFrame else { return }
        hasNotifiedFirstFrame = true
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.15)
        playerLayer.opacity = 1
        CATransaction.commit()
        onFirstFrameRendered?()
    }

    /// Test-only hook — simulates `isReadyForDisplay` becoming true without AVFoundation.
    func simulateFirstFrameReady() {
        handleFirstFrameReady()
    }
}
