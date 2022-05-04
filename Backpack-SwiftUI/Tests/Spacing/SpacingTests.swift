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
        XCTAssertEqual(BPKSpacing.none.value, 0);
        XCTAssertEqual(BPKSpacing.sm.value, 4);
        XCTAssertEqual(BPKSpacing.md.value, 8);
        XCTAssertEqual(BPKSpacing.iconText.value, 8);
        XCTAssertEqual(BPKSpacing.base.value, 16);
        XCTAssertEqual(BPKSpacing.lg.value, 24);
        XCTAssertEqual(BPKSpacing.xl.value, 32);
        XCTAssertEqual(BPKSpacing.xxl.value, 40);
    }
}
