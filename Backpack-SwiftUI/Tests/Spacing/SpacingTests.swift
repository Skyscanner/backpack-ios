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

class SpacingTests: XCTestCase {
    func testSpacingsHaveCorrectValues() {
        XCTAssertEqual(Spacing.none.value, 0);
        XCTAssertEqual(Spacing.sm.value, 4);
        XCTAssertEqual(Spacing.md.value, 8);
        XCTAssertEqual(Spacing.iconText.value, 8);
        XCTAssertEqual(Spacing.base.value, 16);
        XCTAssertEqual(Spacing.lg.value, 24);
        XCTAssertEqual(Spacing.xl.value, 32);
        XCTAssertEqual(Spacing.xxl.value, 40);
    }
}
