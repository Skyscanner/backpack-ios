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
import SwiftUI
@testable import Backpack_SwiftUI

class BPKCalendarTests: XCTestCase {
    let validStart = Calendar.current.date(from: DateComponents(year: 2020, month: 1, day: 13))!
    let validEnd = Calendar.current.date(from: DateComponents(year: 2020, month: 2, day: 20))!
    
    let rangeAccessibilityConfig = RangeAccessibilityConfigurations(
        startSelectionHint: "",
        endSelectionHint: "",
        startSelectionState: "",
        endSelectionState: "",
        betweenSelectionState: "",
        startAndEndSelectionState: "",
        returnDatePrompt: ""
    )
    
    func test_singleSelectionCalendar() {
        let testDate = Calendar.current.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        
        assertSnapshot(
            BPKCalendar(
                selectionType: .single(
                    selected: .constant(testDate),
                    accessibilityConfigurations: SingleAccessibilityConfigurations(
                        selectionHint: ""
                    )
                ),
                calendar: Calendar.current,
                validRange: validStart...validEnd
            )
            .frame(width: 320, height: 720)
        )
    }
    
    func test_rangeSelectionCalendar_sameMonth() {
        let selectionStart = Calendar.current.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        let selectionEnd = Calendar.current.date(from: DateComponents(year: 2020, month: 2, day: 18))!
        
        assertSnapshot(
            BPKCalendar(
                selectionType: .range(
                    selectedRange: .constant(selectionStart...selectionEnd),
                    accessibilityConfigurations: rangeAccessibilityConfig
                ),
                calendar: Calendar.current,
                validRange: validStart...validEnd
            )
            .frame(width: 320, height: 720)
        )
    }
    
    func test_rangeSelectionCalendar_differentMonth() {
        let selectionStart = Calendar.current.date(from: DateComponents(year: 2020, month: 1, day: 28))!
        let selectionEnd = Calendar.current.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        
        assertSnapshot(
            BPKCalendar(
                selectionType: .range(
                    selectedRange: .constant(selectionStart...selectionEnd),
                    accessibilityConfigurations: rangeAccessibilityConfig
                ),
                calendar: Calendar.current,
                validRange: validStart...validEnd
            )
            .frame(width: 320, height: 720)
        )
    }
    
    func test_rangeSelectionCalendar_sameDay() {
        let selectionStart = Calendar.current.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        let selectionEnd = Calendar.current.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        
        assertSnapshot(
            BPKCalendar(
                selectionType: .range(
                    selectedRange: .constant(selectionStart...selectionEnd),
                    accessibilityConfigurations: rangeAccessibilityConfig
                ),
                calendar: Calendar.current,
                validRange: validStart...validEnd
            )
            .frame(width: 320, height: 720)
        )
    }
    
    func test_rangeCalendarDayCells() {
        let calendar = Calendar.current
        let date = calendar.date(from: .init(year: 2023, month: 11, day: 8))!
        
        assertSnapshot(
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 6), spacing: 0) {
                DefaultCalendarDayCell(calendar: calendar, date: date)
                DisabledCalendarDayCell(calendar: calendar, date: date)
                LowerBoundSelectedCell(calendar: calendar, date: date)
                InbetweenSelectionCell(calendar: calendar, date: date)
                UpperBoundSelectedCell(calendar: calendar, date: date)
                LowerAndUpperBoundSelectedCell(calendar: calendar, date: date)
            }
                .frame(width: 400)
        )
    }
}
