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

struct CalendarExampleRangeView: View {
    @State var selectedRange: ClosedRange<Date>?
    
    let validRange: ClosedRange<Date>
    let calendar: Calendar
    let formatter: DateFormatter
    
    init() {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 11, day: 6))!
        let end = calendar.date(from: .init(year: 2024, month: 11, day: 28))!
        
        self.validRange = start...end
        self.calendar = calendar
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = calendar.locale
        self.formatter = formatter
        
        let selectionStart = calendar.date(from: .init(year: 2023, month: 11, day: 23))!
        let selectionEnd = calendar.date(from: .init(year: 2023, month: 12, day: 2))!
        _selectedRange = State(initialValue: selectionStart...selectionEnd)
    }
    
    var body: some View {
        let accessibilityConfigurations = RangeAccessibilityConfigurations(
            startSelectionHint: "Double tap to select departure date",
            endSelectionHint: "Double tap to select return date",
            startSelectionState: "Selected as departure date",
            endSelectionState: "Selected as return date",
            betweenSelectionState: "Between departure and return date",
            startAndEndSelectionState: "Selected as both departure and return date",
            returnDatePrompt: "Now please select a return date"
        )
        return VStack {
            HStack {
                BPKText("Selected inbound:", style: .caption)
                if let selectedRange {
                    BPKText("\(formatter.string(from: selectedRange.lowerBound))", style: .caption)
                }
            }
            HStack {
                BPKText("Selected outbound:", style: .caption)
                if let selectedRange {
                    BPKText("\(formatter.string(from: selectedRange.upperBound))", style: .caption)
                }
            }
            BPKCalendar(
                selectionType: .range(
                    selectedRange: $selectedRange,
                    accessibilityConfigurations: accessibilityConfigurations
                ),
                calendar: calendar,
                validRange: validRange
            )
        }
    }
}

struct CalendarExampleRangeView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarExampleRangeView()
    }
}
