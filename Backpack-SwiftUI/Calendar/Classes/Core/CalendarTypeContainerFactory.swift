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

public struct CalendarAccessibilityConfiguration {
    public let singleSelection: SingleDayAccessibilityProvider
    public let rangeSelection: RangeDayAccessibilityProvider
    public init(singleSelection: SingleDayAccessibilityProvider, rangeSelection: RangeDayAccessibilityProvider) {
        self.singleSelection = singleSelection
        self.rangeSelection = rangeSelection
    }
}

struct CalendarTypeContainerFactory<MonthHeader: View, DayAccessoryView: View>: View {
    let selectionType: CalendarSelectionType
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    let monthScroll: MonthScroll?
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    @ViewBuilder let dayAccessoryView: (Date) -> DayAccessoryView
    var calendarAccessibilityConfiguration: CalendarAccessibilityConfiguration
    
    private var accessibilityDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = calendar.locale
        formatter.dateStyle = .full
        return formatter
    }

    var body: some View {
        CalendarContainer(
            calendar: calendar,
            validRange: validRange,
            monthScroll: monthScroll
        ) { month in
            monthHeader(month)
            CalendarMonthGrid(
                monthDate: month,
                calendar: calendar,
                validRange: validRange,
                dayCell: returnMakeCellFunction(),
                emptyLeadingDayCell: { DefaultEmptyCalendarDayCell() },
                emptyTrailingDayCell: { DefaultEmptyCalendarDayCell() },
                dayAccessoryView: dayAccessoryView
            )
        }
    }
    
    func returnMakeCellFunction() -> ((Date) -> CalendarSelectableCell) {
        return { dayDate in
            CalendarSelectableCell(
                selectionType: selectionType,
                calendar: calendar,
                accessibilityProvider: calendarAccessibilityConfiguration,
                dayDate: dayDate,
                onSelection: handleSelection
            )
        }
        
    }
    
    func handleSelection(dayDate: Date) {
        switch selectionType {
        case .range(let selection, _):
            switch selection.wrappedValue {
            case .intermediate(let initialDateSelection):
                if dayDate < initialDateSelection {
                    selection.wrappedValue = .intermediate(dayDate)
                    UIAccessibility.post(
                        notification: .announcement,
                        argument: calendarAccessibilityConfiguration.rangeSelection
                            .accessibilityInstructionAfterSelectingDate()
                    )
                } else {
                    selection.wrappedValue = .range(initialDateSelection...dayDate)
                }
            default:
                selection.wrappedValue = .intermediate(dayDate)
                UIAccessibility.post(
                    notification: .announcement,
                    argument: calendarAccessibilityConfiguration.rangeSelection
                        .accessibilityInstructionAfterSelectingDate()
                )
            }
        case .single(let selection, _):
            selection.wrappedValue = .single(dayDate)
        }
    }
}
