/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

final class FoldAvoidanceTests: XCTestCase {
    // The iPhone Duo's inner display in landscape, half folded like a book: the fold runs down the middle.
    private let window = CGSize(width: 951, height: 669)
    private let verticalFold = CGRect(x: 465, y: 0, width: 21, height: 669)
    // The same display in portrait, half folded like a laptop: the fold runs across the middle.
    private let portraitWindow = CGSize(width: 669, height: 951)
    private let horizontalFold = CGRect(x: 0, y: 465, width: 669, height: 21)

    func test_whenThereIsNoFold_thenContentKeepsTheWholeWindow() {
        let insets = FoldAvoidance.insets(avoiding: nil, in: window, side: .leading)

        XCTAssertEqual(insets, EdgeInsets())
    }

    func test_whenFoldIsVertical_thenLeadingSideKeepsTheLeftHalf() {
        let insets = FoldAvoidance.insets(avoiding: verticalFold, in: window, side: .leading)

        XCTAssertEqual(insets, EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 951 - 465))
    }

    func test_whenFoldIsVertical_thenTrailingSideKeepsTheRightHalf() {
        let insets = FoldAvoidance.insets(avoiding: verticalFold, in: window, side: .trailing)

        XCTAssertEqual(insets, EdgeInsets(top: 0, leading: 465 + 21, bottom: 0, trailing: 0))
    }

    func test_whenFoldIsHorizontal_thenLeadingSideKeepsTheTopHalf() {
        let insets = FoldAvoidance.insets(avoiding: horizontalFold, in: portraitWindow, side: .leading)

        XCTAssertEqual(insets, EdgeInsets(top: 0, leading: 0, bottom: 951 - 465, trailing: 0))
    }

    func test_whenFoldIsHorizontal_thenTrailingSideKeepsTheBottomHalf() {
        let insets = FoldAvoidance.insets(avoiding: horizontalFold, in: portraitWindow, side: .trailing)

        XCTAssertEqual(insets, EdgeInsets(top: 465 + 21, leading: 0, bottom: 0, trailing: 0))
    }
}
