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

struct RangeSelectionCalendarDayCell: View {
    let date: Date
    let selection: ClosedRange<Date>
    let calendar: Calendar
    let highlightRangeEnds: Bool

    var body: some View {
        if selection.lowerBound == selection.upperBound {
            LowerAndUpperBoundSelectedCell(calendar: calendar, date: date)
        } else if date == selection.lowerBound {
            LowerBoundSelectedCell(calendar: calendar, date: date, highlighted: highlightRangeEnds)
        } else if date == selection.upperBound {
            UpperBoundSelectedCell(calendar: calendar, date: date, highlighted: highlightRangeEnds)
        } else {
            InbetweenSelectionCell(calendar: calendar, date: date)
        }
    }
}

struct SelectedCalendarDayCell_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let date = calendar.date(from: .init(year: 2023, month: 11, day: 8))!
        
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 6), spacing: 0) {
            DefaultCalendarDayCell(calendar: calendar, date: date)
            DisabledCalendarDayCell(calendar: calendar, date: date)
            LowerBoundSelectedCell(calendar: calendar, date: date, highlighted: true)
            InbetweenSelectionCell(calendar: calendar, date: date)
            UpperBoundSelectedCell(calendar: calendar, date: date, highlighted: true)
            LowerAndUpperBoundSelectedCell(calendar: calendar, date: date)
        }
    }
}
