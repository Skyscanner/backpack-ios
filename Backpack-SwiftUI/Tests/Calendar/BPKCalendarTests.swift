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
    
    private var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar
    }
    
    func test_singleSelectionCalendar() {
        let testDate = calendar.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        
        assertSnapshot(
            BPKCalendar(
                selectionType: .single(
                    selected: .constant(.single(testDate)),
                    accessibilityConfigurations: SingleAccessibilityConfigurations(
                        selectionHint: ""
                    )
                ),
                calendar: calendar,
                validRange: validStart...validEnd
            )
            .frame(width: 320, height: 720)
        )
    }
    
    func test_rangeSelectionCalendar_sameMonth() {
        let selectionStart = calendar.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        let selectionEnd = calendar.date(from: DateComponents(year: 2020, month: 2, day: 18))!
        
        assertSnapshot(
            BPKCalendar(
                selectionType: .range(
                    selection: .constant(.range(selectionStart...selectionEnd)),
                    accessibilityConfigurations: rangeAccessibilityConfig
                ),
                calendar: calendar,
                validRange: validStart...validEnd
            )
            .frame(width: 320, height: 720)
        )
    }
    
    func test_rangeSelectionCalendar_differentMonth() {
        let selectionStart = calendar.date(from: DateComponents(year: 2020, month: 1, day: 28))!
        let selectionEnd = calendar.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        
        assertSnapshot(
            BPKCalendar(
                selectionType: .range(
                    selection: .constant(.range(selectionStart...selectionEnd)),
                    accessibilityConfigurations: rangeAccessibilityConfig
                ),
                calendar: calendar,
                validRange: validStart...validEnd
            )
            .frame(width: 320, height: 720)
        )
    }
    
    func test_rangeSelectionCalendar_withAccessoryView() {
        let selectionStart = calendar.date(from: DateComponents(year: 2020, month: 1, day: 28))!
        let selectionEnd = calendar.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        
        assertSnapshot(
            BPKCalendar(
                selectionType: .range(
                    selection: .constant(.range(selectionStart...selectionEnd)),
                    accessibilityConfigurations: rangeAccessibilityConfig
                ),
                calendar: calendar,
                validRange: validStart...validEnd,
                dayAccessoryView: { _ in
                    BPKIconView(.search, size: .small)
                        .foregroundColor(.accentColor)
                }
            )
            .frame(width: 320, height: 720)
        )
    }
    
    func test_rangeSelectionCalendar_sameDay() {
        let selectionStart = calendar.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        let selectionEnd = calendar.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        
        assertSnapshot(
            BPKCalendar(
                selectionType: .range(
                    selection: .constant(.range(selectionStart...selectionEnd)),
                    accessibilityConfigurations: rangeAccessibilityConfig
                ),
                calendar: calendar,
                validRange: validStart...validEnd
            )
            .frame(width: 320, height: 720)
        )
    }
    
    func test_rangeCalendarDayCells() {
        let date = calendar.date(from: .init(year: 2023, month: 11, day: 8))!
        
        assertSnapshot(
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 6), spacing: 0) {
                DefaultCalendarDayCell(calendar: calendar, date: date)
                DisabledCalendarDayCell(calendar: calendar, date: date)
                LowerBoundSelectedCell(calendar: calendar, date: date, highlighted: true)
                InbetweenSelectionCell(calendar: calendar, date: date)
                UpperBoundSelectedCell(calendar: calendar, date: date, highlighted: true)
                LowerAndUpperBoundSelectedCell(calendar: calendar, date: date)
            }
                .frame(width: 400)
        )
    }
    
    func test_singleSelectionCalendarWithNoFloatYearLabel() {
        let testDate = Calendar.current.date(from: DateComponents(year: 2020, month: 2, day: 5))!
        
        assertSnapshot(
            BPKCalendar(
                selectionType: .single(
                    selected: .constant(.single(testDate)),
                    accessibilityConfigurations: SingleAccessibilityConfigurations(
                        selectionHint: ""
                    )
                ),
                calendar: Calendar.current,
                validRange: validStart...validEnd,
                showFloatYearLabel: false
            )
            .frame(width: 320, height: 720)
        )
    }
}
