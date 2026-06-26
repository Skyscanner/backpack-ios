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

/// A SwiftUI video player. By default it shows built-in play/pause controls.
/// Pass a custom `overlay` closure to replace them with your own UI — the
/// controller is passed in so you can wire up your controls directly.
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
    // @ObservedObject is correct for both cases.
    // - URL-based: the controller is created in init and retained by the ObservedObject wrapper
    // - Shared: the caller owns the controller; StateObject would ignore subsequent init changes
    @ObservedObject private var controller: BPKVideoPlayerController
    private let overlay: (BPKVideoPlayerController) -> Overlay

    // MARK: - URL-based inits

    /// Creates a video player with built-in controls that owns its own controller.
    public init(url: URL, autoPlay: Bool = false, loop: Bool = false)
    where Overlay == BPKVideoPlayerDefaultControls {
        _controller = ObservedObject(wrappedValue: BPKVideoPlayerController(url: url, autoPlay: autoPlay, loop: loop))
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
        _controller = ObservedObject(wrappedValue: BPKVideoPlayerController(url: url, autoPlay: autoPlay, loop: loop))
        self.overlay = overlay
    }

    // MARK: - Shared-controller inits

    /// Creates a video player with built-in controls using a shared controller.
    ///
    /// Use this when you need continuous playback across view transitions — pass
    /// the same `BPKVideoPlayerController` instance into multiple `BPKVideoPlayer` views.
    public init(controller: BPKVideoPlayerController) where Overlay == BPKVideoPlayerDefaultControls {
        _controller = ObservedObject(wrappedValue: controller)
        self.overlay = { BPKVideoPlayerDefaultControls(controller: $0) }
    }

    /// Creates a video player with a custom overlay using a shared controller.
    public init(
        controller: BPKVideoPlayerController,
        @ViewBuilder overlay: @escaping (BPKVideoPlayerController) -> Overlay
    ) {
        _controller = ObservedObject(wrappedValue: controller)
        self.overlay = overlay
    }

    // MARK: - Body

    public var body: some View {
        ZStack {
            BPKVideoPlayerRenderingSurface(player: controller.player)
            overlay(controller)
        }
    }
}

// MARK: - Default controls

/// The built-in play/pause button shown by `BPKVideoPlayer` when no custom overlay
/// is provided. Hidden while the video is loading — visible once ready.
public struct BPKVideoPlayerDefaultControls: View {
    @ObservedObject public var controller: BPKVideoPlayerController

    public var body: some View {
        if !controller.isLoading {
            Button(action: controller.toggle) {
                BPKIconView(controller.isPlaying ? .pause : .play, size: .large)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: BPKCornerRadius.sm.value))
            }
            .accessibilityLabel(controller.isPlaying ? "Pause video" : "Play video")
            .accessibilityValue(controller.isPlaying ? "Playing" : "Paused")
            .accessibilityHint("Toggles video playback")
            .padding(.base)
        }
    }
}

// MARK: - Rendering surface (internal)

/// Hosts an AVPlayerLayer as a sublayer of a plain UIView — the same approach
/// used in the Marketing Opt-in and Hotels video implementations in the main app.
/// AVPlayerLayer is a CALayer and must be embedded in a UIView for Core Animation.
struct BPKVideoPlayerRenderingSurface: UIViewRepresentable {
    let player: AVPlayer

    func makeUIView(context: Context) -> VideoSurfaceView {
        VideoSurfaceView(player: player)
    }

    func updateUIView(_ uiView: VideoSurfaceView, context: Context) {
        uiView.playerLayer.player = player
    }
}

/// Plain UIView that keeps its AVPlayerLayer sublayer sized to bounds.
final class VideoSurfaceView: UIView {
    let playerLayer: AVPlayerLayer

    init(player: AVPlayer) {
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        super.init(frame: .zero)
        clipsToBounds = true
        layer.addSublayer(playerLayer)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
