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

protocol RangeCalendarSelectionHandler {
    func newStateFor(
        selection date: Date,
        currentSelection: CalendarRangeSelectionState?
    ) -> CalendarRangeSelectionState
}

struct DefaultRangeCalendarSelectionHandler: RangeCalendarSelectionHandler {
    let instructionAfterSelectingDate: String
    
    func newStateFor(
        selection date: Date,
        currentSelection: CalendarRangeSelectionState?
    ) -> CalendarRangeSelectionState {
        switch currentSelection {
        case .intermediate(let initialDateSelection):
            if date < initialDateSelection {
                UIAccessibility.post(
                    notification: .announcement,
                    argument: instructionAfterSelectingDate
                )
                return .intermediate(date)
            } else {
                return .range(initialDateSelection...date)
            }
        default:
            UIAccessibility.post(
                notification: .announcement,
                argument: instructionAfterSelectingDate
            )
            return .intermediate(date)
        }
    }
}

struct RangeCalendarMonthContainer<MonthHeader: View, DayAccessoryView: View>: View {
    @Binding var selectionState: CalendarRangeSelectionState?
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    let accessibilityProvider: RangeDayAccessibilityProvider
    let month: Date
    let selectionHandler: RangeCalendarSelectionHandler
    @ViewBuilder let monthHeader: MonthHeader
    @ViewBuilder let dayAccessoryView: (Date) -> DayAccessoryView
    
    private func handleSelection(_ date: Date) {
        selectionState = selectionHandler.newStateFor(selection: date, currentSelection: selectionState)
    }
    
    @ViewBuilder
    private func cell(_ dayDate: Date) -> some View {
        if
            case .intermediate(let selectedDate) = selectionState,
            initialSelection(selectedDate, matchesDate: dayDate)
        {
            SingleSelectedCell(calendar: calendar, date: dayDate)
                .accessibilityLabel(Text(
                    accessibilityProvider.accessibilityLabel(
                        for: dayDate,
                        intermediateSelectionDate: selectedDate
                    )
                ))
        } else if case .range(let closedRange) = selectionState, closedRange.contains(dayDate) {
            RangeSelectionCalendarDayCell(
                date: dayDate,
                selection: closedRange,
                calendar: calendar,
                highlightRangeEnds: true
            )
            .accessibilityLabel(Text(
                accessibilityProvider.accessibilityLabel(
                    for: dayDate,
                    selection: closedRange
                )
            ))
            .accessibility(addTraits: .isSelected)
        } else if case .wholeMonth(let closedRange) = selectionState, closedRange.contains(dayDate) {
            RangeSelectionCalendarDayCell(
                date: dayDate,
                selection: closedRange,
                calendar: calendar,
                highlightRangeEnds: false
            )
            .accessibilityLabel(Text(
                accessibilityProvider.accessibilityLabel(
                    for: dayDate,
                    selection: closedRange
                )
            ))
            .accessibility(addTraits: .isSelected)
        } else {
            DefaultCalendarDayCell(calendar: calendar, date: dayDate)
                .accessibilityLabel(Text(
                    accessibilityProvider.accessibilityLabel(for: dayDate)
                ))
        }
    }
    
    @ViewBuilder
    private func makeDayCell(_ dayDate: Date) -> some View {
        CalendarSelectableCell {
            cell(dayDate)
        } onSelection: {
            handleSelection(dayDate)
        }
        .accessibilityHint(Text(
            accessibilityProvider.accessibilityHint(
                for: dayDate,
                rangeSelectionState: selectionState
            )
        ))
        .accessibility(addTraits: .isButton)
    }
    
    private func initialSelection(_ initialDateSelection: Date, matchesDate date: Date) -> Bool {
        let matchingDayComponents = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(initialDateSelection, matchesComponents: matchingDayComponents)
    }
    
    var body: some View {
        VStack(spacing: BPKSpacing.none) {
            monthHeader
            CalendarMonthGrid(
                monthDate: month,
                calendar: calendar,
                validRange: validRange,
                dayCell: makeDayCell,
                emptyLeadingDayCell: { makeEmptyLeadingDayCell(for: month) },
                emptyTrailingDayCell: { makeEmptyTrailingDayCell(for: month) },
                dayAccessoryView: dayAccessoryView
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
            case .range(let selection) = selectionState,
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
            case .range(let selection) = selectionState,
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

        RangeCalendarMonthContainer(
            selectionState: .constant(.range(startSelection...endSelection)),
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
            month: start,
            selectionHandler: DefaultRangeCalendarSelectionHandler(
                instructionAfterSelectingDate: ""
            ),
            monthHeader: {
                BPKText("\(Self.formatter.string(from: start))")
            },
            dayAccessoryView: { _ in
                BPKText("20", style: .caption)
            }
        )
    }
}
