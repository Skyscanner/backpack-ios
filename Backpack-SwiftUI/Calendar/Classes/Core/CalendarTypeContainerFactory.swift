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

struct CalendarTypeContainerFactory<MonthHeader: View, DayAccessoryView: View>: View {
    let selectionType: CalendarSelectionType
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    let monthScroll: MonthScroll?
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    @ViewBuilder let dayAccessoryView: (Date) -> DayAccessoryView
    
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
            switch selectionType {
            case .range(let selection, let accessibilityConfigurations):
                rangeMonthContainer(
                    forMonth: month,
                    selection: selection,
                    accessibilityConfigurations: accessibilityConfigurations
                )
            case .single(let selection, let accessibilityConfigurations):
                singleCalendarMonthContainer(
                    forMonth: month,
                    selection: selection,
                    accessibilityConfigurations: accessibilityConfigurations
                )
            }
        }
    }
    
    @ViewBuilder
    private func singleCalendarMonthContainer(
        forMonth month: Date,
        selection: Binding<CalendarSingleSelectionState?>,
        accessibilityConfigurations: SingleAccessibilityConfigurations
    ) -> some View {
        SingleCalendarMonthContainer(
            selection: selection,
            calendar: calendar,
            validRange: validRange,
            accessibilityProvider: SingleDayAccessibilityProvider(
                accessibilityConfigurations: accessibilityConfigurations,
                dateFormatter: accessibilityDateFormatter
            ),
            month: month,
            monthHeader: { monthHeader(month) },
            dayAccessoryView: dayAccessoryView
        )
    }
    
    @ViewBuilder
    private func rangeMonthContainer(
        forMonth month: Date,
        selection: Binding<CalendarRangeSelectionState?>,
        accessibilityConfigurations: RangeAccessibilityConfigurations
    ) -> some View {
        RangeCalendarMonthContainer(
            selectionState: selection,
            calendar: calendar,
            validRange: validRange,
            accessibilityProvider: RangeDayAccessibilityProvider(
                accessibilityConfigurations: accessibilityConfigurations,
                dateFormatter: accessibilityDateFormatter
            ),
            month: month,
            selectionHandler: DefaultRangeCalendarSelectionHandler(
                instructionAfterSelectingDate: accessibilityConfigurations.returnDatePrompt
            ),
            monthHeader: { monthHeader(month) },
            dayAccessoryView: dayAccessoryView
        )

    }
}
