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

final class BPKVideoPlayerTests: XCTestCase {

    // MARK: - PlayerLayerView: initial configuration

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

    // MARK: - PlayerLayerView: first frame callback

    func test_playerLayerView_onFirstFrameRendered_firesOnce() {
        let sut = PlayerLayerView()
        var callCount = 0
        sut.onFirstFrameRendered = { callCount += 1 }

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
        // Opacity is set inside a CATransaction — model value is 1 immediately after commit.
        XCTAssertEqual(sut.playerLayer.opacity, 1)
    }

    // MARK: - PlayerLayerView: layout

    func test_playerLayerView_frameMatchesBoundsAfterLayout() {
        let sut = PlayerLayerView(frame: CGRect(x: 0, y: 0, width: 375, height: 500))
        sut.layoutIfNeeded()
        XCTAssertEqual(sut.playerLayer.frame, sut.bounds)
    }

}
