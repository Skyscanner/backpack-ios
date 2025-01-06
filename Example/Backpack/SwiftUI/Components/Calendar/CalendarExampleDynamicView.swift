//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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
import Backpack_SwiftUI

struct CalendarExampleDynamicView: View {
    @State var rangeSelection: CalendarRangeSelectionState?
    @State var singleSelection: CalendarSingleSelectionState?
    @State var selection: CalendarSelectionType?

    let validRange: ClosedRange<Date>
    let calendar: Calendar
    let formatter: DateFormatter
    @State var selectedTab = -1
    
    init() {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 11, day: 6))!
        let end = calendar.date(from: .init(year: 2024, month: 11, day: 28))!
        
        self.validRange = start...end
        self.calendar = calendar
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = calendar.locale
        formatter.timeZone = calendar.timeZone
        self.formatter = formatter
        
        _selection = State(initialValue: nil)
    }
    
    // swiftlint:disable closure_body_length
    var body: some View {
        VStack {
            BPKHorizontalNavigation(
                tabs: [
                    .init(title: "Single", onClick: {
                        selection = .single(
                            selected: $singleSelection,
                            accessibilityConfigurations: .init(selectionHint: "Select a date")
                        )
                        selectedTab = 0
                    }),
                    .init(title: "Range", onClick: {
                        selection = .range(
                            selection: $rangeSelection,
                            accessibilityConfigurations: RangeAccessibilityConfigurations(
                                startSelectionHint: "Double tap to select departure date",
                                endSelectionHint: "Double tap to select return date",
                                startSelectionState: "Selected as departure date",
                                endSelectionState: "Selected as return date",
                                betweenSelectionState: "Between departure and return date",
                                startAndEndSelectionState: "Selected as both departure and return date",
                                returnDatePrompt: "Now please select a return date"
                            )
                        )
                        selectedTab = 1
                    })
                ],
                selectedTab: selectedTab
            )
            calendarView
        }
    }
    
    @ViewBuilder
    var calendarView: some View {
        if let selection {
            BPKCalendar(
                selectionType: selection,
                calendar: calendar,
                validRange: validRange,
                initialMonthScroll: nil
            )
        } else {
            VStack {
                BPKText("Select calendar mode")
                Spacer()
            }
        }
    }
}

#Preview {
    CalendarExampleDynamicView()
}
