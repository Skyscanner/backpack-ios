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

final class BPKYearMonthTests: XCTestCase {
    func test_isEqual() {
        // Given
        let sut1 = BPKYearMonth(year: 2023, month: 1)
        let sut2 = BPKYearMonth(year: 2023, month: 1)
        
        // Then
        XCTAssertTrue(sut1 == sut2)
    }
    
    func test_isBefore() {
        // Given
        let sut1 = BPKYearMonth(year: 2022, month: 1)
        let sut2 = BPKYearMonth(year: 2023, month: 1)
        let sut3 = BPKYearMonth(year: 2023, month: 2)
        
        // Then
        XCTAssertTrue(sut1 < sut2)
        XCTAssertTrue(sut2 < sut3)
    }
    
    func test_isBeforeOrEqual() {
        // Given
        let sut1 = BPKYearMonth(year: 2022, month: 1)
        let sut2 = BPKYearMonth(year: 2023, month: 1)
        let sut3 = BPKYearMonth(year: 2023, month: 2)
        let sut4 = BPKYearMonth(year: 2023, month: 1)
        
        // Then
        XCTAssertTrue(sut1 <= sut2)
        XCTAssertTrue(sut2 <= sut3)
        XCTAssertTrue(sut2 <= sut4)
    }
    
    func test_isAfter() {
        // Given
        let sut1 = BPKYearMonth(year: 2022, month: 1)
        let sut2 = BPKYearMonth(year: 2023, month: 1)
        let sut3 = BPKYearMonth(year: 2023, month: 2)
        
        // Then
        XCTAssertTrue(sut2 > sut1)
        XCTAssertTrue(sut3 > sut2)
    }
    
    func test_isAfterOrEqual() {
        // Given
        let sut1 = BPKYearMonth(year: 2022, month: 1)
        let sut2 = BPKYearMonth(year: 2023, month: 1)
        let sut3 = BPKYearMonth(year: 2023, month: 2)
        let sut4 = BPKYearMonth(year: 2023, month: 1)
        
        // Then
        XCTAssertTrue(sut2 >= sut1)
        XCTAssertTrue(sut3 >= sut2)
        XCTAssertTrue(sut4 >= sut2)
    }
}
