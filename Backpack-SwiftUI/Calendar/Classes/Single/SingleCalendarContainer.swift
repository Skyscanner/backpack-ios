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

struct SingleCalendarMonthContainer<DayAccessoryView: View>: View {
    @Binding var selection: CalendarSingleSelectionState?
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    let accessibilityProvider: SingleDayAccessibilityProvider
    let month: Date
    let calculator: CalendarGridCalculator
    let selectionHandler: SingleCalendarSelectionHandler
    let highlightedDates: Set<Date>?
    @ViewBuilder let dayAccessoryView: (Date) -> DayAccessoryView
    
    @ViewBuilder
    private func makeDayCell(_ dayDate: Date) -> some View {
        CalendarSelectableCell {
            createCell(dayDate: dayDate)
        } onSelection: {
            selection = selectionHandler.newSingleSelectionStateFor(
                selection: dayDate,
                currentSelection: selection,
                accessibilityAnnouncement: { announcementText in
                    UIAccessibility.post(
                        notification: .announcement,
                        argument: announcementText
                    )
                }
            )
        }
        .accessibilityAddTraits(selection?.isSelected(dayDate) == true ? .isSelected : [])
        .accessibilityLabel(accessibilityProvider.accessibilityLabel(for: dayDate, selection: selection))
        .accessibilityHint(accessibilityProvider.accessibilityHint(for: dayDate, selection: selection))
    }

    var body: some View {
        CalendarMonthGrid(
            monthDate: month,
            validRange: validRange,
            dayCell: makeDayCell,
            disabledDayCell: { date in
                if highlightedDates?.contains(date) ?? false {
                    DisabledHighlightedDayCell(calendar: calendar, date: date)
                } else {
                    DisabledCalendarDayCell(calendar: calendar, date: date)
                }
            },
            emptyLeadingDayCell: { DefaultEmptyCalendarDayCell() },
            emptyTrailingDayCell: { DefaultEmptyCalendarDayCell() },
            dayAccessoryView: dayAccessoryView,
            calculator: calculator
        )
    }
    
    @ViewBuilder func createCell(dayDate: Date) -> some View {
        switch selection {
        case .single(let date):
            if highlightedDates?.contains(dayDate) ?? false && date == dayDate {
                LowerAndUpperBoundSelectedCell(calendar: calendar, date: dayDate)
            } else if date == dayDate {
                SingleSelectedCell(calendar: calendar, date: dayDate)
            } else if highlightedDates?.contains(dayDate) ?? false {
                HighlightedCalendarDayCell(calendar: calendar, date: dayDate)
            } else {
                DefaultCalendarDayCell(calendar: calendar, date: dayDate)
            }
        case .wholeMonth(let closedRange, _):
            if closedRange.contains(dayDate) {
                RangeSelectionCalendarDayCell(
                    date: dayDate,
                    selection: closedRange,
                    calendar: calendar,
                    highlightRangeEnds: false
                )
            } else {
                DefaultCalendarDayCell(calendar: calendar, date: dayDate)
            }
        case .none:
            if highlightedDates?.contains(dayDate) ?? false {
                HighlightedCalendarDayCell(calendar: calendar, date: dayDate)
            } else {
                DefaultCalendarDayCell(calendar: calendar, date: dayDate)
            }
        }
    }
}

struct SingleCalendarContainer_Previews: PreviewProvider {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    static var previews: some View {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
        let end = calendar.date(from: .init(year: 2025, month: 12, day: 25))!

        SingleCalendarMonthContainer(
            selection: .constant(.single(calendar.date(from: .init(year: 2023, month: 11, day: 10))!)),
            calendar: calendar,
            validRange: start...end,
            accessibilityProvider: SingleDayAccessibilityProvider(
                accessibilityConfigurations: .predefined(labels: .init(selectionState: "", selectionHint: "")),
                dateFormatter: Self.formatter
            ),
            month: start,
            calculator: DefaultCalendarGridCalculator(calendar: calendar),
            selectionHandler: DefaultSingleCalendarSelectionHandler(),
            highlightedDates: nil,
            dayAccessoryView: { _ in
                BPKText("20", style: .caption)
            }
        )
    }
}
