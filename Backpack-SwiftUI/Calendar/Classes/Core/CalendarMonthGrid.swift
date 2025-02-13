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
    DisabledDayCell: View,
    EmptyLeadingDayCell: View,
    EmptyTrailingDayCell: View,
    DayAccessoryView: View
>: View {
    let monthDate: Date
    let validRange: ClosedRange<Date>

    @State private var accessoryViewHeight: CGFloat?
    @State private var dayCellHeight: CGFloat?
    @ViewBuilder let dayCell: (Date) -> DayCell
    @ViewBuilder let disabledDayCell: (Date) -> DisabledDayCell
    @ViewBuilder let emptyLeadingDayCell: () -> EmptyLeadingDayCell
    @ViewBuilder let emptyTrailingDayCell: () -> EmptyTrailingDayCell
    @ViewBuilder let dayAccessoryView: (Date) -> DayAccessoryView
    
    let calculator: CalendarGridCalculator
    
    var body: some View {
        let grid = calculator.calculateCalendarGrid(monthDate: monthDate)
        
        VStack(alignment: .leading, spacing: .md) {
            ForEach(0..<grid.count, id: \.self) { row in
                weekRow(grid: grid, row: row)
            }
        }
    }
    
    @ViewBuilder
    private func weekRow(grid: [[Date?]], row: Int) -> some View {
        HStack(alignment: .top, spacing: BPKSpacing.none) {
            ForEach(0..<grid[0].count, id: \.self) { col in
                dayCellView(grid: grid, row: row, col: col)
            }
        }
    }
    
    @ViewBuilder
    private func dayCellView(grid: [[Date?]], row: Int, col: Int) -> some View {
        let dayDate = grid[row][col]
        if dayDate == nil {
            emptyCell(grid: grid, row: row)
        } else if let dayDate {
            dayCellView(dayDate: dayDate)
        }
    }
    
    @ViewBuilder
    private func dayCellView(dayDate: Date) -> some View {
        if !validRange.contains(dayDate) {
            VStack(spacing: cellsSpacing) {
                disabledDayCell(dayDate)
                    .frame(height: dayCellHeight)
                    .frame(maxWidth: .infinity)
                Spacer(minLength: BPKSpacing.none)
                    .frame(maxWidth: .infinity)
                    .frame(height: accessoryViewHeight)
            }
            .frame(maxWidth: .infinity)
        } else {
            VStack(spacing: cellsSpacing) {
                dayCell(dayDate)
                    .frame(height: dayCellHeight)
                    .frame(maxWidth: .infinity)
                    .modifier(ReadSizeModifier { dayCellHeight = max($0.height, dayCellHeight ?? 0) })
                dayAccessoryView(dayDate)
                    .frame(maxWidth: .infinity)
                    .frame(height: accessoryViewHeight)
                    .modifier(ReadSizeModifier { accessoryViewHeight = max($0.height, accessoryViewHeight ?? 0) })
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    private func emptyCell(grid: [[Date?]], row: Int) -> some View {
        if row == 0 {
            emptyLeadingDayCell()
                .frame(maxWidth: .infinity)
                .frame(height: dayCellHeight)
        } else if row == grid.count - 1 {
            emptyTrailingDayCell()
                .frame(maxWidth: .infinity)
                .frame(height: dayCellHeight)
        }
    }
    
    var cellsSpacing: BPKSpacing {
        if let accessoryViewHeight, accessoryViewHeight > 0 {
            return .sm
        } else {
            return .none
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
            validRange: start...end,
            dayCell: { day in
                BPKText("\(calendar.component(.day, from: day))")
            },
            disabledDayCell: { DisabledCalendarDayCell(calendar: calendar, date: $0) },
            emptyLeadingDayCell: { Color.red },
            emptyTrailingDayCell: { Color.green },
            dayAccessoryView: { _ in
                BPKText("$200", style: .caption)
                    .foregroundColor(.infoBannerSuccessColor)
            },
            calculator: DefaultCalendarGridCalculator(calendar: calendar)
        )
    }
}
