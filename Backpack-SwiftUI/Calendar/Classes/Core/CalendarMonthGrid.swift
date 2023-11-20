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

struct CalendarMonthGrid<
    DayCell: View,
    EmptyLeadingDayCell: View,
    EmptyTrailingDayCell: View
>: View {
    let monthDate: Date
    let calendar: Calendar
    let validRange: ClosedRange<Date>

    @ViewBuilder let dayCell: (Date) -> DayCell
    @ViewBuilder let emptyLeadingDayCell: () -> EmptyLeadingDayCell
    @ViewBuilder let emptyTrailingDayCell: () -> EmptyTrailingDayCell

    private let daysInAWeek = 7
    
    var body: some View {
        // Sunday is the first day of the week in the Calendar, so we need to offset (rotate the array) the days to
        // make Monday the first day
        let weekdaysOffset = calendar.component(.weekday, from: monthDate) - 2
        // If the offset is -1 (Sunday), we want it to be 6 (the last day of the week),
        // otherwise we keep the offset as it is.
        // This is because we need to fill the first row with empty cells if the month doesn't start on a Monday.
        let daysFromPreviousMonth = weekdaysOffset == -1 ? 6 : weekdaysOffset
        LazyVGrid(
            columns: Array(repeating: GridItem(spacing: BPKSpacing.none.value), count: daysInAWeek),
            spacing: BPKSpacing.lg.value
        ) {
            // Create cells for the days from the previous month that are shown in the first week of the current month.
            ForEach(0..<daysFromPreviousMonth) { _ in
                emptyLeadingDayCell()
            }

            let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: monthDate)!.count
            // Create cells for the days in the current month
            currentMonthDayCell(numberOfDaysInMonth: numberOfDaysInMonth)

            // Create cells for the days from the next month that are shown in the last week of the current month
            // The total number of cells used is the sum of the number of days in the current month and the number of
            // days from the previous month that are shown
            let totalCellsUsed = numberOfDaysInMonth + daysFromPreviousMonth
            let remainingCells = daysInAWeek - (totalCellsUsed % daysInAWeek)
        
            if remainingCells < daysInAWeek {
                ForEach(0..<remainingCells) { _ in
                    emptyTrailingDayCell()
                }
            }
        }
    }
    
    @ViewBuilder
    private func currentMonthDayCell(numberOfDaysInMonth: Int) -> some View {
        ForEach(0..<numberOfDaysInMonth, id: \.self) { cellIndex in
            let dayDate = calendar.date(
                byAdding: .init(day: cellIndex),
                to: monthDate
            )!
            
            if !validRange.contains(dayDate) {
                DisabledCalendarDayCell(calendar: calendar, date: dayDate)
            } else {
                dayCell(dayDate)
            }
        }
    }
}

struct CalendarMonthGrid_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 8, day: 30))!
        let end = calendar.date(from: .init(year: 2028, month: 12, day: 25))!
        
        CalendarMonthGrid(
            monthDate: calendar.date(from: .init(year: 2023, month: 11, day: 1))!,
            calendar: calendar,
            validRange: start...end,
            dayCell: { day in
                BPKText("\(calendar.component(.day, from: day))")
            },
            emptyLeadingDayCell: { Color.red },
            emptyTrailingDayCell: { Color.green }
        )
    }
}
