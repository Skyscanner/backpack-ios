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
    let singleCalendarSelectionHandler: SingleCalendarSelectionHandler
    let rangeCalendarSelectionHandler: RangeCalendarSelectionHandler
    let validRange: ClosedRange<Date>
    let monthScroll: MonthScroll?
    let onScrollToMonth: ((Date) -> Void)?
    let scrollDebounceThreshold: Int
    let calculator: CalendarGridCalculator
    let parentProxy: GeometryProxy
    let highlightedDates: Set<Date>?
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    @ViewBuilder let dayAccessoryView: (Date) -> DayAccessoryView
    
    private var accessibilityDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = calendar.locale
        formatter.timeZone = calendar.timeZone
        formatter.dateStyle = .full
        return formatter
    }

    var body: some View {
        CalendarContainer(
            calendar: calendar,
            validRange: adjustedValidRange,
            parentProxy: parentProxy,
            monthScroll: monthScroll,
            onScrollToMonth: onScrollToMonth,
            scrollDebounceThreshold: scrollDebounceThreshold
        ) { month in
            VStack(spacing: BPKSpacing.none) {
                monthHeader(month)
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
            calculator: calculator,
            selectionHandler: singleCalendarSelectionHandler,
            highlightedDates: highlightedDates,
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
            selectionHandler: rangeCalendarSelectionHandler,
            calculator: calculator,
            dayAccessoryView: dayAccessoryView
        )

    }
    
    private var adjustedValidRange: ClosedRange<Date> {
        guard let highlightedDates, !highlightedDates.isEmpty else {
            return validRange
        }
        var minDate = Date()
        for date in highlightedDates {
            minDate = min(minDate, date)
        }
        return minDate...validRange.upperBound
    }
}
