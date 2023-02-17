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
import Backpack

class BPKShareCardButtonTest: XCTestCase {
    func testInitWithDefaultStyleAndSize() {
        // Given
        let stubAccessibilityLabel = "test accessibilityLabel"

        // When
        let shareCardButton = BPKShareCardButton(
            accessibilityLabel: stubAccessibilityLabel
        )

        // Then
        XCTAssertEqual(shareCardButton.accessibilityLabel, stubAccessibilityLabel)
        XCTAssertEqual(shareCardButton.style, .default)
        XCTAssertEqual(shareCardButton.size, .default)
    }

    func testExtraSubviewInContainedStyle() {
        // Given
        let shareCardButton = BPKShareCardButton(
            accessibilityLabel: "",
            style: .default
        )
        shareCardButton.layoutIfNeeded() // To get the accurate subviews.count
        let subViewCountWithoutCircle = shareCardButton.subviews.count

        shareCardButton.style = .contained
        XCTAssertEqual(shareCardButton.subviews.count, subViewCountWithoutCircle + 1)

        shareCardButton.style = .onDark
        XCTAssertEqual(shareCardButton.subviews.count, subViewCountWithoutCircle)
    }
}
