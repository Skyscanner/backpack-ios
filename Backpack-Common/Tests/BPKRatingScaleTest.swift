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
@testable import Backpack_Common

class BPKRatingScaleTest: XCTestCase {

    func testDisplayValueWithinBound() {
        // Given
        let scale = BPKRatingScale.zeroToFive
        // When
        let result = scale.displayedValue(from: 2)
        // Then
        XCTAssertEqual(result, "2.0")
    }
    func testDisplayValueBelowBound() {
        // Given
        let scale = BPKRatingScale.zeroToFive
        // When
        let result = scale.displayedValue(from: -10)
        // Then
        XCTAssertEqual(result, "0.0")
    }

    func testDisplayValueAboveBound() {
        // Given
        let scale = BPKRatingScale.zeroToFive
        // When
        let result = scale.displayedValue(from: 10)
        // Then
        XCTAssertEqual(result, "5.0")
    }

    func testDisplayValueAboveBoundZeroToTen() {
        // Given
        let scale = BPKRatingScale.zeroToTen
        // When
        let result = scale.displayedValue(from: 100)
        // Then
        XCTAssertEqual(result, "10.0")
    }

    func testDisplayValueRoundDownToOneDecimal() {
        // Given
        let scale = BPKRatingScale.zeroToTen
        // When
        let result = scale.displayedValue(from: 2.33333)
        // Then
        XCTAssertEqual(result, "2.3")
    }

    func testDisplayValueRoundUpToOneDecimal() {
        // Given
        let scale = BPKRatingScale.zeroToTen
        // When
        let result = scale.displayedValue(from: 2.66666)
        // Then
        XCTAssertEqual(result, "2.7")
    }
}
