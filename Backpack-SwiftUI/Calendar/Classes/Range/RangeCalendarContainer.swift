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

struct RangeCalendarContainer<MonthHeader: View>: View {
    @State private var initialDateSelection: Date?
    @Binding var selection: ClosedRange<Date>?
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    let accessibilityProvider: RangeDayAccessibilityProvider
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    
    private func handleSelection(_ date: Date) {
        if selection != nil {
            initialDateSelection = date
            selection = nil
        } else {
            if let initialDateSelection {
                if date < initialDateSelection {
                    self.initialDateSelection = date
                } else {
                    selection = initialDateSelection...date
                    self.initialDateSelection = nil
                }
            } else {
                initialDateSelection = date
                UIAccessibility.post(
                    notification: .announcement,
                    argument: accessibilityProvider.accessibilityInstructionAfterSelectingDate()
                )
            }
        }
    }
    
    @ViewBuilder
    private func makeDayCell(_ dayDate: Date) -> some View {
        if !validRange.contains(dayDate) {
            DisabledCalendarDayCell(calendar: calendar, date: dayDate)
        } else {
            CalendarSelectableCell {
                if let initialDateSelection, initialSelection(matchesDate: dayDate) {
                    SingleSelectedCell(calendar: calendar, date: initialDateSelection)
                } else {
                    RangeSelectionCalendarDayCell(date: dayDate, selection: $selection, calendar: calendar)
                }
            } onSelection: {
                handleSelection(dayDate)
            }
            .accessibilityLabel(Text(
                accessibilityProvider.accessibilityLabel(
                    for: dayDate,
                    selection: selection
                )
            ))
            .accessibilityHint(Text(
                accessibilityProvider.accessibilityHint(
                    for: dayDate,
                    selection: selection,
                    initialDateSelection: initialDateSelection
                )
            ))
            .accessibility(addTraits: .isButton)
            .accessibility(addTraits: selection?.contains(dayDate) == true ? .isSelected : [])
        }
    }
    
    private func initialSelection(matchesDate date: Date) -> Bool {
        guard let initialDateSelection else { return false }
        let matchingDayComponents = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(initialDateSelection, matchesComponents: matchingDayComponents)
    }
    
    var body: some View {
        CalendarContainer(
            calendar: calendar,
            validRange: validRange
        ) { month in
            monthHeader(month)
            CalendarMonthGrid(
                monthDate: month,
                calendar: calendar,
                validRange: validRange,
                dayCell: makeDayCell,
                emptyLeadingDayCell: { makeEmptyLeadingDayCell(for: month) },
                emptyTrailingDayCell: { makeEmptyTrailingDayCell(for: month) }
            )
        }
    }
    
    /// - Parameters:
    ///   - firstDayOfMonth: The first day of the month we are showing
    @ViewBuilder
    private func makeEmptyLeadingDayCell(for firstDayOfMonth: Date) -> some View {
        // if both the last day of the previous month and the first of the current are selected, we want to show the
        // selected surface color
        if
            let selection,
            let lastDayOfPreviousMonth = calendar.date(byAdding: .init(day: -1), to: firstDayOfMonth),
            let firstDayOfCurrentMonth = calendar.date(byAdding: .init(day: 1), to: lastDayOfPreviousMonth),
            selection.contains(lastDayOfPreviousMonth),
            selection.contains(firstDayOfCurrentMonth)
        {
            Color(.surfaceSubtleColor)
        } else {
            // otherwise we occupy the space with a clear view
            DefaultEmptyCalendarDayCell()
        }
    }

    /// - Parameters:
    ///   - firstDayOfMonth: The first day of the month we are showing
    @ViewBuilder
    private func makeEmptyTrailingDayCell(for firstDayOfMonth: Date) -> some View {
        // if both the last day of the current month and the first of the next are selected, we want to show the
        // space between them as selected
        if
            let selection,
            let firstDayOfNextMonth = calendar.date(byAdding: .init(month: 1), to: firstDayOfMonth),
            let lastDayOfCurrentMonth = calendar.date(byAdding: .init(day: -1), to: firstDayOfNextMonth),
            selection.contains(lastDayOfCurrentMonth),
            selection.contains(firstDayOfNextMonth)
        {
            Color(.surfaceSubtleColor)
        }
    }
}

struct RangeCalendarContainer_Previews: PreviewProvider {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    static var previews: some View {
        let calendar = Calendar.current
        
        let start = calendar.date(from: .init(year: 2023, month: 10, day: 1))!
        let end = calendar.date(from: .init(year: 2025, month: 12, day: 25))!
        
        let startSelection = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
        let endSelection = calendar.date(from: .init(year: 2023, month: 11, day: 10))!
        
        RangeCalendarContainer(
            selection: .constant(startSelection...endSelection),
            calendar: calendar,
            validRange: start...end,
            accessibilityProvider: RangeDayAccessibilityProvider(
                accessibilityConfigurations: .init(
                    startSelectionHint: "",
                    endSelectionHint: "",
                    startSelectionState: "",
                    endSelectionState: "",
                    betweenSelectionState: "",
                    startAndEndSelectionState: "",
                    returnDatePrompt: ""
                ),
                dateFormatter: Self.formatter
            ),
            monthHeader: { month in
                BPKText("\(Self.formatter.string(from: month))")
            }
        )
    }
}
