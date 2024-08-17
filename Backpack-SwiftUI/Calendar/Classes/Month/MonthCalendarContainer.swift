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

struct MonthCalendarContainer<MonthHeader: View, DayAccessoryView: View>: View {
    @Binding var selection: CalendarMonthSelectionState?
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    let accessibilityProvider: MonthDayAccessibilityProvider
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    @ViewBuilder let dayAccessoryView: (Date) -> DayAccessoryView

    private func handleSelection(_ date: Date) {
//        if let selection {
//            selection = .init(year: , month: )
//        }
    }

    @ViewBuilder
    private func cell(_ dayDate: Date) -> some View {
        cellContainer(dayDate)
        .accessibilityLabel(Text(
            accessibilityProvider.accessibilityLabel(
                for: dayDate
            )
        ))
        .accessibility(addTraits: isSelected(dayDate) ? .isSelected : [])
    }

    @ViewBuilder
    private func cellContainer(_ dayDate: Date) -> some View {
        if case .range(let range) = selection, range.contains(dayDate) {
            MonthSelectionCalendarDayCell(
                date: dayDate,
                selection: range,
                calendar: calendar
            )
        } else {
            DefaultCalendarDayCell(calendar: calendar, date: dayDate)
                .accessibilityLabel(Text(
                    accessibilityProvider.accessibilityLabel(for: dayDate)
                ))
        }
    }

    private func isSelected(_ dayDate: Date) -> Bool {
        // TODO: Fix
        return true // closedRange.contains(dayDate)

    }

    @ViewBuilder
    private func makeDayCell(_ dayDate: Date) -> some View {
        CalendarSelectableCell {
            cell(dayDate)
        } onSelection: {
            // TODO: selection action
//            handleSelection(dayDate)
        }
        // TODO: accessibility
//        .accessibilityHint(Text(
//            accessibilityProvider.accessibilityHint(
//                for: dayDate,
//                rangeSelectionState: selectionState
//            )
//        ))
//        .accessibility(addTraits: .isButton)
    }

    private func initialSelection(_ initialDateSelection: Date, matchesDate date: Date) -> Bool {
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
            let selection, case .range(let range) = selection,
            let lastDayOfPreviousMonth = calendar.date(byAdding: .init(day: -1), to: firstDayOfMonth),
            let firstDayOfCurrentMonth = calendar.date(byAdding: .init(day: 1), to: lastDayOfPreviousMonth),
            range.contains(lastDayOfPreviousMonth),
            range.contains(firstDayOfCurrentMonth)
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
            let selection, case .range(let range) = selection,
            let firstDayOfNextMonth = calendar.date(byAdding: .init(month: 1), to: firstDayOfMonth),
            let lastDayOfCurrentMonth = calendar.date(byAdding: .init(day: -1), to: firstDayOfNextMonth),
            range.contains(lastDayOfCurrentMonth),
            range.contains(firstDayOfNextMonth)
        {
            Color(.surfaceSubtleColor)
        }
    }
}

//struct RangeCalendarContainer_Previews: PreviewProvider {
//    static let formatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter
//    }()
//
//    static var previews: some View {
//        let calendar = Calendar.current
//
//        let start = calendar.date(from: .init(year: 2023, month: 10, day: 1))!
//        let end = calendar.date(from: .init(year: 2025, month: 12, day: 25))!
//
//        let startSelection = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
//        let endSelection = calendar.date(from: .init(year: 2023, month: 11, day: 10))!
//
//        RangeCalendarContainer(
//            selectionState: .constant(.range(startSelection...endSelection)),
//            calendar: calendar,
//            validRange: start...end,
//            accessibilityProvider: RangeDayAccessibilityProvider(
//                accessibilityConfigurations: .init(
//                    startSelectionHint: "",
//                    endSelectionHint: "",
//                    startSelectionState: "",
//                    endSelectionState: "",
//                    betweenSelectionState: "",
//                    startAndEndSelectionState: "",
//                    returnDatePrompt: ""
//                ),
//                dateFormatter: Self.formatter
//            ),
//            monthHeader: { month in
//                BPKText("\(Self.formatter.string(from: month))")
//            },
//            dayAccessoryView: { _ in
//                BPKText("20", style: .caption)
//            }
//        )
//    }
//}
