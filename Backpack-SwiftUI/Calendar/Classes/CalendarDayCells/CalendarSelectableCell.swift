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

struct CalendarSelectableCell: View {
    let selectionType: CalendarSelectionType
    let calendar: Calendar
    let accessibilityProvider: CalendarAccessibilityConfiguration
    let dayDate: Date
    let onSelection: (Date) -> Void
    
    var body: some View {
        Group {
            switch selectionType {
            case .range(let selectionState, _):
                rangeView(selectionState: selectionState.wrappedValue)
            case .single(let selection, _):
                singleView(selectionState: selection.wrappedValue)
            }
        }.onTapGesture(perform: {
            onSelection(dayDate)
        })
    }
    
    @ViewBuilder private func rangeView(selectionState: CalendarRangeSelectionState?) -> some View {
        if case .intermediate(let date) = selectionState,
            initialSelection(date, matchesDate: dayDate) {
            singleCell(date: date)
        } else if case .range(let range) = selectionState, range.contains(dayDate) {
            rangeCell(closedRange: range, highlightRangeEnds: true)
        } else if case .wholeMonth(let range) = selectionState, range.contains(dayDate) {
            wholeMonthRangeCell(range: range)
        } else {
            defaultCell
        }
    }
    
    @ViewBuilder private func singleView(selectionState: CalendarSingleSelectionState?) -> some View {
        switch selectionState {
        case .single(let date):
            if date == dayDate {
                singleCell(date: date)
            } else {
                defaultCell
            }
        case .wholeMonth(let closedRange, _):
            if closedRange.contains(dayDate) {
                rangeCell(closedRange: closedRange, highlightRangeEnds: false)
            } else {
                defaultCell
            }
        case .none:
            defaultCell
        }
    }
    
    private var defaultCell: some View {
        DefaultCalendarDayCell(calendar: calendar, date: dayDate)
            .if(accessibilityProvider.rangeSelection != nil) { cell in
                cell.accessibilityLabel(Text(
                    accessibilityProvider.rangeSelection?.accessibilityLabel(for: dayDate) ?? ""
                ))
            }
    }
    
    private func singleCell(date: Date) -> some View {
        SingleSelectedCell(calendar: calendar, date: dayDate)
            .if(accessibilityProvider.rangeSelection != nil) { cell in
                cell.accessibilityLabel(Text(
                    accessibilityProvider.rangeSelection?.accessibilityLabel(
                        for: dayDate,
                        intermediateSelectionDate: date
                    ) ?? ""
                ))
            }
    }
    
    private func rangeCell(closedRange: ClosedRange<Date>, highlightRangeEnds: Bool) -> some View {
        RangeSelectionCalendarDayCell(
            date: dayDate,
            selection: closedRange,
            calendar: calendar,
            highlightRangeEnds: highlightRangeEnds
        )
        .accessibility(addTraits: .isSelected)
        .if(accessibilityProvider.rangeSelection != nil) { cell in
            cell.accessibilityLabel(Text(
                accessibilityProvider.rangeSelection?.accessibilityLabel(
                    for: dayDate,
                    selection: closedRange
                ) ?? ""
            ))
        }
    }
    
    private func wholeMonthRangeCell(range: ClosedRange<Date>) -> some View {
        RangeSelectionCalendarDayCell(
            date: dayDate,
            selection: range,
            calendar: calendar,
            highlightRangeEnds: false
        )
        .accessibility(addTraits: .isSelected)
        .if(accessibilityProvider.rangeSelection != nil) { cell in
            cell.accessibilityLabel(Text(
                accessibilityProvider.rangeSelection?.accessibilityLabel(
                    for: dayDate,
                    selection: range
                ) ?? ""
            ))
        }
    }
    
    private func initialSelection(_ initialDateSelection: Date, matchesDate date: Date) -> Bool {
        let matchingDayComponents = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(initialDateSelection, matchesComponents: matchingDayComponents)
    }
}
