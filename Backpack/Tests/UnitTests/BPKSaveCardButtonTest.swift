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
        let stubChecked = false
        let stubAccessibilityLabel = "test accessibilityLabel"

        // When
        let saveCardButton = BPKSaveCardButton(
            checked: stubChecked,
            accessibilityLabel: stubAccessibilityLabel,
            onCheckedChange: { _ in }
        )

        // Then
        XCTAssertEqual(saveCardButton.checked, stubChecked)
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
        saveCardButton.checked = true
        // Then
        XCTAssertTrue(onCheckedChangeLastCalledValue)

        // When
        saveCardButton.checked = false
        // Then
        XCTAssertFalse(onCheckedChangeLastCalledValue)
    }

    func testSetCheckedAnimated() {
        // Given
        let saveCardButton = BPKSaveCardButton(
            checked: false,
            accessibilityLabel: "",
            onCheckedChange: { _ in }
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
}
