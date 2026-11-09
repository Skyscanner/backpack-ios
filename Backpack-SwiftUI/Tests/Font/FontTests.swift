/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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
@testable import Backpack_SwiftUI
import SwiftUI

class FontTests: XCTestCase {
    func test_whenRequestingABlackFontWithoutACustomDefinition_thenUsesBoldFallback() {
        // Given
        var requestedName: String?

        // When
        _ = Font.customOrDefault(nil, size: 16, weight: .black, textStyle: .body) { name, size, _ in
            requestedName = name
            return .system(size: size)
        }

        // Then
        XCTAssertEqual(requestedName, "HelveticaNeue-Bold")
    }

    func test_whenReadingHeadingStyles_thenUsesFinalizedLetterSpacing() {
        // Given / When / Then
        XCTAssertEqual(BPKFontStyle.heading1.letterSpacing, -1.2)
        XCTAssertEqual(BPKFontStyle.heading2.letterSpacing, -1)
        XCTAssertEqual(BPKFontStyle.heading3.letterSpacing, -0.6)
        XCTAssertEqual(BPKFontStyle.heading4.letterSpacing, -0.6)
        XCTAssertEqual(BPKFontStyle.heading5.letterSpacing, -0.6)
        XCTAssertEqual(BPKFontStyle.hero5.letterSpacing, -1.2)
    }

    func testUsesDefaultFontWhenFontByNameNotFound() {
        let anySize: CGFloat = 1
        let mockFont = Font.system(size: anySize).italic()
        let systemFont = Font.system(size: anySize)
        let sut = Font.customOrDefault("some font", size: anySize, weight: .regular, textStyle: .body) { _, _, _ in
            mockFont
        }
        XCTAssertEqual(mockFont, sut)
        XCTAssertNotEqual(systemFont, sut)
    }
}
