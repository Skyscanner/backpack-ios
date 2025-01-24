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

// swiftlint:disable closure_body_length
struct CalendarExampleSingleView: View {
    @State var selection: CalendarSingleSelectionState?
    private var monthScroll: MonthScroll?

    let validRange: ClosedRange<Date>
    let calendar: Calendar
    let formatter: DateFormatter

    init(makeInitialMonthScrollWithAnimation: Bool = false) {
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

        var date = calendar.date(from: .init(year: 2023, month: 11, day: 15))!

        if makeInitialMonthScrollWithAnimation {
            date = calendar.date(from: .init(year: 2024, month: 04, day: 15))!
            self.monthScroll = .init(monthToScroll: date, animated: true)
        }

        _selection = State(initialValue: .single(date))
    }
    
    var body: some View {
        VStack {
            HStack {
                BPKText("Selected date:", style: .caption)
                if case .single(let date) = selection {
                    BPKText("\(formatter.string(from: date))", style: .caption)
                } else if case .wholeMonth(let month, _) = selection {
                    BPKText("\(formatter.string(from: month.lowerBound))", style: .caption)
                }
            }
            BPKCalendar(
                selectionType: .single(
                    selected: $selection,
                    accessibilityConfigurations: SingleAccessibilityConfigurations(
                        selectionHint: "Double tap to select date"
                    )
                ),
                calendar: calendar,
                validRange: validRange,
                initialMonthScroll: monthScroll,
                onSelectHandler: { _, date in // unused state
                    // without providing the selection handler by consumer,
                    // single selection does not work
                    selection = .single(date)
                }
            )
            .monthAccessoryAction { _ in
                return CalendarMonthAccessoryAction(
                    title: "Select whole month",
                    action: .wholeMonthSelection({ monthRange in
                        selection = .wholeMonth(monthRange, accessibilityConfig: wholeMonthAccessibilityConfig())
                    })
                )
            }
        }
    }

    private func wholeMonthAccessibilityConfig() -> WholeMonthAccessibilityConfigurations {
        return .init(
            startSelectionState: "Selected as departure date",
            endSelectionState: "Selected as return date",
            betweenSelectionState: "Between departure and return date"
        )
    }
}

struct CalendarExampleSingleView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarExampleSingleView()
    }
}
