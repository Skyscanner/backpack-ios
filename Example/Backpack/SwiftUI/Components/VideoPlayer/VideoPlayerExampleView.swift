//
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

import SwiftUI
import Backpack_SwiftUI

// MARK: - Sample URLs (replace with real assets)
private enum SampleVideo {
    // Skyscanner-hosted HLS test stream
    static let url = URL(string: "https://content.skyscnr.com/media/68afbd83-d09a-48e8-9821-90c117b8f842/593d0fe4-5459-4c43-beb9-49f9ce79d365.m3u8")!

}

// MARK: - Use case 1: GraphicPromo with video background + wired play/pause

struct VideoGraphicPromoExampleView: View {
    @StateObject private var controller = BPKVideoPlayerController(
        url: SampleVideo.url,
        autoPlay: true,
        loop: true
    )

    var body: some View {
        ScrollView {
            BPKGraphicPromo(
                headline: "There's always more to explore in Britain",
                background: {
                    BPKVideoPlayer(controller: controller) { _ in EmptyView() }
                },
                overlay: .linear(.high, .bottom),
                sponsorTitle: "In partnership with Skyland",
                partnerLogo: Image(decorative: "skyland"),
                sponsoredAccessibilityLabel: "Sponsored by Skyland",
                callToAction: .init(
                    accessibilityLabel: "Learn more about our sponsor",
                    onClick: { print("DSA info tapped") }
                )
            )
            .onTapGesture {
                controller.toggle()
            }
            .overlay(alignment: .topTrailing) {
                playPauseButton
                    .padding(.lg)
            }
            .overlay {
                if controller.isLoading {
                    BPKSpinner(.lg, style: .onDarkSurface)
                }
            }
            .padding(.horizontal, .md)
        }
    }

    private var playPauseButton: some View {
        Button(action: controller.toggle) {
            BPKIconView(controller.isPlaying ? .pause : .play, size: .large)
                .foregroundColor(.init(.textOnDarkColor))
                .padding(.md)
                .background(Color(.scrimColor).opacity(0.6))
                .clipShape(Circle())
        }
        .accessibilityLabel(controller.isPlaying ? "Pause video" : "Play video")
        .accessibilityValue(controller.isPlaying ? "Playing" : "Paused")
        .accessibilityHint("Toggles video playback")
    }
}

// MARK: - Use case 2: Fullscreen with custom UI overlay (placeholder)

struct VideoFullscreenExampleView: View {
    // When injected (use case 3), playback continues uninterrupted across the transition.
    // When nil (use case 2 standalone), owns its own controller.
    @StateObject private var ownedController = BPKVideoPlayerController(
        url: SampleVideo.url,
        autoPlay: true,
        loop: true
    )
    private let injectedController: BPKVideoPlayerController?

    init(controller: BPKVideoPlayerController? = nil) {
        self.injectedController = controller
    }

    private var activeController: BPKVideoPlayerController {
        injectedController ?? ownedController
    }

    var body: some View {
        ZStack {
            BPKVideoPlayer(controller: activeController) { _ in EmptyView() }
                .ignoresSafeArea()

            // Custom UI — TBD
            VStack {
                Spacer()
                Text("Custom UI — TBD")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.bottom, .xl)
            }
        }
        .background(Color.black)
    }
}

// MARK: - Use case 3: Continuous playback

struct VideoContinuousPlaybackExampleView: View {
    @StateObject private var sharedController = BPKVideoPlayerController(
        url: SampleVideo.url,
        autoPlay: true,
        loop: true
    )
    @State private var isFullscreenPresented = false

    var body: some View {
        ScrollView {
            BPKGraphicPromo(
                headline: "There's always more to explore in Britain",
                background: {
                    BPKVideoPlayer(controller: sharedController) { _ in EmptyView() }
                },
                overlay: .linear(.high, .bottom),
                sponsorTitle: "In partnership with Skyland",
                partnerLogo: Image(decorative: "skyland"),
                sponsoredAccessibilityLabel: "Sponsored by Skyland",
                callToAction: .init(
                    accessibilityLabel: "Learn more about our sponsor",
                    onClick: { print("DSA info tapped") }
                )
            )
            .onTapGesture {
                isFullscreenPresented = true
            }
            .padding(.horizontal, .md)
        }
        .sheet(isPresented: $isFullscreenPresented) {
            VideoFullscreenExampleView(controller: sharedController)
        }
    }
}


// MARK: - Previews

struct VideoPlayerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VideoGraphicPromoExampleView()
                .previewDisplayName("1 · GraphicPromo with video")

            VideoFullscreenExampleView()
                .previewDisplayName("2 · Fullscreen (placeholder)")

            VideoContinuousPlaybackExampleView()
                .previewDisplayName("3 · Continuous playback")
        }
    }
}
