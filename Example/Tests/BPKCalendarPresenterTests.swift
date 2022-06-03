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

final class BPKCalendarPresenterTests: XCTestCase {
    private let timeZone = TimeZone(identifier: "GMT")!
    private let minDate = BPKSimpleDate(year: 2022, month: 1, day: 1)
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = timeZone
        return formatter
    }()
    
    private lazy var calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        return calendar
    }()
    
    private var sut: BPKCalendarPresenter!
    
    override func tearDown() {
        sut = nil
    }
    
    func test_firstValidDayOfMonth_whenMinDateIsPreviousToMonth_thenGetFirstDayOfMonth() {
        // Given
        let minDate = BPKSimpleDate(year: 2022, month: 5, day: 2)
        sut = givenCalendarPresenter(withMinDate: minDate)
        let expected = "2022/06/01"
        
        // When
        let month = date(from: "2022/06/01")
        
        // Then
        let firstDayOfMonth = sut.firstValidDay(ofMonth: month)
        XCTAssertEqual(dateFormatter.string(from: firstDayOfMonth), expected)
    }
    
    func test_firstValidDayOfMonth_whenMinDateIsInTheMonth_thenGetMinDate() {
        // Given
        let minDate = BPKSimpleDate(year: 2022, month: 6, day: 3)
        sut = givenCalendarPresenter(withMinDate: minDate)
        let expected = "2022/06/03"
        
        // When
        let month = date(from: "2022/06/01")
        
        // Then
        let firstDayOfMonth = sut.firstValidDay(ofMonth: month)
        XCTAssertEqual(dateFormatter.string(from: firstDayOfMonth), expected)
    }
    
    func test_lastDayOfMonth_whenIsDecember() {
        // Given
        sut = givenCalendarPresenter()
        let expected = "2022/12/31"
        
        // When
        let month = date(from: "2022/12/01")
        
        // Then
        let lastDay = sut.lastDay(ofMonth: month)
        XCTAssertEqual(dateFormatter.string(from: lastDay), expected)
    }
    
    func test_lastDayOfMonth_whenIsFebreaury() {
        // Given
        sut = givenCalendarPresenter()
        let expected = "2022/02/28"
        
        // When
        let month = date(from: "2022/02/01")
        
        // Then
        let lastDay = sut.lastDay(ofMonth: month)
        XCTAssertEqual(dateFormatter.string(from: lastDay), expected)
    }
    
    func test_lastDayOfMonth_whenIsFebreauryInLeapYear() {
        // Given
        sut = givenCalendarPresenter()
        let expected = "2020/02/29"
        
        // When
        let month = date(from: "2020/02/01")
        
        // Then
        let lastDay = sut.lastDay(ofMonth: month)
        XCTAssertEqual(dateFormatter.string(from: lastDay), expected)
    }
    
    func test_lastDayOfMonth_whenIsJune() {
        // Given
        sut = givenCalendarPresenter()
        let expected = "2022/06/30"
        
        // When
        let month = date(from: "2022/06/01")
        
        // Then
        let lastDay = sut.lastDay(ofMonth: month)
        XCTAssertEqual(dateFormatter.string(from: lastDay), expected)
    }
    
    func test_dateListForMonth_whenMinDateIsPreviousToMonth() {
        // Given
        let minDate = BPKSimpleDate(year: 2022, month: 5, day: 2)
        sut = givenCalendarPresenter(withMinDate: minDate)
        let expectedFirst = BPKSimpleDate(year: 2022, month: 6, day: 1)
        let expectedLast = BPKSimpleDate(year: 2022, month: 6, day: 30)
        
        // When
        let month = date(from: "2022/06/01")
        
        // Then
        let dateList = sut.dateList(forMonth: month)
        XCTAssertEqual(dateList.count, 30)
        XCTAssertEqual(dateList.first!, expectedFirst)
        XCTAssertEqual(dateList.last!, expectedLast)
    }
    
    func test_dateListForMonth_whenMinDateIsInTheMonth() {
        // Given
        let minDate = BPKSimpleDate(year: 2022, month: 6, day: 15)
        sut = givenCalendarPresenter(withMinDate: minDate)
        let expectedLast = BPKSimpleDate(year: 2022, month: 6, day: 30)
        
        // When
        let month = date(from: "2022/06/01")
        
        // Then
        let dateList = sut.dateList(forMonth: month)
        XCTAssertEqual(dateList.count, 16)
        XCTAssertEqual(dateList.first!, minDate)
        XCTAssertEqual(dateList.last!, expectedLast)
    }
    
}

private extension BPKCalendarPresenterTests {
    func givenCalendarPresenter(withMinDate minDate: BPKSimpleDate) -> BPKCalendarPresenter {
        return BPKCalendarPresenter(
            calendar: calendar,
            minDate: minDate
        )!
    }
    
    func givenCalendarPresenter() -> BPKCalendarPresenter {
        return givenCalendarPresenter(withMinDate: minDate)
    }
    
    func date(from dateString: String) -> Date {
        guard let date = dateFormatter.date(from: dateString) else {
            XCTFail("Cannot create a valid date.")
            return Date()
        }
        
        return date
    }
}
