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

import Foundation
import XCTest
import SwiftUI
@testable import Backpack_SwiftUI

final class BPKVideoPlayerTests: XCTestCase {

    // MARK: - Snapshot: overlay UI
    //
    // Video surface replaced with a solid colour — tests overlay layout and
    // appearance, not video rendering.

    /// Default controls — play button visible once video is ready (paused state).
    func test_defaultControls_paused() {
        let controller = BPKVideoPlayerController.stub()
        controller.testOnly_setState(.readyToPlay)
        assertSnapshot(videoContainer {
            BPKVideoPlayerDefaultControls(controller: controller)
                .controlsAccessibilityLabels(play: "Play", pause: "Pause")
        })
    }

    /// Default controls — nothing shown while loading (consumer owns poster/spinner).
    func test_defaultControls_loading() {
        let controller = BPKVideoPlayerController.stub()
        assertSnapshot(videoContainer {
            BPKVideoPlayerDefaultControls(controller: controller)
                .controlsAccessibilityLabels(play: "Play", pause: "Pause")
        })
    }

    // MARK: - Controller playback state

    func test_loopingPlayback_remainsPlayingWhenCurrentItemChanges() async throws {
        let controller = BPKVideoPlayerController(
            url: try localVideoURL(),
            autoPlay: false,
            loop: true
        )

        try await waitUntil { controller.state == .readyToPlay }
        let initialItem = try XCTUnwrap(controller.player.currentItem)

        controller.play()

        try await waitUntil { controller.player.currentItem !== initialItem }
        try await waitUntil { controller.state.isPlaying }

        XCTAssertEqual(controller.player.timeControlStatus, .playing)
        XCTAssertTrue(controller.state.isPlaying)
    }

    func test_loopingPlayback_staysPausedAfterExplicitPauseAtLoopBoundary() async throws {
        let controller = BPKVideoPlayerController(
            url: try localVideoURL(),
            autoPlay: true,
            loop: true
        )

        try await waitUntil { controller.state.isPlaying }
        let initialItem = try XCTUnwrap(controller.player.currentItem)
        try await waitUntil { controller.player.currentItem !== initialItem && controller.state.isPlaying }

        controller.pause()

        try await waitUntil { controller.state == .paused }
        try await Task.sleep(nanoseconds: 250_000_000)

        XCTAssertEqual(controller.player.timeControlStatus, .paused)
        XCTAssertEqual(controller.state, .paused)
    }

    /// Custom overlay — consumer-provided control in the bottom-trailing corner.
    func test_customOverlay_cornerControl() {
        assertSnapshot(videoContainer {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        BPKIconView(.play, size: .large)
                            .foregroundColor(.textOnDarkColor)
                            .frame(width: 40, height: 40)
                            .background(.surfaceTintColor)
                            .clipShape(RoundedRectangle(cornerRadius: BPKCornerRadius.sm.value))
                    }
                    .accessibilityLabel("Play video")
                    .padding(.base)
                }
            }
        })
    }

    // MARK: - Private

    private func videoContainer<Overlay: View>(@ViewBuilder _ overlay: () -> Overlay) -> some View {
        ZStack {
            Color(.surfaceHighlightColor)
            overlay()
        }
        .frame(width: 375, height: 500)
    }

    private func localVideoURL() throws -> URL {
        guard let bundle = TestsBundle.bundle,
              let url = bundle.url(forResource: "skyscanner_test", withExtension: "mp4") else {
            throw XCTSkip("skyscanner_test.mp4 not found in test bundle")
        }
        return url
    }

    private func waitUntil(
        _ condition: @escaping () -> Bool,
        timeout: TimeInterval = 5
    ) async throws {
        let deadline = Date().addingTimeInterval(timeout)
        while !condition() {
            if Date() >= deadline {
                XCTFail("Timed out waiting for video-player state")
                return
            }
            try await Task.sleep(nanoseconds: 50_000_000)
        }
    }

}

// MARK: - Test helpers

private extension BPKVideoPlayerController {
    static func stub() -> BPKVideoPlayerController {
        BPKVideoPlayerController(url: URL(string: "data:video/mp4,stub")!, autoPlay: false, loop: false)
    }
}
