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

final class BPKCalendarWholeMonthConfigurationTests: XCTestCase {
    func test_monthInRange_whenRangeIsNotSet() {
        // Given
        let sut = BPKCalendarWholeMonthConfiguration(
            title: "SelectWholeMonth",
            selectableMonthRange: nil
        )
        
        let month = BPKSimpleDate(year: 2020, month: 1, day: 1)
        
        // When
        let result = sut.isWholeMonthSelectionEnabled(month: month)
        
        // Then
        XCTAssertTrue(result)
    }
    
    func test_monthInRange_whenRangeIsSet() {
        // Given
        let sut = BPKCalendarWholeMonthConfiguration(
            title: "SelectWholeMonth",
            selectableMonthRange: BPKYearMonth(year: 2020, month: 1)...BPKYearMonth(year: 2020, month: 12)
        )
        
        let month = BPKSimpleDate(year: 2020, month: 1, day: 1)
        
        // When
        let result = sut.isWholeMonthSelectionEnabled(month: month)
        
        // Then
        XCTAssertTrue(result)
    }
    
    func test_monthOutOfRange_whenRangeIsSet() {
        // Given
        let sut = BPKCalendarWholeMonthConfiguration(
            title: "SelectWholeMonth",
            selectableMonthRange: BPKYearMonth(year: 2020, month: 1)...BPKYearMonth(year: 2020, month: 12)
        )
        
        let month = BPKSimpleDate(year: 2021, month: 1, day: 1)
        
        // When
        let result = sut.isWholeMonthSelectionEnabled(month: month)
        
        // Then
        XCTAssertFalse(result)
    }
}
