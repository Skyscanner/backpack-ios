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

/// Scale-to-fill video surface with no enforced aspect ratio.
/// Pair with BPKVideoPlayerController for playback control.
public struct BPKVideoPlayer: UIViewRepresentable {
    private let controller: BPKVideoPlayerController

    public init(controller: BPKVideoPlayerController) {
        self.controller = controller
    }

    public func makeUIView(context: Context) -> PlayerLayerView {
        let view = PlayerLayerView()
        view.playerLayer.player = controller.player
        view.playerLayer.videoGravity = .resizeAspectFill
        view.clipsToBounds = true
        // Wire isReadyForDisplay → controller so it can emit .firstFrameRendered
        view.onFirstFrameRendered = { [weak controller] in
            controller?.notifyFirstFrameRendered()
        }
        return view
    }

    public func updateUIView(_ uiView: PlayerLayerView, context: Context) {
        uiView.playerLayer.player = controller.player
    }
}

public final class PlayerLayerView: UIView {
    override public class var layerClass: AnyClass { AVPlayerLayer.self }

    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer } // swiftlint:disable:this force_cast

    /// Called exactly once when the first video frame is visible on screen.
    var onFirstFrameRendered: (() -> Void)?

    private var readyForDisplayObservation: NSKeyValueObservation?
    private var hasNotifiedFirstFrame = false

    override public init(frame: CGRect) {
        super.init(frame: frame)
        // Start invisible — fade in only once the first frame is decoded.
        // This prevents black bars caused by AVPlayerLayer having presentationSize = .zero
        // before the HLS manifest and first segment are loaded.
        playerLayer.opacity = 0
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
