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

struct EmptyRangeSelectionCalendarDayCell: View {
    let cellIndex: Int
    let correspondingDate: Date
    let selection: ClosedRange<Date>?
    
    var body: some View {
        if let selection, selection.contains(correspondingDate) {
            if cellIndex < 8 { // First week row
                Color(.surfaceSubtleColor)
            } else if cellIndex < 35 { // Last week row
                Color(.surfaceSubtleColor)
            }
        } else if cellIndex < 8 { // First week row, needed to fill the grid
            DefaultEmptyCalendarDayCell()
        }
    }
}

struct EmptyRangeSelectionCalendarDayCell_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let date = calendar.date(from: .init(year: 2023, month: 11, day: 8))!
        let startSelection = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
        let endSelection = calendar.date(from: .init(year: 2023, month: 11, day: 10))!
        
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 3), spacing: 0) {
            LowerBoundSelectedCell(calendar: calendar, date: date, highlighted: true)
            EmptyRangeSelectionCalendarDayCell(
                cellIndex: 0,
                correspondingDate: date,
                selection: startSelection...endSelection
            )
            UpperBoundSelectedCell(calendar: calendar, date: date, highlighted: true)

        }
    }
}
