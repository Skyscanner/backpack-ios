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
import AVFoundation
@testable import Backpack_SwiftUI

/// Tests for PlayerLayerView configuration — Approach A from the test strategy doc.
/// These verify the properties that prevent letterboxing and black flashes without
/// requiring async AVFoundation decoding.
final class BPKVideoPlayerTests: XCTestCase {

    // MARK: - Initial state

    func test_playerLayerView_startsInvisible() {
        let sut = PlayerLayerView()
        XCTAssertEqual(sut.playerLayer.opacity, 0, "Layer must be invisible until first frame to prevent black flash")
    }

    func test_playerLayerView_gravityIsAspectFill() {
        let sut = PlayerLayerView()
        XCTAssertEqual(sut.playerLayer.videoGravity, .resizeAspectFill, "Scale-to-fill is a hard requirement")
    }

    func test_playerLayerView_clipsSubviews() {
        let sut = PlayerLayerView()
        XCTAssertTrue(sut.clipsToBounds, "Must clip to prevent video bleeding outside its container")
    }

    func test_playerLayerView_intrinsicSizeIsNoMetric() {
        let sut = PlayerLayerView()
        XCTAssertEqual(sut.intrinsicContentSize.width, UIView.noIntrinsicMetric)
        XCTAssertEqual(sut.intrinsicContentSize.height, UIView.noIntrinsicMetric)
    }

    // MARK: - First frame callback

    func test_playerLayerView_onFirstFrameRendered_firesOnce() {
        let sut = PlayerLayerView()
        var callCount = 0
        sut.onFirstFrameRendered = { callCount += 1 }

        // Simulate isReadyForDisplay becoming true by calling notifyFirstFrame directly
        // We can't trigger AVPlayerLayer rendering in unit tests, so we test the
        // callback wiring via the internal hook instead.
        sut.simulateFirstFrameReady()

        XCTAssertEqual(callCount, 1)

        // Second call must be a no-op — guard against double-emit
        sut.simulateFirstFrameReady()
        XCTAssertEqual(callCount, 1, "onFirstFrameRendered must fire exactly once")
    }

    func test_playerLayerView_becomesVisibleAfterFirstFrame() {
        let sut = PlayerLayerView()
        XCTAssertEqual(sut.playerLayer.opacity, 0)

        sut.simulateFirstFrameReady()

        // Opacity is set inside a CATransaction with 0.15s duration — after
        // the transaction commits the model value is 1 even before the animation ends.
        XCTAssertEqual(sut.playerLayer.opacity, 1)
    }

    // MARK: - Layout

    func test_playerLayerView_frameMatchesBoundsAfterLayout() {
        let sut = PlayerLayerView(frame: CGRect(x: 0, y: 0, width: 375, height: 500))
        sut.layoutIfNeeded()
        XCTAssertEqual(sut.playerLayer.frame, sut.bounds)
    }
}
