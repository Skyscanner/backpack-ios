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
    EmptyTrailingDayCell: View,
    DayAccessoryView: View
>: View {
    let monthDate: Date
    let calendar: Calendar
    let validRange: ClosedRange<Date>

    @State private var dayCellHeight: CGFloat = 0
    @ViewBuilder let dayCell: (Date) -> DayCell
    @ViewBuilder let emptyLeadingDayCell: (EmptyCellInfo) -> EmptyLeadingDayCell
    @ViewBuilder let emptyTrailingDayCell: (EmptyCellInfo) -> EmptyTrailingDayCell
    @ViewBuilder let dayAccessoryView: (Date) -> DayAccessoryView
    
    private let daysInAWeek = 7
    
    var body: some View {
        let firstWeekday = calendar.firstWeekday // Locale-aware first day of the week
        let weekdayOfMonthStart = calendar.component(.weekday, from: monthDate)
        // Calculate the offset based on the first weekday
        let weekdaysOffset = (weekdayOfMonthStart - firstWeekday + daysInAWeek) % daysInAWeek
        let daysFromPreviousMonth = weekdaysOffset
        let emptyDaysLeading = (0..<daysFromPreviousMonth).map { index in
            EmptyCellInfo(cellIndex: index, month: monthDate)
        }
        
        let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: monthDate)!.count
        let totalCellsUsed = numberOfDaysInMonth + daysFromPreviousMonth
        let remainingCells = daysInAWeek - (totalCellsUsed % daysInAWeek)
        let emptyDaysTrailing = (0..<remainingCells).map { index in
            EmptyCellInfo(cellIndex: index, month: monthDate)
        }

        LazyVGrid(
            columns: Array(repeating: GridItem(spacing: BPKSpacing.none.value), count: daysInAWeek),
            spacing: BPKSpacing.lg.value
        ) {
            // Create cells for the days from the previous month that are shown in the first week of the current month.
            ForEach(emptyDaysLeading) { emptyDayInfo in
                VStack(spacing: BPKSpacing.none) {
                    emptyLeadingDayCell(emptyDayInfo)
                        .frame(height: dayCellHeight)
                    Spacer(minLength: BPKSpacing.none)
                }
            }

            // Create cells for the days in the current month
            currentMonthDayCell(numberOfDaysInMonth: numberOfDaysInMonth)

            // Create cells for the days from the next month that are shown in the last week of the current month
            // The total number of cells used is the sum of the number of days in the current month and the number of
            // days from the previous month that are shown
            
            if remainingCells < daysInAWeek {
                ForEach(emptyDaysTrailing) { emptyDayInfo in
                    VStack(spacing: BPKSpacing.none) {
                        emptyTrailingDayCell(emptyDayInfo)
                            .frame(height: dayCellHeight)
                        Spacer(minLength: BPKSpacing.none)
                    }
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
                VStack(spacing: BPKSpacing.none) {
                    DisabledCalendarDayCell(calendar: calendar, date: dayDate)
                        .frame(height: dayCellHeight)
                    Spacer(minLength: BPKSpacing.none)
                }
            } else {
                VStack(spacing: BPKSpacing.sm) {
                    dayCell(dayDate)
                        .modifier(ReadSizeModifier { dayCellHeight = $0.height })
                    dayAccessoryView(dayDate)
                }
            }
        }
    }
}

struct CalendarMonthGrid_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 8, day: 25))!
        let end = calendar.date(from: .init(year: 2023, month: 8, day: 28))!
        
        CalendarMonthGrid(
            monthDate: calendar.date(from: .init(year: 2023, month: 8, day: 1))!,
            calendar: calendar,
            validRange: start...end,
            dayCell: { day in
                BPKText("\(calendar.component(.day, from: day))")
            },
            emptyLeadingDayCell: { _ in Color.red },
            emptyTrailingDayCell: { _ in Color.green },
            dayAccessoryView: { _ in
                BPKText("$200", style: .caption)
                    .foregroundColor(.infoBannerSuccessColor)
            }
        )
    }
}
