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

import SwiftUI

struct SingleCalendarContainer<MonthHeader: View>: View {
    @Binding var selection: Date?
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    
    private func handleSelection(_ date: Date) {
        selection = date
    }
    
    @ViewBuilder
    private func makeDayCell(_ dayDate: Date) -> some View {
        if selection == dayDate {
            CalendarSelectableCell {
                SingleSelectedCell(calendar: calendar, date: dayDate)
            } onSelection: {
                handleSelection(dayDate)
            }
        } else {
            CalendarSelectableCell {
                DefaultSelectionCell(calendar: calendar, date: dayDate)
            } onSelection: {
                handleSelection(dayDate)
            }
        }
    }
    
    // swiftlint:disable all
    var body: some View {
        CalendarContainer(calendar: calendar, validRange: validRange) { month in
            monthHeader(month)
            CalendarMonthGrid(
                monthDate: month,
                calendar: calendar,
                validRange: validRange,
                dayCell: makeDayCell) { _, _ in
                    DefaultEmptyCalendarDayCell()
                }
        }
    }
}

struct SingleCalendarContainer_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
        let end = calendar.date(from: .init(year: 2025, month: 12, day: 25))!
        
        SingleCalendarContainer(
            selection: .constant(calendar.date(from: .init(year: 2023, month: 11, day: 10))!),
            calendar: calendar,
            validRange: start...end,
            monthHeader: { month in
                VStack {
                    BPKText("Calendar Grid \(month)")
                        .border(.blue)
                    Divider()
                }
            }
        )
    }
}
