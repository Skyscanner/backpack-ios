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

class FontTests: XCTestCase {
    func testUsesDefaultFontWhenFontByNameNotFound() {
        let anySize: CGFloat = 1
        let mockFont = UIFont.italicSystemFont(ofSize: anySize)
        let systemFont = UIFont.systemFont(ofSize: anySize)
        let sut = UIFont.customOrDefault("some font", size: anySize, weight: .regular) { _,_  in
            mockFont
        }
        XCTAssertEqual(mockFont, sut)
        XCTAssertNotEqual(systemFont, sut)
    }
    
    func testUsesFontWhenFontByNameIsFound() {
        let anySize: CGFloat = 1
        let systemFont = UIFont.systemFont(ofSize: anySize)
        let sut = UIFont.customOrDefault("some font", size: anySize, weight: .regular) { _,_  in
            nil
        }
        XCTAssertEqual(systemFont, sut)
    }
}
