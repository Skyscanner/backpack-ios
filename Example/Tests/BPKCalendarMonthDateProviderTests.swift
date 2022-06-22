//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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
@testable import Backpack

final class BPKCalendarMonthDateProviderTests: XCTestCase {
    private let timeZone = TimeZone(identifier: "GMT")!
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = timeZone
        return formatter
    }
    
    private var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        return calendar
    }
    
    func test_firstValidDayOfMonth_whenMinDateIsPreviousToMonth_thenGetFirstDayOfMonth() {
        // Given
        let minDate = BPKSimpleDate(year: 2022, month: 5, day: 2)
        let sut = givenCalendarPresenter()
        let expected = "2022/06/01"
        
        // When
        let month = date(from: "2022/06/01")
        
        // Then
        let firstDayOfMonth = sut.firstValidDay(ofMonth: month, fromMinDate: minDate.date(for: calendar))
        XCTAssertEqual(dateFormatter.string(from: firstDayOfMonth), expected)
    }
    
    func test_firstValidDayOfMonth_whenMinDateIsInTheMonth_thenGetMinDate() {
        // Given
        let minDate = BPKSimpleDate(year: 2022, month: 6, day: 3)
        let sut = givenCalendarPresenter()
        let expected = "2022/06/03"
        
        // When
        let month = date(from: "2022/06/01")
        
        // Then
        let firstDayOfMonth = sut.firstValidDay(ofMonth: month, fromMinDate: minDate.date(for: calendar))
        XCTAssertEqual(dateFormatter.string(from: firstDayOfMonth), expected)
    }
    
    func test_lastDayOfMonth_whenIsDecember() {
        // Given
        let sut = givenCalendarPresenter()
        let expected = "2022/12/31"
        
        // When
        let month = date(from: "2022/12/01")
        
        // Then
        let lastDay = sut.lastDay(ofMonth: month)
        XCTAssertEqual(dateFormatter.string(from: lastDay), expected)
    }
    
    func test_lastDayOfMonth_whenIsFebreaury() {
        // Given
        let sut = givenCalendarPresenter()
        let expected = "2022/02/28"
        
        // When
        let month = date(from: "2022/02/01")
        
        // Then
        let lastDay = sut.lastDay(ofMonth: month)
        XCTAssertEqual(dateFormatter.string(from: lastDay), expected)
    }
    
    func test_lastDayOfMonth_whenIsFebreauryInLeapYear() {
        // Given
        let sut = givenCalendarPresenter()
        let expected = "2020/02/29"
        
        // When
        let month = date(from: "2020/02/01")
        
        // Then
        let lastDay = sut.lastDay(ofMonth: month)
        XCTAssertEqual(dateFormatter.string(from: lastDay), expected)
    }
    
    func test_lastDayOfMonth_whenIsJune() {
        // Given
        let sut = givenCalendarPresenter()
        let expected = "2022/06/30"
        
        // When
        let month = date(from: "2022/06/01")
        
        // Then
        let lastDay = sut.lastDay(ofMonth: month)
        XCTAssertEqual(dateFormatter.string(from: lastDay), expected)
    }
    
    func test_dateListForMonth_whenMinDateIsPreviousToMonth() throws {
        // Given
        let minDate = BPKSimpleDate(year: 2022, month: 5, day: 2)
        let sut = givenCalendarPresenter()
        let expectedFirst = BPKSimpleDate(year: 2022, month: 6, day: 1)
        let expectedLast = BPKSimpleDate(year: 2022, month: 6, day: 30)
        
        // When
        let month = date(from: "2022/06/01")
        
        // Then
        let dateList = sut.dateList(forMonth: month, fromMinDate: minDate.date(for: calendar))
        let firstDay = try XCTUnwrap(dateList.first)
        XCTAssertEqual(firstDay, expectedFirst)
        let lastDay = try XCTUnwrap(dateList.last)
        XCTAssertEqual(lastDay, expectedLast)
    }
    
    func test_dateListForMonth_whenMinDateIsInTheMonth() throws {
        // Given
        let minDate = BPKSimpleDate(year: 2022, month: 6, day: 15)
        let sut = givenCalendarPresenter()
        let expectedLast = BPKSimpleDate(year: 2022, month: 6, day: 30)
        
        // When
        let month = date(from: "2022/06/01")
        
        // Then
        let dateList = sut.dateList(forMonth: month, fromMinDate: minDate.date(for: calendar))
        let firstDay = try XCTUnwrap(dateList.first)
        XCTAssertEqual(firstDay, minDate)
        let lastDay = try XCTUnwrap(dateList.last)
        XCTAssertEqual(lastDay, expectedLast)
    }
}

private extension BPKCalendarMonthDateProviderTests {
    func givenCalendarPresenter() -> BPKCalendarMonthDateProvider {
        return BPKCalendarMonthDateProvider(
            calendar: calendar
        )
    }
    
    func date(from dateString: String) -> Date {
        guard let date = dateFormatter.date(from: dateString) else {
            XCTFail("Cannot create a valid date.")
            return Date()
        }
        
        return date
    }
}
