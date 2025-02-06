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

private enum DayCellType {
    case day
    case leadingEmpty
    case trailingEmpty
}

private struct DayCellIdentifiable: Identifiable {
    let id: String
    let index: Int
    let type: DayCellType
}

struct CalendarMonthGrid<
    DayCell: View,
    EmptyLeadingDayCell: View,
    EmptyTrailingDayCell: View,
    DayAccessoryView: View
>: View {
    let monthDate: Date
    let calendar: Calendar
    let validRange: ClosedRange<Date>

    @State private var dayCellHeight: CGFloat?
    @Binding var accessoryViewHeight: CGFloat?
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

        LazyVGrid(
            columns: Array(repeating: GridItem(spacing: BPKSpacing.none.value), count: daysInAWeek),
            spacing: BPKSpacing.md.value
        ) {
            let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: monthDate)!.count
            let totalCellsUsed = numberOfDaysInMonth + daysFromPreviousMonth
            let remainingCells = if (daysInAWeek - (totalCellsUsed % daysInAWeek)) == daysInAWeek {
                0
            } else {
                daysInAWeek - (totalCellsUsed % daysInAWeek)
            }

            currentMonthDayCell(
                numberOfLeadingCells: daysFromPreviousMonth,
                numberOfTrailingCells: remainingCells,
                numberOfDaysInMonth: numberOfDaysInMonth
            )
        }
    }
    
    var emptyCellSpacing: BPKSpacing {
        if let accessoryViewHeight, accessoryViewHeight > 0 {
            return .sm
        } else {
            return .none
        }
    }
    
    var totalCellHeight: CGFloat? {
        guard let dayCellHeight, let accessoryViewHeight else { return nil }
        return dayCellHeight + accessoryViewHeight + BPKSpacing.sm.value
    }
    
    @ViewBuilder
    private func currentMonthDayCell(
        numberOfLeadingCells: Int,
        numberOfTrailingCells: Int,
        numberOfDaysInMonth: Int
    ) -> some View {
        // Create cells for the days in the current month
        let days = Array(0..<numberOfDaysInMonth).map {
            DayCellIdentifiable(id: "\(monthDate)\($0)", index: $0, type: .day)
        }
        // Create cells for the days from the previous month that are shown in the first week of the current month.
        let leading = Array(0..<numberOfLeadingCells).map {
            DayCellIdentifiable(id: "pre-\($0)", index: $0, type: .leadingEmpty)
        }
        // Create cells for the days from the next month that are shown in the last week of the current month
        // The total number of cells used is the sum of the number of days in the current month and the number of
        // days from the previous month that are shown
        let trailing = Array(0..<numberOfTrailingCells).map {
            DayCellIdentifiable(id: "rem-\($0)", index: $0, type: .trailingEmpty)
        }
        let total = leading + days + trailing
        
        ForEach(total) { cell in
            switch cell.type {
            case .leadingEmpty:
                VStack(spacing: emptyCellSpacing) {
                    emptyLeadingDayCell()
                        .frame(height: dayCellHeight)
                    Spacer(minLength: BPKSpacing.none)
                        .frame(height: accessoryViewHeight)
                }
            case .day:
                dayCell(for: cell.index)
            case .trailingEmpty:
                VStack(spacing: emptyCellSpacing) {
                    emptyTrailingDayCell()
                        .frame(height: dayCellHeight)
                    Spacer(minLength: BPKSpacing.none)
                        .frame(height: accessoryViewHeight)
                }
                .frame(height: totalCellHeight)
            }
            
        }
    }
    
    @ViewBuilder private func dayCell(for index: Int) -> some View {
        let dayDate = calendar.date(
            byAdding: .init(day: index),
            to: monthDate
        )!
        
        if !validRange.contains(dayDate) {
            VStack(spacing: BPKSpacing.none) {
                DisabledCalendarDayCell(calendar: calendar, date: dayDate)
                    .frame(height: dayCellHeight)
                Spacer(minLength: BPKSpacing.none)
                    .frame(height: accessoryViewHeight)
            }
        } else {
            VStack(spacing: BPKSpacing.sm) {
                dayCell(dayDate)
                    .modifier(ReadSizeModifier {
                        dayCellHeight = max($0.height, dayCellHeight ?? 0)
                    })
                    .frame(height: dayCellHeight)
                dayAccessoryView(dayDate)
                    .modifier(ReadSizeModifier {
                        let height = CGFloat(ceil(Double($0.height)))
                        if accessoryViewHeight != height {
                            print("accessoryViewHeight", height)
                            accessoryViewHeight = max(height, accessoryViewHeight ?? 0)
                        }
                    })
                    .frame(height: accessoryViewHeight)
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
            accessoryViewHeight: .constant(0),
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
