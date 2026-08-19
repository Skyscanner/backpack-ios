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

// MARK: - Use case 0: Just video with default play/pause button

struct VideoDefaultExampleView: View {
    @StateObject private var controller = BPKVideoPlayerController(
        url: SampleVideo.url,
        autoPlay: true,
        loop: true
    )
    
    var body: some View {
        BPKVideoPlayer(
            url: SampleVideo.url
        )
        .controlsAccessibilityLabels(
            play: NSLocalizedString("VIDEO_PLAYER_PLAY", comment: "Accessibility label for the video player's play control."),
            pause: NSLocalizedString("VIDEO_PLAYER_PAUSE", comment: "Accessibility label for the video player's pause control.")
        )
        .aspectRatio(16/9, contentMode: .fit)
        .background(
            Rectangle()
                .foregroundColor(.surfaceSubtleColor)
        )
        .padding(.md)
    }
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
                if controller.state.isLoading {
                    BPKSpinner(.lg, style: .onDarkSurface)
                }
            }
            .padding(.horizontal, .md)
        }
    }

    private var playPauseButton: some View {
        Button(action: controller.toggle) {
            BPKIconView(controller.state.isPlaying ? .pause : .play, size: .large)
                .foregroundColor(.init(.textOnDarkColor))
                .padding(.md)
                .background(Color(.scrimColor).opacity(0.6))
                .clipShape(Circle())
        }
        .accessibilityLabel(controller.state.isPlaying ? "Pause video" : "Play video")
        .accessibilityValue(controller.state.isPlaying ? "Playing" : "Paused")
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

            Button(action: activeController.toggle) {
                BPKIconView(activeController.state.isPlaying ? .pause : .play, size: .large)
                    .foregroundColor(.textOnDarkColor)
                    .frame(width: 40, height: 40)
                    .background(.surfaceTintColor)
                    .clipShape(RoundedRectangle(cornerRadius: BPKCornerRadius.sm.value))
            }
            .accessibilityLabel(activeController.state.isPlaying ? "Pause video" : "Play video")
            .accessibilityValue(activeController.state.isPlaying ? "Playing" : "Paused")
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

// MARK: - Use case 4: Live playback progress

struct VideoProgressExampleView: View {
    @StateObject private var controller = BPKVideoPlayerController(
        url: SampleVideo.url,
        autoPlay: true,
        loop: true
    )
    @State private var progress: BPKVideoPlayerProgress?
    @State private var firedQuartiles: Set<Int> = []
    @State private var hasTriggeredViewEvent = false
    @State private var isProgressShown = true

    private let quartiles = [25, 50, 75, 100]

    var body: some View {
        Group {
            if #available(iOS 16.4, *) {
                video
                    .bpkBottomSheet(
                        isPresented: $isProgressShown,
                        peekHeight: 300,
                        contentMode: .medium(false),
                        title: "Live playback progress",
                        bottomSheetContent: {
                            progressHUD
                                .presentationBackground(.clear)
                        }
                    )
            } else {
                VStack(spacing: 0) {
                    video
                    progressHUD
                }
            }
        }
    }

    private var video: some View {
        ZStack(alignment: .topTrailing) {
            BPKVideoPlayer(controller: controller) { _ in EmptyView() }
                .onProgress(receive)
                .ignoresSafeArea()

            Button(action: controller.toggle) {
                BPKIconView(controller.state.isPlaying ? .pause : .play, size: .large)
                    .foregroundColor(.textOnDarkColor)
                    .padding(.md)
                    .background(Color(.scrimColor).opacity(0.7))
                    .clipShape(Circle())
            }
            .padding(.lg)
            .accessibilityLabel(controller.state.isPlaying ? "Pause video" : "Play video")
        }
        .background(.surfaceContrastColor)
    }

    private var progressHUD: some View {
        VStack(alignment: .leading, spacing: .base) {
            if let progress {
                HStack(spacing: .md) {
                    metric(title: "Play time", value: format(progress.playTime))
                    metric(title: "Duration", value: format(progress.duration))
                    metric(title: "Played", value: "\(Int(progress.fractionPlayed * 100))%")
                }

                BPKProgressBar(
                    max: 100,
                    stepped: false,
                    size: .small,
                    value: Float(progress.fractionPlayed * 100)
                )

                BPKText("Would fire", style: .heading5)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: .sm) {
                        BPKChip(
                            "View · 2s",
                            selected: hasTriggeredViewEvent,
                            onClick: {}
                        )

                        ForEach(quartiles, id: \.self) { quartile in
                            BPKChip(
                                "\(quartile)%",
                                selected: firedQuartiles.contains(quartile),
                                onClick: {}
                            )
                        }
                    }
                }

                BPKText(
                    "The view marker assumes the video is at least 50% visible. Markers fire once; looping keeps cumulative play time.",
                    style: .caption
                )
                .foregroundColor(.textSecondaryColor)
            } else {
                HStack(spacing: .md) {
                    BPKSpinner(.sm)
                    BPKText("Waiting for a finite video duration…", style: .bodyDefault)
                }
            }
        }
        .padding(.lg)
    }

    private func metric(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: .sm) {
            BPKText(title, style: .caption)
                .foregroundColor(.textSecondaryColor)
            BPKText(value, style: .heading4)
                .monospacedDigit()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func format(_ seconds: TimeInterval) -> String {
        String(format: "%.2fs", seconds)
    }

    private func receive(_ progress: BPKVideoPlayerProgress) {
        self.progress = progress
        if progress.playTime >= 2 {
            hasTriggeredViewEvent = true
        }
        for quartile in quartiles where progress.fractionPlayed >= Double(quartile) / 100 {
            firedQuartiles.insert(quartile)
        }
    }
}


// MARK: - Previews

struct VideoPlayerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VideoDefaultExampleView()
                .previewDisplayName("0 · Default controls")
            
            VideoGraphicPromoExampleView()
                .previewDisplayName("1 · GraphicPromo with video")

            VideoFullscreenExampleView()
                .previewDisplayName("2 · Fullscreen (placeholder)")

            VideoContinuousPlaybackExampleView()
                .previewDisplayName("3 · Continuous playback")

            VideoProgressExampleView()
                .previewDisplayName("4 · Live playback progress")
        }
    }
}
