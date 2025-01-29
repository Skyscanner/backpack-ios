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
    @ViewBuilder let emptyLeadingDayCell: () -> EmptyLeadingDayCell
    @ViewBuilder let emptyTrailingDayCell: () -> EmptyTrailingDayCell
    @ViewBuilder let dayAccessoryView: (Date) -> DayAccessoryView
    
    private let daysInAWeek = 7
    
    var body: some View {
        let firstWeekday = calendar.firstWeekday // Locale-aware first day of the week
        let weekdayOfMonthStart = calendar.component(.weekday, from: monthDate)
        // Calculate the offset based on the first weekday
        let daysFromPreviousMonth = (weekdayOfMonthStart - firstWeekday + daysInAWeek) % daysInAWeek
        
        let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: monthDate)!.count
        let days = Array(0..<numberOfDaysInMonth)
            .map {
                DayCellIdentifiable(id: "day-\($0)", index: $0)
            }
        
        let totalCellsUsed = numberOfDaysInMonth + daysFromPreviousMonth
        let remainingCells = daysInAWeek - (totalCellsUsed % daysInAWeek)
        
        let usedDaysInFirstRow = daysFromPreviousMonth > 0 ? daysInAWeek - daysFromPreviousMonth : daysInAWeek
        let daysInMonthAfterFirstRow = numberOfDaysInMonth - usedDaysInFirstRow
        let numberOfRows = daysInMonthAfterFirstRow / 7

        Grid(alignment: .center, horizontalSpacing: BPKSpacing.none.value, verticalSpacing: BPKSpacing.base.value) {
            GridRow {
                previousEmptyCells(daysFromPreviousMonth: daysFromPreviousMonth)
                let firstRow = days[0..<daysInAWeek-daysFromPreviousMonth]
                ForEach(firstRow) { dayIndex in
                    self.dayCell(cellIndex: dayIndex)
                }
            }
            ForEach(0..<numberOfRows, id: \.self) { row in
                GridRow {
                    let startIndex = days.count - daysInMonthAfterFirstRow + (daysInAWeek * row)
                    let endIndex = min(startIndex + daysInAWeek, days.count)
                    let rowDays = days[startIndex..<endIndex]
                    ForEach(rowDays) { dayIndex in
                        self.dayCell(cellIndex: dayIndex)
                    }
                }
            }
            GridRow {
                let lastRowStartIndex = days.count - totalCellsUsed % daysInAWeek
                let lastRowDays = days[lastRowStartIndex...]
                ForEach(lastRowDays) { dayIndex in
                    self.dayCell(cellIndex: dayIndex)
                }
                remainingEmptyCells(remainingCells: remainingCells)
            }
            
        }
    }
    
    @ViewBuilder
    private func previousEmptyCells(daysFromPreviousMonth: Int) -> some View {
        let preEmptyCells = Array(0..<daysFromPreviousMonth)
            .map {
                DayCellIdentifiable(id: "pre-\($0)\(monthDate)", index: $0)
            }
        ForEach(preEmptyCells) { _ in
            VStack(spacing: BPKSpacing.none) {
                emptyLeadingDayCell()
                    .frame(height: dayCellHeight)
                Spacer(minLength: BPKSpacing.none)
            }
        }
    }
    
    @ViewBuilder
    private func remainingEmptyCells(remainingCells: Int) -> some View {
        if remainingCells < daysInAWeek {
            let remainingEmptyCells = Array(0..<remainingCells)
                .map {
                    DayCellIdentifiable(id: "rem-\($0)\(monthDate)", index: $0)
                }
            ForEach(remainingEmptyCells) { _ in
                VStack(spacing: BPKSpacing.none) {
                    emptyTrailingDayCell()
                        .frame(height: dayCellHeight)
                    Spacer(minLength: BPKSpacing.none)
                }
            }
        }
    }
    
    private struct DayCellIdentifiable: Identifiable {
        let id: String
        let index: Int
    }
    
    @ViewBuilder
    private func dayCell(cellIndex: DayCellIdentifiable) -> some View {
        let dayDate = calendar.date(
            byAdding: .init(day: cellIndex.index),
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
            emptyLeadingDayCell: { Color.red },
            emptyTrailingDayCell: { Color.green },
            dayAccessoryView: { _ in
                BPKText("$200", style: .caption)
                    .foregroundColor(.infoBannerSuccessColor)
            }
        )
    }
}
