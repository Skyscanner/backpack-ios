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

struct CalendarExampleWholeMonthView: View {
    @State var selection: CalendarRangeSelectionState?
    
    let validRange: ClosedRange<Date>
    let calendar: Calendar
    let formatter: DateFormatter

    init() {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 11, day: 5))!
        let end = calendar.date(from: .init(year: 2024, month: 11, day: 28))!
        
        self.validRange = start...end
        self.calendar = calendar
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = calendar.locale
        formatter.timeZone = calendar.timeZone
        self.formatter = formatter
        let selectionStart = calendar.date(from: .init(year: 2023, month: 11, day: 10))!
        let selectionEnd = calendar.date(from: .init(year: 2023, month: 11, day: 30))!
        _selection = State(initialValue: .range(selectionStart...selectionEnd))
    }
    
    var body: some View {
        VStack {
            HStack {
                BPKText("Selected inbound:", style: .caption)
                if case .wholeMonth(let selectedRange) = selection {
                    BPKText("\(formatter.string(from: selectedRange.lowerBound))", style: .caption)
                } else if case .intermediate(let selectedDate) = selection {
                    BPKText("\(formatter.string(from: selectedDate))", style: .caption)
                }
            }
            HStack {
                BPKText("Selected outbound:", style: .caption)
                if case .wholeMonth(let selectedRange) = selection {
                    BPKText("\(formatter.string(from: selectedRange.upperBound))", style: .caption)
                }
            }
            calendarView
        }
    }
    
    @ViewBuilder
    var calendarView: some View {
        let accessibilityConfigurations = RangeAccessibilityConfigurations(
            startSelectionHint: "Double tap to select departure date",
            endSelectionHint: "Double tap to select return date",
            startSelectionState: "Selected as departure date",
            endSelectionState: "Selected as return date",
            betweenSelectionState: "Between departure and return date",
            startAndEndSelectionState: "Selected as both departure and return date",
            returnDatePrompt: "Now please select a return date"
        )
        BPKCalendar(
            selectionType: .range(
                selection: $selection,
                accessibilityConfigurations: accessibilityConfigurations
            ),
            calendar: calendar,
            validRange: validRange
        )
        .monthAccessoryAction(
            CalendarMonthAccessoryAction(
                title: "Select whole month",
                action: { monthRange in
                    selection = .wholeMonth(monthRange)
                }
            )
        )
    }
}

struct CalendarExampleMonthSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarExampleWholeMonthView()
    }
}
