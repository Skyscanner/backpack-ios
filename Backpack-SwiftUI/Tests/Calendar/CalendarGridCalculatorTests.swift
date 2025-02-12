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
@testable import Backpack_SwiftUI

class CalendarGridCalculatorTests: XCTestCase {
    func test_canCalculateGridCorrectly() {
        let calendar = Calendar(identifier: .gregorian)
        let sut = DefaultCalendarGridCalculator(calendar: calendar)
        
        let result = sut.calculateCalendarGrid(monthDate: calendar.date(forDay: 1))
        
        let expected: [[Int?]] = [
            [nil, nil, nil, 1, 2, 3, 4],
            [5, 6, 7, 8, 9, 10, 11],
            [12, 13, 14, 15, 16, 17, 18],
            [19, 20, 21, 22, 23, 24, 25],
            [26, 27, 28, 29, 30, nil, nil]
        ]
        
        XCTAssertEqual(result, expected.toDates(calendar: calendar))
    }

    func test_canReturnCachedGrid() {
        let calendar = Calendar.current
        let decoratee = MockCalendarGridCalculator(calendar: calendar)
        let sut = InMemoryCacheCalendarGridCalculator(decoratee: decoratee)
        
        let result = sut.calculateCalendarGrid(monthDate: calendar.date(forDay: 1))
        XCTAssertEqual(decoratee.calledTimes, 1)
        
        let expected = [
            [nil, calendar.date(forDay: 1)],
            [calendar.date(forDay: 2), calendar.date(forDay: 3)],
            [calendar.date(forDay: 4), nil]
        ]
        XCTAssertEqual(result, expected)
        
        let cached = sut.calculateCalendarGrid(monthDate: calendar.date(forDay: 1))
        XCTAssertEqual(decoratee.calledTimes, 1)
        XCTAssertEqual(cached, expected)
    }
    
    class MockCalendarGridCalculator: CalendarGridCalculator {
        let calendar: Calendar
        var calledTimes: Int = 0
        
        init(calendar: Calendar) {
            self.calendar = calendar
        }
        
        func calculateCalendarGrid(monthDate: Date) -> [[Date?]] {
            calledTimes += 1
            return [
                [nil, calendar.date(forDay: 1)],
                [calendar.date(forDay: 2), calendar.date(forDay: 3)],
                [calendar.date(forDay: 4), nil]
            ]
        }
    }
}

fileprivate extension Array where Element == [Int?] {
    func toDates(calendar: Calendar) -> [[Date?]] {
        map { week in
            week.map { day in
                return if let day { calendar.date(forDay: day) } else { nil }
            }
        }
    }
}

fileprivate extension Calendar {
    func date(forDay day: Int) -> Date {
        date(from: .init(year: 2023, month: 11, day: day))!
    }
}
