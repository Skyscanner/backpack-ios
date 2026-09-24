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
    // StateObject preserves an injected shared controller for this view lifetime;
    // the fallback creates one only when fullscreen is opened standalone.
    @StateObject private var activeController: BPKVideoPlayerController

    init(controller: BPKVideoPlayerController? = nil) {
        _activeController = StateObject(
            wrappedValue: controller ?? BPKVideoPlayerController(
                url: SampleVideo.url,
                autoPlay: true,
                loop: true
            )
        )
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
            .overlay(alignment: .topTrailing) {
                muteButton
                    .padding(.lg)
            }
            .padding(.horizontal, .md)
        }
        .sheet(isPresented: $isFullscreenPresented) {
            VideoFullscreenExampleView(controller: sharedController)
        }
    }

    private var muteButton: some View {
        Button(action: sharedController.toggleMute) {
            BPKIconView(sharedController.isMuted ? .speakerMute : .speaker, size: .large)
                .foregroundColor(.init(.textOnDarkColor))
                .padding(.md)
                .background(Color(.scrimColor).opacity(0.6))
                .clipShape(Circle())
        }
        .accessibilityLabel(sharedController.isMuted ? "Unmute video" : "Mute video")
        .accessibilityValue(sharedController.isMuted ? "Muted" : "Unmuted")
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


// MARK: - Use case 5: Observability HUD (bytes transferred + typed error)
//
// Exercises the two new observability APIs added in MUON-2126:
//   • numberOfBytesTransferred — live CDN bytes, resets on each loop iteration
//   • BPKVideoPlayerError.code  — normalised error string for New Relic
//
// "Test timeout" creates a fresh controller with a 2-second load timeout pointed
// at the live HLS stream. If the stream loads before the deadline the test passes
// cleanly; if the network is unreachable or slow the controller will emit
// .failed(.loadTimeout) and the HUD will show the LOAD_TIMEOUT code.

private enum ObservabilityTestState {
    case idle
    case running(BPKVideoPlayerController)
    case result(BPKVideoPlayerError)
}

struct VideoObservabilityExampleView: View {
    @StateObject private var liveController = BPKVideoPlayerController(
        url: SampleVideo.url,
        autoPlay: true,
        loop: true
    )

    @State private var timeoutTestState: ObservabilityTestState = .idle
    @State private var timeoutController: BPKVideoPlayerController?

    var body: some View {
        ScrollView {
            VStack(spacing: BPKSpacing.lg) {
                BPKText("Live controller", style: .heading4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, BPKSpacing.lg)

                ZStack {
                    BPKVideoPlayer(controller: liveController) { _ in EmptyView() }
                        .aspectRatio(16 / 9, contentMode: .fit)
                        .background(Color(.surfaceContrastColor))
                    if liveController.state.isLoading {
                        BPKSpinner(.lg, style: .onDarkSurface)
                    }
                }

                observabilityHUD(
                    state: liveController.state,
                    bytes: liveController.numberOfBytesTransferred
                )
                .padding(.horizontal, BPKSpacing.lg)

                Divider()
                    .padding(.horizontal, BPKSpacing.lg)

                BPKText("Timeout test (2 s deadline)", style: .heading4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, BPKSpacing.lg)

                BPKText(
                    "Starts a fresh controller with a 2-second load timeout. " +
                    "On a slow or blocked connection it fires .loadTimeout; on a fast connection it loads cleanly.",
                    style: .caption
                )
                .foregroundColor(.textSecondaryColor)
                .padding(.horizontal, BPKSpacing.lg)

                timeoutTestBody
                    .padding(.horizontal, BPKSpacing.lg)
            }
            .padding(.vertical, BPKSpacing.lg)
        }
    }

    // MARK: - Timeout test

    @ViewBuilder
    private var timeoutTestBody: some View {
        switch timeoutTestState {
        case .idle:
            BPKButton("Start timeout test", action: startTimeoutTest)
                .frame(maxWidth: .infinity)

        case .running(let controller):
            VStack(alignment: .leading, spacing: BPKSpacing.md) {
                observabilityHUD(
                    state: controller.state,
                    bytes: controller.numberOfBytesTransferred
                )
                .onChange(of: controller.state) { state in
                    if case .failed(let error) = state {
                        timeoutTestState = .result(error)
                        timeoutController = nil
                    } else if case .playing = state {
                        timeoutTestState = .idle
                        timeoutController = nil
                    } else if case .readyToPlay = state {
                        timeoutTestState = .idle
                        timeoutController = nil
                    }
                }
            }

        case .result(let error):
            VStack(alignment: .leading, spacing: BPKSpacing.md) {
                HStack(spacing: BPKSpacing.sm) {
                    BPKIconView(.exclamationCircle, size: .small)
                        .foregroundColor(.statusDangerSpotColor)
                    BPKText("Timeout fired", style: .heading5)
                }
                metricRow(title: "Error code", value: error.code)
                BPKButton("Reset", action: { timeoutTestState = .idle })
                    .buttonStyle(.secondary)
            }
        }
    }

    // MARK: - Shared HUD

    private func observabilityHUD(
        state: BPKVideoPlayerState,
        bytes: Int64
    ) -> some View {
        VStack(alignment: .leading, spacing: BPKSpacing.base) {
            HStack(spacing: BPKSpacing.md) {
                metricRow(title: "State", value: stateLabel(state))
                metricRow(title: "Error code", value: errorCode(state))
            }
            metricRow(title: "Bytes transferred", value: formatBytes(bytes))

            if bytes > 0 {
                BPKProgressBar(
                    max: 5_000_000,
                    stepped: false,
                    size: .small,
                    value: Float(min(bytes, 5_000_000))
                )
            }

            BPKText(
                "Bytes reset on each loop iteration. Error code appears only in .failed state.",
                style: .caption
            )
            .foregroundColor(.textSecondaryColor)
        }
        .padding(BPKSpacing.base)
        .background(Color(.surfaceSubtleColor))
        .clipShape(RoundedRectangle(cornerRadius: BPKCornerRadius.md.value))
    }

    private func metricRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: BPKSpacing.sm) {
            BPKText(title, style: .caption)
                .foregroundColor(.textSecondaryColor)
            BPKText(value, style: .heading5)
                .monospacedDigit()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Helpers

    private func startTimeoutTest() {
        let controller = BPKVideoPlayerController(
            url: SampleVideo.url,
            autoPlay: false,
            loop: false,
            loadTimeout: 2
        )
        timeoutController = controller
        timeoutTestState = .running(controller)
        controller.play()
    }

    private func stateLabel(_ state: BPKVideoPlayerState) -> String {
        switch state {
        case .loading: "loading"
        case .readyToPlay: "readyToPlay"
        case .playing: "playing"
        case .paused: "paused"
        case .buffering: "buffering"
        case .failed: "failed"
        }
    }

    private func errorCode(_ state: BPKVideoPlayerState) -> String {
        if case .failed(let error) = state { return error.code }
        return "—"
    }

    private func formatBytes(_ bytes: Int64) -> String {
        guard bytes > 0 else { return "0 B" }
        if bytes >= 1_048_576 {
            return String(format: "%.1f MB", Double(bytes) / 1_048_576)
        } else if bytes >= 1_024 {
            return String(format: "%.1f KB", Double(bytes) / 1_024)
        } else {
            return "\(bytes) B"
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

            VideoObservabilityExampleView()
                .previewDisplayName("5 · Observability HUD")
        }
    }
}
