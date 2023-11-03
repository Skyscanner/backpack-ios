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

struct CalendarMonthGrid<DayCell: View, EmptyDayCell: View>: View {
    let monthDate: Date
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    @ViewBuilder let dayCell: (Date) -> DayCell
    @ViewBuilder let emptyDayCell: (Date, Int) -> EmptyDayCell
    
    var body: some View {
        let firstWeekdayOfMonth = calendar.component(.weekday, from: monthDate)
        LazyVGrid(
            columns: Array(repeating: GridItem(spacing: BPKSpacing.none.value), count: 7),
            spacing: BPKSpacing.lg.value
        ) {
            // Always attempt to show 6 weeks and 7 days per week
            ForEach(0..<42) { cellIndex in
                let dayDate = calendar.date(
                    byAdding: .init(day: cellIndex - firstWeekdayOfMonth + 2),
                    to: monthDate
                )!
                // Only show days in the current month
                let matchingComponents = calendar.dateComponents([.year, .month], from: dayDate)
                if calendar.date(monthDate, matchesComponents: matchingComponents) {
                    if !validRange.contains(dayDate) {
                        DisabledSelectionCell(calendar: calendar, date: dayDate)
                    } else {
                        dayCell(dayDate)
                    }
                } else {
                    emptyDayCell(dayDate, cellIndex)
                }
            }
        }
    }
}

struct CalendarMonthGrid_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
        let end = calendar.date(from: .init(year: 2025, month: 12, day: 25))!
        
        CalendarMonthGrid(
            monthDate: Date(),
            calendar: Calendar.current,
            validRange: start...end,
            dayCell: { day in
                BPKText("\(Calendar.current.component(.day, from: day))")
            },
            emptyDayCell: { _, _ in
                Color.clear
            }
        )
    }
}
