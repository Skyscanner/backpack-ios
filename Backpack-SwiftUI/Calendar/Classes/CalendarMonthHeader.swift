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

/// CalendarMonthHeader is a view that displays the month name and an optional accessory action.
/// Also exposes a binding to the currently shown month.
struct CalendarMonthHeader: View {
    let monthDate: Date
    let dateFormatter: DateFormatter
    let dateToCalendarMonth: (Date) -> CalendarMonth
    let calendar: Calendar
    let accessoryAction: CalendarMonthAccessoryAction?
    @Binding var currentlyShownMonth: Date
    let parentProxy: GeometryProxy
    
    var body: some View {
        HStack {
            let form = dateFormatter.string(from: monthDate)
            BPKText(form, style: .heading4)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            GeometryReader { monthProxy in
                if isCurrentlyShowingMonth(proxy: monthProxy) {
                    Color.clear
                        .onAppear { currentlyShownMonth = monthDate }
                }
            }
            .frame(width: 1)
            if let accessoryAction {
                BPKButton(accessoryAction.title) {
                    accessoryAction.action(dateToCalendarMonth(monthDate))
                }
                .buttonStyle(.link)
            }
        }
        .padding(.horizontal, .base)
        .padding(.vertical, .lg)
    }
    
    private func isCurrentlyShowingMonth(proxy: GeometryProxy) -> Bool {
        let parentGlobalFrame = parentProxy.frame(in: .global)
        let yParentOrigin = parentGlobalFrame.origin.y
        let parentHeight = parentGlobalFrame.height
        let calendarVerticalCenter = yParentOrigin + parentHeight / 2
        let currentlyShownValidationRange = yParentOrigin...calendarVerticalCenter
        let yOrigin = proxy.frame(in: .global).origin.y
        return currentlyShownValidationRange.contains(yOrigin)
    }
}

struct CalendarMonthHeader_Previews: PreviewProvider {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter
    }()

    static let dateToCalendarMonth: (Date) -> CalendarMonth = { date in
        // Dummy conversion
        return .init(year: 2014, month: 10)
    }

    static var previews: some View {
        GeometryReader { proxy in
            CalendarMonthHeader(
                monthDate: Date(),
                dateFormatter: Self.dateFormatter, 
                dateToCalendarMonth: dateToCalendarMonth,
                calendar: Calendar.current,
                accessoryAction: .init(title: "Action", action: { _ in }),
                currentlyShownMonth: .constant(Date()),
                parentProxy: proxy
            )
            .border(.black)
            .padding(.base)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
