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

struct CalendarExampleView: View {
    @State var selectedRange: ClosedRange<Date>? = Self.initialSelection
    @State var selectedDate: Date? = Self.initialSelection.lowerBound
    
    let validRange = Self.validRange
    let calendar = Calendar.current
    
    private static var initialSelection: ClosedRange<Date> {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 11, day: 13))!
        let end = calendar.date(from: .init(year: 2023, month: 11, day: 28))!
        return start...end
    }
    
    private static var validRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 10, day: 6))!
        let end = calendar.date(from: .init(year: 2024, month: 10, day: 28))!
        return start...end
    }
    
    var body: some View {
        TabView {
            VStack {
                if let selectedRange {
                    Text("Selected range: \(selectedRange.lowerBound) - \(selectedRange.upperBound)")
                } else {
                    Text("No selection")
                }
                rangeCalendar
            }
            .tabItem {
                BPKText("Range")
            }
            
            VStack {
                singleCalendar
            }
            .tabItem {
                BPKText("Single")
            }
        }
    }
    
    var rangeCalendar: Backpack_SwiftUI.BPKCalendar {
        BPKCalendar(
            selectionType: .range(selectedRange: $selectedRange),
            calendar: calendar,
            validRange: validRange
        )
        .monthAccessoryAction(title: "Select whole month") { monthDate in
            let start = calendar.date(from: calendar.dateComponents([.year, .month], from: monthDate))!
            let nextMonth = calendar.date(byAdding: .init(month: 1), to: start)!
            let end = calendar.date(byAdding: .init(day: -1), to: nextMonth)!
            selectedRange = start...end
        }
    }
    
    var singleCalendar: Backpack_SwiftUI.BPKCalendar {
        BPKCalendar(
            selectionType: .single(selected: $selectedDate),
            calendar: calendar,
            validRange: validRange
        )
        .monthAccessoryAction(title: "Select whole month") { monthDate in
            let start = calendar.date(from: calendar.dateComponents([.year, .month], from: monthDate))!
            let nextMonth = calendar.date(byAdding: .init(month: 1), to: start)!
            let end = calendar.date(byAdding: .init(day: -1), to: nextMonth)!
            selectedRange = start...end
        }
    }
}

struct CalendarExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarExampleView()
    }
}
