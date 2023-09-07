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

final class BPKButtonTest: XCTestCase {
    // MARK: - Accessibility tests
    /// These tests were added after a bug was discovered with the accessibilityLabel being overridden
    /// as soon as any update was done to the button. The issue happened with enabled/title/color etc.
    func test_regularButton_usesTitle_asA11yLabel() {
        // Given
        let sut = BPKButton(size: .default, style: .primary)
        let expectedLabel = "Test button"
        
        // When
        sut.title = expectedLabel
        
        // Then
        XCTAssertEqual(sut.accessibilityLabel, expectedLabel)
    }
    
    func test_regularButton_doesntOverrideA11yLabel() {
        // Given
        let sut = BPKButton(size: .default, style: .primary)
        let expectedLabel = "Accessibility Label"
        
        // When
        sut.title = "Test button"
        sut.accessibilityLabel = expectedLabel
        sut.isEnabled = true
        
        // Then
        XCTAssertEqual(sut.accessibilityLabel, expectedLabel)
    }
    
    func test_iconButton_doesntOverrideA11yLabel() {
        // Given
        let sut = BPKButton(size: .default, style: .primary)
        let expectedLabel = "Accessibility Label"
        
        // When
        sut.setImage(BPKIcon.makeSmallTemplateIcon(name: .accessibility))
        sut.accessibilityLabel = expectedLabel
        sut.isEnabled = true
        
        // Then
        XCTAssertEqual(sut.accessibilityLabel, expectedLabel)
    }
    
    func test_regularButton_updatingTitleWithoutCustomA11yLabel_updatesLabel() {
        // Given
        let sut = BPKButton(size: .default, style: .primary)
        let expectedLabel = "New test button"
        
        // When
        sut.title = "Test button"
        sut.title = expectedLabel
        
        // Then
        XCTAssertEqual(sut.accessibilityLabel, expectedLabel)
    }
    
    func test_regularButton_updatingTitleWithCustomA11yLabel_doesNotUpdateLabel() {
        // Given
        let sut = BPKButton(size: .default, style: .primary)
        let expectedLabel = "Accessibility Label"
        
        // When
        sut.title = "Test button"
        sut.accessibilityLabel = expectedLabel
        sut.title = "Other test button"
        
        // Then
        XCTAssertEqual(sut.accessibilityLabel, expectedLabel)
    }
    
    func test_regularButton_setTitle_nil() {
        // Given
        let sut = BPKButton(size: .default, style: .primary)
        
        // When
        sut.title = "Other test button"
        sut.title = nil
        
        // Then
        XCTAssertNil(sut.accessibilityLabel)
    }
}
