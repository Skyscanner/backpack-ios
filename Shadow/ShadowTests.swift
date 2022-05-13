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

extension BPKShadow: Equatable {
    public static func == (lhs: BPKShadow, rhs: BPKShadow) -> Bool {
        lhs.color.value == rhs.color.value &&
        lhs.radius == rhs.radius &&
        lhs.offset.x == rhs.offset.x &&
        lhs.offset.y == rhs.offset.y &&
        lhs.opacity == rhs.opacity
    }
}

class ShadowTests: XCTestCase {
    func testShadowsHaveCorrectValues() {
        let small = BPKShadow(color: .shadowSmColor, radius: 3, offset: .y(1), opacity: 0.15)
        let large = BPKShadow(color: .shadowLgColor, radius: 16, offset: .y(4), opacity: 0.15)
        
        XCTAssertEqual(BPKShadow.lg, large);
        XCTAssertEqual(BPKShadow.sm, small);
    }
}
