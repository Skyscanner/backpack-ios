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

struct CalendarTypeContainerFactory<MonthHeader: View>: View {
    let selectionType: CalendarSelectionType
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    let dayInfoProvider: CalendarDayInfoProvider?
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    
    private var accessibilityDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = calendar.locale
        formatter.dateStyle = .full
        return formatter
    }
    
    var body: some View {
        switch selectionType {
        case .range(let selection, let accessibilityConfigurations):
            RangeCalendarContainer(
                selectionState: selection,
                calendar: calendar,
                validRange: validRange,
                accessibilityProvider: RangeDayAccessibilityProvider(
                    accessibilityConfigurations: accessibilityConfigurations,
                    dateFormatter: accessibilityDateFormatter
                ),
                monthHeader: monthHeader, 
                dayInfoProvider: dayInfoProvider
            )
        case .single(let selected, let accessibilityConfigurations):
            SingleCalendarContainer(
                selection: selected,
                calendar: calendar,
                validRange: validRange,
                accessibilityProvider: SingleDayAccessibilityProvider(
                    accessibilityConfigurations: accessibilityConfigurations,
                    dateFormatter: accessibilityDateFormatter
                ),
                monthHeader: monthHeader, 
                dayInfoProvider: dayInfoProvider
            )
        
        case .month(let selected, let accessibilityConfigurations):
            EmptyView() // TODO: make the whole-month view
        }
    }
}
