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
        controller.testOnly_setState(event: .readyToPlay, isPlaying: false)
        assertSnapshot(videoContainer { BPKVideoPlayerDefaultControls(controller: controller) })
    }

    /// Default controls — nothing shown while loading (consumer owns poster/spinner).
    func test_defaultControls_loading() {
        let controller = BPKVideoPlayerController.stub()
        assertSnapshot(videoContainer { BPKVideoPlayerDefaultControls(controller: controller) })
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
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.1))
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
}

// MARK: - Test helpers

private extension BPKVideoPlayerController {
    static func stub() -> BPKVideoPlayerController {
        BPKVideoPlayerController(url: URL(string: "data:video/mp4,stub")!, autoPlay: false, loop: false)
    }
}
