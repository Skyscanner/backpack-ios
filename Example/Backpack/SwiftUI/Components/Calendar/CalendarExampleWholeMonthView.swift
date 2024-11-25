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
    @State var selection: CalendarSelectionState

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
        _selection = State(
            initialValue: .range(
                .range(selectionStart...selectionEnd)
            )
        )
    }
    
    var body: some View {
        VStack {
            calendarView
        }
    }
    
    @ViewBuilder
    var calendarView: some View {
        BPKCalendar(
            selectionType: makeSelectionType(),
            calendar: calendar,
            validRange: validRange
        )
        .monthAccessoryAction { _ in
            return CalendarMonthAccessoryAction(
                title: "Select whole month",
                action: .wholeMonthSelection({ monthRange, returnMode in
                    selection = .wholeMonth(
                        .init(
                            range: monthRange,
                            returnMode: returnMode,
                            selectionAction: { date in
                                if returnMode == .range {
                                    selection = .range(.intermediate(date))
                                }
                            }
                        )
                    )
                })
            )
        }
    }

    func makeSelectionType() -> CalendarSelectionType {
        switch selection {
        case .range(let state):
            let accessibilityConfig = RangeAccessibilityConfigurations(
                startSelectionHint: "Double tap to select departure date",
                endSelectionHint: "Double tap to select return date",
                startSelectionState: "Selected as departure date",
                endSelectionState: "Selected as return date",
                betweenSelectionState: "Between departure and return date",
                startAndEndSelectionState: "Selected as both departure and return date",
                returnDatePrompt: "Now please select a return date"
            )
            return .range(
                selection: Binding(
                    get: { Optional(state) },
                    set: { newValue in
                        if let newValue = newValue {
                            selection = .range(newValue)
                        }
                    }
                ),
                accessibilityConfigurations: accessibilityConfig
            )
        case .wholeMonth(let state):
            let accessibilityConfig = WholeMonthAccessibilityConfigurations(
                startSelectionHint: "Double tap to select departure date",
                endSelectionHint: "Double tap to select return date",
                startSelectionState: "Selected as departure date",
                endSelectionState: "Selected as return date",
                betweenSelectionState: "Between departure and return date",
                startAndEndSelectionState: "Selected as both departure and return date",
                returnDatePrompt: "Now please select a return date"
            )
            return .wholeMonth(
                selection: Binding(
                    get: { state },
                    set: { newValue in
                        selection = .wholeMonth(newValue)
                    }
                ),
                accessibilityConfigurations: accessibilityConfig
            )
        }
    }
}

struct CalendarExampleMonthSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarExampleWholeMonthView()
    }
}

enum CalendarSelectionState {
    case range(CalendarRangeSelectionState)
    case wholeMonth(CalendarWholeMonthSelectionState)
}
