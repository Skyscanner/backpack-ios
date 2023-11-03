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

public struct BPKRangeCalendar: View {
    @Binding private var selection: ClosedRange<Date>?
    private let validRange: ClosedRange<Date>
    private var accessoryAction: (String, (Date) -> Void)?
    private let calendar: Calendar
    
    @State private var currentlyShownMonth: Date
    
    public init(
        selection: Binding<ClosedRange<Date>?>,
        validRange: ClosedRange<Date>
    ) {
        _currentlyShownMonth = State(initialValue: validRange.lowerBound)
        _selection = selection
        self.validRange = validRange
        calendar = Calendar(identifier: .gregorian)
    }
    
    public var body: some View {
        BPKCalendar(
            calendar: calendar,
            validRange: validRange,
            accessoryAction: accessoryAction,
            dayCell: { day in
                RangeSelectionCalendarDayCell(
                    date: day,
                    selection: $selection,
                    validRange: validRange,
                    calendar: calendar
                )
            },
            emptyDayCell: { correspondingDate, cellIndex, firstDayOfMonth in
                EmptyRangeSelectionCalendarDayCell(
                    cellIndex: cellIndex,
                    correspondingDate: correspondingDate,
                    selection: selection,
                    firstDayOfMonth: firstDayOfMonth
                )
            }
        )
    }
    
    public func monthAccessoryAction(title: String, action: @escaping (Date) -> Void) -> BPKRangeCalendar {
        var result = self
        result.accessoryAction = (title, action)
        return result
    }
}

struct BPKCalendar<DayCell: View, EmptyDayCell: View>: View {
    let formatter: DateFormatter
    let calendar: Calendar
    
    let dayCell: (Date) -> DayCell
    let emptyDayCell: (Date, Int, Date) -> EmptyDayCell
    
    let validRange: ClosedRange<Date>
    let accessoryAction: (String, (Date) -> Void)?
    
    @State private var currentlyShownMonth: Date
    
    init(
        calendar: Calendar,
        validRange: ClosedRange<Date>,
        accessoryAction: (String, (Date) -> Void)?,
        dayCell: @escaping (Date) -> DayCell,
        emptyDayCell: @escaping (Date, Int, Date) -> EmptyDayCell
    ) {
        _currentlyShownMonth = State(initialValue: validRange.lowerBound)
        self.accessoryAction = accessoryAction
        self.dayCell = dayCell
        self.emptyDayCell = emptyDayCell
        self.validRange = validRange
        self.calendar = calendar
        
        formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
    }
    
    public var body: some View {
        // swiftlint:disable closure_body_length
        GeometryReader { calendarProxy in
            VStack(spacing: BPKSpacing.none) {
                CalendarHeader()
                ZStack {
                    CalendarGrid(
                        calendar: calendar,
                        validRange: validRange,
                        monthHeader: { monthDate in
                            MonthHeader(
                                monthDate: monthDate,
                                formatter: formatter,
                                calendar: calendar,
                                accessoryAction: accessoryAction,
                                currentlyShownMonth: $currentlyShownMonth,
                                parentProxy: calendarProxy
                            )
                        }, selectableGrid: { monthIndex in
                            CoreCalendarMonthGrid(
                                validRange: validRange,
                                monthDate: monthDate(forMonthIndex: monthIndex),
                                calendar: calendar,
                                dayCell: dayCell,
                                emptyDayCell: emptyDayCell
                            )
                        }
                    )
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
    
    private func monthDate(forMonthIndex monthIndex: Int) -> Date {
        calendar.date(
            byAdding: .init(month: monthIndex),
            to: validRange.lowerBound
        ) ?? Date()
    }
}

struct CalendarHeader: View {
    var body: some View {
        VStack(spacing: BPKSpacing.none) {
            HStack {
                ForEach(0..<7) { index in
                    let weekDay = Calendar(identifier: .gregorian).veryShortStandaloneWeekdaySymbols[index]
                    BPKText("\(weekDay)", style: .label2)
                        .foregroundColor(.textSecondaryColor)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, BPKSpacing.md.value + BPKSpacing.sm.value)
                }
            }
            Divider()
        }
    }
}

struct CalendarGrid<MonthHeader: View, SelectableMonthGrid: View>: View {
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    let monthHeader: (Date) -> MonthHeader
    let selectableGrid: (Int) -> SelectableMonthGrid
    
    var monthsToShow: Int {
        var lastDayOfEndingMonth = calendar.date(
            bySetting: .day,
            value: 1,
            of: validRange.upperBound
        ) ?? Date()
        lastDayOfEndingMonth = calendar.date(
            byAdding: .init(day: -2),
            to: lastDayOfEndingMonth
        ) ?? Date()
        return (calendar.dateComponents(
            [.month],
            from: validRange.lowerBound,
            to: lastDayOfEndingMonth
        )
            .month ?? 0) + 1
    }
    
    // swiftlint:disable all
    var body: some View {
        ScrollView {
            
            
            VStack(spacing: BPKSpacing.none) {
                
                ForEach(0..<monthsToShow, id: \.self) { month in
                    let theDate = calendar.date(
                        byAdding: .init(month: month),
                        to: validRange.lowerBound
                    )!
                    monthHeader(theDate)
                    //                        GeometryReader { proxy in
                    //                            let global = proxy.frame(of: .global)
                    //                            VStack {
                    //                                Text("\(global.debugDescription) \(global.size.height)")
                    //                            }
                    //                        }
                        .fixedSize(horizontal: false, vertical: false)
                    selectableGrid(month)
                    
                }
            }
        }
    }
}

struct CoreCalendarMonthGrid<DayCell: View, EmptyDayCell: View>: View {
    let validRange: ClosedRange<Date>
    let monthDate: Date
    let calendar: Calendar
    let dayCell: (Date) -> DayCell
    let emptyDayCell: (Date, Int, Date) -> EmptyDayCell
    
    var body: some View {
        let firstDayOfMonth = calendar.date(
            from: calendar.dateComponents([.year, .month], from: monthDate)
        ) ?? Date()
        let firstWeekdayOfMonth = calendar.component(.weekday, from: firstDayOfMonth)
        LazyVGrid(
            columns: Array(repeating: 0, count: 7).map({ _ in .init(spacing: BPKSpacing.none.value) }),
            spacing: BPKSpacing.lg.value
        ) {
            // Always attempt to show 6 weeks and 7 days per week
            ForEach(0..<42) { cellIndex in
                let theDate = calendar.date(
                    byAdding: .init(day: cellIndex - firstWeekdayOfMonth),
                    to: firstDayOfMonth
                ) ?? Date()
                // Only show days in the current month
                if calendar.component(.month, from: firstDayOfMonth) == calendar.component(.month, from: theDate) {
                    dayCell(theDate)
                } else {
                    emptyDayCell(theDate, cellIndex, firstDayOfMonth)
                }
            }
        }
    }
}

struct EmptyRangeSelectionCalendarDayCell: View {
    let cellIndex: Int
    let correspondingDate: Date
    let selection: ClosedRange<Date>?
    let firstDayOfMonth: Date
    
    var body: some View {
        if let selection, selection.contains(correspondingDate), selection.contains(firstDayOfMonth) {
            if cellIndex < 8 {
                Color(.surfaceSubtleColor)
            } else if cellIndex < 35 {
                Color(.surfaceSubtleColor)
            }
        } else if cellIndex < 8 {
            Color.clear
        }
    }
}

struct RangeSelectionCalendarDayCell: View {
    let date: Date
    @Binding var selection: ClosedRange<Date>?
    let validRange: ClosedRange<Date>
    let calendar: Calendar
    
    var body: some View {
        if !validRange.contains(date) {
            BPKText("\(calendar.component(.day, from: date))", style: .label1)
                .foregroundColor(.textDisabledColor)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .padding(.md)
        } else if let selection, selection.contains(date) {
            ZStack {
                if date == selection.lowerBound {
                    GeometryReader { geometry in
                        Color(.surfaceSubtleColor)
                            .frame(width: geometry.size.width / 2)
                            .offset(x: geometry.size.width / 2)
                    }
                    BPKText("\(calendar.component(.day, from: date))", style: .label1)
                        .foregroundColor(.textPrimaryInverseColor)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, .md)
                        .background(.coreAccentColor)
                        .clipShape(Circle())
                } else if date == selection.upperBound {
                    GeometryReader { geometry in
                        Color(.surfaceSubtleColor)
                            .frame(width: geometry.size.width / 2)
                    }
                    BPKText("\(calendar.component(.day, from: date))", style: .label1)
                        .foregroundColor(.textPrimaryInverseColor)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, .md)
                        .background(.coreAccentColor)
                        .clipShape(Circle())
                } else {
                    BPKText("\(calendar.component(.day, from: date))", style: .label1)
                        .lineLimit(1)
                        .padding(.vertical, .md)
                        .frame(maxWidth: .infinity)
                        .background(.surfaceSubtleColor)
                }
            }
        } else if calendar.isDateInToday(date) {
            BPKText("\(calendar.component(.day, from: date))", style: .label1)
                .lineLimit(1)
                .padding(.vertical, .sm)
            
                .background(Color.green)
        } else {
            BPKText("\(calendar.component(.day, from: date))", style: .label1)
                .lineLimit(1)
                .padding(.vertical, .sm)
        }
    }
}

struct MonthHeader: View {
    let monthDate: Date
    let formatter: DateFormatter
    let calendar: Calendar
    let accessoryAction: (String, (Date) -> Void)?
    @Binding var currentlyShownMonth: Date
    
    let parentProxy: GeometryProxy
    
    var body: some View {
        HStack {
            let form = formatter.string(from: monthDate)
            BPKText(form, style: .heading4)
            Spacer()
            GeometryReader { monthProxy in
                if isCurrentlyShowingMonth(proxy: monthProxy) {
                    Color.clear
                        .onAppear { currentlyShownMonth = monthDate }
                }
            }
            if let accessoryAction {
                BPKButton(accessoryAction.0) {
                    accessoryAction.1(monthDate)
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

struct CalendarBadge: View {
    let currentlyShownMonth: Date
    let calendar: Calendar
    
    var body: some View {
        let shownYear = calendar.component(.year, from: currentlyShownMonth)
        if shownYear != calendar.component(.year, from: Date()) {
            BPKBadge("\(shownYear)")
                .badgeStyle(.brand)
        }
    }
}

struct BPKCalendar_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar(identifier: .gregorian)
        let minValidDate = calendar.date(from: .init(year: 2023, month: 10, day: 12))!
        let maxValidDate = calendar.date(from: .init(year: 2025, month: 12, day: 2))!
        
        let minSelectedDate = calendar.date(from: .init(year: 2023, month: 10, day: 19))!
        let maxSelectedDate = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
        
        BPKRangeCalendar(
            selection: .constant(minSelectedDate...maxSelectedDate),
            validRange: minValidDate...maxValidDate
        ).monthAccessoryAction(title: "hehhe", action: { _ in })
    }
}
