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
    let accessibilityProvider: SingleDayAccessibilityProvider
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    
    @ViewBuilder
    private func makeDayCell(_ dayDate: Date) -> some View {
        CalendarSelectableCell {
            if selection == dayDate {
                SingleSelectedCell(calendar: calendar, date: dayDate)
            } else {
                DefaultCalendarDayCell(calendar: calendar, date: dayDate)
            }
        } onSelection: {
            selection = dayDate
        }
        .accessibilityAddTraits(.isButton)
        .accessibilityAddTraits(selection == dayDate ? .isSelected : [])
        .accessibilityLabel(accessibilityProvider.accessibilityLabel(for: dayDate))
        .accessibilityHint(accessibilityProvider.accessibilityHint(for: dayDate, selection: selection))
    }
    
    var body: some View {
        CalendarContainer(calendar: calendar, validRange: validRange) { month in
            monthHeader(month)
            CalendarMonthGrid(
                monthDate: month,
                calendar: calendar,
                validRange: validRange,
                dayCell: makeDayCell,
                emptyLeadingDayCell: { DefaultEmptyCalendarDayCell() },
                emptyTrailingDayCell: { DefaultEmptyCalendarDayCell() }
            )
        }
    }
}

struct SingleCalendarContainer_Previews: PreviewProvider {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    static var previews: some View {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
        let end = calendar.date(from: .init(year: 2025, month: 12, day: 25))!
        
        SingleCalendarContainer(
            selection: .constant(calendar.date(from: .init(year: 2023, month: 11, day: 10))!),
            calendar: calendar,
            validRange: start...end,
            accessibilityProvider: SingleDayAccessibilityProvider(
                accessibilityConfigurations: .init(selectionHint: ""),
                dateFormatter: Self.formatter
            ),
            monthHeader: { month in
                BPKText("\(Self.formatter.string(from: month))")
            }
        )
    }
}
