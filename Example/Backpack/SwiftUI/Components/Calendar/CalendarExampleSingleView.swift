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

struct CalendarExampleSingleView: View {
    @State var selectedDate: Date?
    
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
        formatter.timeZone = calendar.timeZone
        self.formatter = formatter
        
        _selectedDate = State(initialValue: calendar.date(from: .init(year: 2023, month: 11, day: 15))!)
    }
    
    var body: some View {
        VStack {
            HStack {
                BPKText("Selected date:", style: .caption)
                if let selectedDate {
                    BPKText("\(formatter.string(from: selectedDate))", style: .caption)
                }
            }
            BPKCalendar(
                selectionType: .single(
                    selected: $selectedDate,
                    accessibilityConfigurations: SingleAccessibilityConfigurations(
                        selectionHint: "Double tap to select date"
                    )
                ),
                calendar: calendar,
                validRange: validRange
            )
        }
    }
}

struct CalendarExampleSingleView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarExampleSingleView()
    }
}
