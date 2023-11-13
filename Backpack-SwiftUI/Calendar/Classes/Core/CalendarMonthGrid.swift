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
    @ViewBuilder let emptyLeadingDayCell: (Date, Int) -> EmptyLeadingDayCell
    @ViewBuilder let emptyTrailingDayCell: (Date, Int) -> EmptyTrailingDayCell
    
    var body: some View {
        // Sunday is the first day of the week, so we need to offset the days to make Monday the first day
        let weekdaysOffset = calendar.component(.weekday, from: monthDate) - 2
        let daysFromPreviousMonth = weekdaysOffset == -1 ? 6 : weekdaysOffset
        LazyVGrid(
            columns: Array(repeating: GridItem(spacing: BPKSpacing.none.value), count: 7),
            spacing: BPKSpacing.lg.value
        ) {
            cellsBeforeMonth(daysFromPreviousMonth: daysFromPreviousMonth)
            let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: monthDate)!.count
            currentMonthDayCell(numberOfDaysInMonth: numberOfDaysInMonth)
            cellsAfterMonth(totalCellsUsed: numberOfDaysInMonth + daysFromPreviousMonth)
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
                DisabledSelectionCell(calendar: calendar, date: dayDate)
            } else {
                dayCell(dayDate)
            }
        }
    }
    
    private func cellsBeforeMonth(daysFromPreviousMonth: Int) -> some View {
        ForEach(0..<daysFromPreviousMonth) { cellIndex in
            let dayDate = calendar.date(
                byAdding: .init(day: cellIndex - daysFromPreviousMonth),
                to: monthDate
            )!
            emptyLeadingDayCell(dayDate, cellIndex)
        }
    }
    
    @ViewBuilder
    private func cellsAfterMonth(totalCellsUsed: Int) -> some View {
        let remainingCells = 7 - (totalCellsUsed % 7)
        
        if remainingCells < 7 {
            ForEach(0..<remainingCells) { cellIndex in
                let dayDate = calendar.date(
                    byAdding: .init(month: 1, day: cellIndex),
                    to: monthDate
                )!
                emptyTrailingDayCell(dayDate, cellIndex)
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
            emptyLeadingDayCell: { _, _ in
                Color.red
            },
            emptyTrailingDayCell: { _, _ in
                Color.green
            }
        )
    }
}
