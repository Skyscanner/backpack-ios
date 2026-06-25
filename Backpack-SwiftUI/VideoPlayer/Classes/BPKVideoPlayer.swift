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

/// A SwiftUI video player. By default it shows built-in play/pause controls
/// and a loading spinner. Pass a custom `overlay` closure to replace them with
/// your own UI — the controller is passed in so you can wire up your controls.
///
/// ```swift
/// // Simple — built-in controls
/// BPKVideoPlayer(url: videoURL)
///
/// // Shared controller — for continuous playback across transitions
/// BPKVideoPlayer(controller: sharedController)
///
/// // Custom overlay — e.g. as a BPKGraphicPromo background
/// BPKVideoPlayer(controller: sharedController) { ctrl in
///     MyPlayPauseButton(isPlaying: ctrl.isPlaying, onTap: ctrl.toggle)
/// }
///
/// // No controls at all
/// BPKVideoPlayer(url: videoURL) { _ in EmptyView() }
/// ```
public struct BPKVideoPlayer<Overlay: View>: View {
    @StateObject private var controller: BPKVideoPlayerController
    private let overlay: (BPKVideoPlayerController) -> Overlay

    // MARK: - URL-based inits

    /// Creates a video player with built-in controls that owns its own controller.
    public init(url: URL, autoPlay: Bool = false, loop: Bool = false)
    where Overlay == BPKVideoPlayerDefaultControls {
        _controller = StateObject(wrappedValue: BPKVideoPlayerController(url: url, autoPlay: autoPlay, loop: loop))
        self.overlay = { BPKVideoPlayerDefaultControls(controller: $0) }
    }

    /// Creates a video player with a custom overlay that owns its own controller.
    ///
    /// The `overlay` closure receives the live controller so you can bind
    /// your own play/pause UI directly. Return `EmptyView()` for no controls.
    public init(
        url: URL,
        autoPlay: Bool = false,
        loop: Bool = false,
        @ViewBuilder overlay: @escaping (BPKVideoPlayerController) -> Overlay
    ) {
        _controller = StateObject(wrappedValue: BPKVideoPlayerController(url: url, autoPlay: autoPlay, loop: loop))
        self.overlay = overlay
    }

    // MARK: - Shared-controller inits

    /// Creates a video player with built-in controls using a shared controller.
    ///
    /// Use this when you need continuous playback across view transitions — pass
    /// the same `BPKVideoPlayerController` instance into multiple `BPKVideoPlayer` views.
    public init(controller: BPKVideoPlayerController) where Overlay == BPKVideoPlayerDefaultControls {
        _controller = StateObject(wrappedValue: controller)
        self.overlay = { BPKVideoPlayerDefaultControls(controller: $0) }
    }

    /// Creates a video player with a custom overlay using a shared controller.
    public init(
        controller: BPKVideoPlayerController,
        @ViewBuilder overlay: @escaping (BPKVideoPlayerController) -> Overlay
    ) {
        _controller = StateObject(wrappedValue: controller)
        self.overlay = overlay
    }

    // MARK: - Body

    public var body: some View {
        ZStack {
            BPKVideoPlayerRenderingSurface(controller: controller)
            overlay(controller)
        }
    }
}

// MARK: - Default controls

/// The built-in play/pause button and loading spinner shown by `BPKVideoPlayer`
/// when no custom overlay is provided.
public struct BPKVideoPlayerDefaultControls: View {
    @ObservedObject public var controller: BPKVideoPlayerController

    public var body: some View {
        if controller.isLoading {
            BPKSpinner(.lg, style: .onDarkSurface)
                .accessibilityLabel("Loading video")
        } else {
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
}

// MARK: - Rendering surface (internal)

/// Internal UIViewRepresentable that hosts AVPlayerLayer inside SwiftUI.
///
/// AVPlayerLayer is a CALayer subclass and must live inside a UIView to participate
/// in Core Animation. This is the standard bridge pattern for CALayer content.
///
/// The layer starts invisible (opacity 0) to prevent the black frame that appears
/// while HLS loads its first segment. AVPlayerLayer.isReadyForDisplay is the only
/// reliable signal that a decoded frame is ready — the layer fades in at that point
/// and the controller emits .firstFrameRendered so consumers can hide poster images
/// without a visible flash.
struct BPKVideoPlayerRenderingSurface: UIViewRepresentable {
    let controller: BPKVideoPlayerController

    func makeUIView(context: Context) -> PlayerLayerView {
        let view = PlayerLayerView()
        view.playerLayer.player = controller.player
        view.onFirstFrameRendered = { [weak controller] in
            controller?.notifyFirstFrameRendered()
        }
        return view
    }

    func updateUIView(_ uiView: PlayerLayerView, context: Context) {
        uiView.playerLayer.player = controller.player
    }
}

// MARK: - PlayerLayerView

final class PlayerLayerView: UIView {
    override class var layerClass: AnyClass { AVPlayerLayer.self }

    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer } // swiftlint:disable:this force_cast

    /// Called exactly once when the first video frame is visible on screen.
    var onFirstFrameRendered: (() -> Void)?

    private var readyForDisplayObservation: NSKeyValueObservation?
    private var hasNotifiedFirstFrame = false

    override init(frame: CGRect) {
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

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }

    override func layoutSubviews() {
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
