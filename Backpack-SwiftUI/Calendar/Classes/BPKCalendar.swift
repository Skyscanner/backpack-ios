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

public struct BPKCalendar: View {
    let calendar: Calendar
    let selectionType: CalendarSelectionType
    let validRange: ClosedRange<Date>
    private var accessoryAction: (String, (Date) -> Void)?
    
    @State private var currentlyShownMonth: Date
    
    public init(
        selectionType: CalendarSelectionType,
        calendar: Calendar,
        validRange: ClosedRange<Date>
    ) {
        _currentlyShownMonth = State(initialValue: validRange.lowerBound)
        self.validRange = validRange
        self.calendar = calendar
        self.selectionType = selectionType
    }
    
    public var body: some View {
        // swiftlint:disable closure_body_length
        GeometryReader { calendarProxy in
            VStack(spacing: BPKSpacing.none) {
                CalendarHeader(calendar: calendar)
                ZStack {
                    switch selectionType {
                    case .range(let selectedRange):
                        RangeCalendarContainer(
                            selection: selectedRange,
                            calendar: calendar,
                            validRange: validRange,
                            monthHeader: { monthDate in
                                CalendarMonthHeader(
                                    monthDate: monthDate,
                                    calendar: calendar,
                                    accessoryAction: accessoryAction,
                                    currentlyShownMonth: $currentlyShownMonth,
                                    parentProxy: calendarProxy
                                )
                            }
                        )
                    }
                    VStack {
                        CalendarBadge(
                            currentlyShownMonth: currentlyShownMonth,
                            calendar: calendar
                        )
                        .padding(.top, .base)
                        Spacer()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func emptyDayCell(
        forCorrespondingDate correspondingDate: Date,
        cellIndex: Int,
        firstDayOfMonth: Date
    ) -> some View {
        switch selectionType {
        case .range(let selectedRange):
            EmptyRangeSelectionCalendarDayCell(
                cellIndex: cellIndex,
                correspondingDate: correspondingDate,
                selection: selectedRange.wrappedValue,
                firstDayOfMonth: firstDayOfMonth
            )
        }
    }
    
    @ViewBuilder
    private func dayCell(forDay day: Date, onSelection: @escaping () -> Void) -> some View {
        switch selectionType {
        case .range(let selectedRange):
            RangeSelectionCalendarDayCell(
                date: day,
                selection: selectedRange,
                calendar: calendar
            )
        }
    }
    
    public func monthAccessoryAction(title: String, action: @escaping (Date) -> Void) -> BPKCalendar {
        var result = self
        result.accessoryAction = (title, action)
        return result
    }
}

struct BPKCalendar_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let minValidDate = calendar.date(from: .init(year: 2023, month: 10, day: 12))!
        let maxValidDate = calendar.date(from: .init(year: 2025, month: 12, day: 2))!
        
        let minSelectedDate = calendar.date(from: .init(year: 2023, month: 11, day: 19))!
        let maxSelectedDate = calendar.date(from: .init(year: 2023, month: 11, day: 30))!
        
        return BPKCalendar(
            selectionType: .range(
                selectedRange: .constant(minSelectedDate...maxSelectedDate)
            ),
            calendar: calendar,
            validRange: minValidDate...maxValidDate
        )
        .monthAccessoryAction(title: "Select whole month") { _ in }
    }
}
