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

class ChipUITest: BackpackUITestCase {
    func testTapChipToSelect() {
        // Navigate to chips
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Chips"].tap()
        tablesQuery.staticTexts["Default"].tap()
        
        // Regular chip
        // Given
        let chipIdentifier = "chip_option_enabled_true_selected_false"
        let optionButton = app.buttons[chipIdentifier]
        
        // When
        optionButton.tap()
        
        // Then
        XCTAssertTrue(optionButton.isSelected)
        
        // When
        optionButton.tap()
        
        // Then
        XCTAssertFalse(optionButton.isSelected)
        
        // Disabled chip
        // Given
        let disabledChipIdentifier = "chip_option_enabled_false_selected_false"
        let disabledChip = app.buttons[disabledChipIdentifier]
        
        // Then
        XCTAssertFalse(disabledChip.isEnabled)
        XCTAssertFalse(disabledChip.isSelected)
        
        // When
        disabledChip.tap()
        
        // Then
        XCTAssertFalse(disabledChip.isSelected)
    }
}
