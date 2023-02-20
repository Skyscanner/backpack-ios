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

class BPKSaveCardButtonTest: XCTestCase {
    func testInitWithDefaultStyleAndSize() {
        // Given
        let stubAccessibilityLabel = "test accessibilityLabel"

        // When
        let saveCardButton = BPKSaveCardButton(
            accessibilityLabel: stubAccessibilityLabel
        )

        // Then
        XCTAssertEqual(saveCardButton.checked, false)
        XCTAssertEqual(saveCardButton.accessibilityLabel, stubAccessibilityLabel)
        XCTAssertEqual(saveCardButton.style, .default)
        XCTAssertEqual(saveCardButton.size, .default)
    }

    func testOnCheckedChangedIsCalled() {
        // Given
        var onCheckedChangeLastCalledValue = false
        let saveCardButton = BPKSaveCardButton(
            checked: false,
            accessibilityLabel: "",
            onCheckedChange: { checked in
                onCheckedChangeLastCalledValue = checked
            }
        )

        // When
        saveCardButton.setChecked(true, animated: false)
        // Then
        XCTAssertTrue(onCheckedChangeLastCalledValue)

        // When
        saveCardButton.setChecked(false, animated: false)
        // Then
        XCTAssertFalse(onCheckedChangeLastCalledValue)
    }

    func testSetCheckedAnimated() {
        // Given
        let saveCardButton = BPKSaveCardButton(
            checked: false,
            accessibilityLabel: ""
        )

        saveCardButton.setChecked(true, animated: false)
        XCTAssertTrue(saveCardButton.checked)

        saveCardButton.setChecked(false, animated: false)
        XCTAssertFalse(saveCardButton.checked)

        saveCardButton.setChecked(true, animated: true)
        XCTAssertTrue(saveCardButton.checked)

        saveCardButton.setChecked(false, animated: true)
        XCTAssertFalse(saveCardButton.checked)
    }

    func testExtraSubviewInContainedStyle() {
        // Given
        let saveCardButton = BPKSaveCardButton(
            accessibilityLabel: "",
            style: .default
        )
        saveCardButton.layoutIfNeeded() // To get the accurate subviews.count
        let subViewCountWithoutCircle = saveCardButton.subviews.count

        saveCardButton.style = .contained
        XCTAssertEqual(saveCardButton.subviews.count, subViewCountWithoutCircle + 1)

        saveCardButton.style = .onDark
        XCTAssertEqual(saveCardButton.subviews.count, subViewCountWithoutCircle)
    }

    func testSelectedAccessibilityTraitsUpdate() {
        // Given
        let saveCardButton = BPKSaveCardButton(
            checked: false,
            accessibilityLabel: ""
        )
        XCTAssertFalse(saveCardButton.accessibilityTraits.contains(.selected))

        // When
        saveCardButton.setChecked(true, animated: false)

        // Then
        XCTAssertTrue(saveCardButton.accessibilityTraits.contains(.selected))

        saveCardButton.setChecked(false, animated: true)
        XCTAssertFalse(saveCardButton.accessibilityTraits.contains(.selected))
    }
}
