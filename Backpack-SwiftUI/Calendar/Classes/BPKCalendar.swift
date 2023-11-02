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

/// A view that displays
public struct BPKCalendar: View {
    let formatter: DateFormatter
    let calendar: Calendar
    
    @Binding var selection: ClosedRange<Date>
    let validRange: ClosedRange<Date>
    
    public init(selection: Binding<ClosedRange<Date>>, validRange: ClosedRange<Date>) {
        _selection = selection
        self.validRange = validRange
        
        formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        calendar = Calendar(identifier: .gregorian)
    }
    
    public var body: some View {
        // swiftlint:disable closure_body_length
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
                            accessoryAction: ("Select whole month", {})
                        )
                    }, selectableGrid: { monthIndex in
                        CoreCalendarMonthGrid(
                            selection: $selection,
                            validRange: validRange,
                            monthDate: monthDate(forMonthIndex: monthIndex),
                            calendar: calendar,
                            dayCell: { day in
                                RangeSelectionCalendarDayCell(
                                    date: day,
                                    selection: $selection,
                                    validRange: validRange,
                                    calendar: calendar
                                )
                            },
                            emptyDayCell: { correspondingDate, cellIndex in
                                EmptyRangeSelectionCalendarDayCell(
                                    cellIndex: cellIndex,
                                    correspondingDate: correspondingDate,
                                    selection: selection)
                            }
                        )
                    }
                )
                VStack {
                    CalendarBadge()
                        .padding(.top, .base)
                    Spacer()
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
                    selectableGrid(month)
                }
            }
        }
    }
}

struct CoreCalendarMonthGrid<DayCell: View, EmptyDayCell: View>: View {
    @Binding var selection: ClosedRange<Date>
    let validRange: ClosedRange<Date>
    let monthDate: Date
    let calendar: Calendar
    let dayCell: (Date) -> DayCell
    let emptyDayCell: (Date, Int) -> EmptyDayCell
    
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
                    emptyDayCell(theDate, cellIndex)
                }
            }
        }
    }
}

struct EmptyRangeSelectionCalendarDayCell: View {
    let cellIndex: Int
    let correspondingDate: Date
    let selection: ClosedRange<Date>
    
    var body: some View {
        if selection.contains(correspondingDate) {
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
    @Binding var selection: ClosedRange<Date>
    let validRange: ClosedRange<Date>
    let calendar: Calendar
    
    var body: some View {
        if !validRange.contains(date) {
                BPKText("\(calendar.component(.day, from: date))", style: .label1)
                .foregroundColor(.textDisabledColor)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                    .padding(.md)
        } else if selection.contains(date) {
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
    let accessoryAction: (String, () -> Void)?
    
    var body: some View {
        HStack {
            let form = formatter.string(from: monthDate)
            BPKText(form, style: .heading4)
            Spacer()
            if let accessoryAction {
                BPKButton(accessoryAction.0, action: accessoryAction.1)
                    .buttonStyle(.link)
            }
        }
        .padding(.horizontal, .base)
        .padding(.vertical, .lg)
    }
}

struct CalendarBadge: View {
    var body: some View {
        BPKBadge("2023")
            .badgeStyle(.brand)
    }
}

struct BPKCalendar_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar(identifier: .gregorian)
        let minValidDate = calendar.date(from: .init(year: 2023, month: 10, day: 12))!
        let maxValidDate = calendar.date(from: .init(year: 2023, month: 12, day: 2))!
        
        let minSelectedDate = calendar.date(from: .init(year: 2023, month: 10, day: 23))!
        let maxSelectedDate = calendar.date(from: .init(year: 2023, month: 11, day: 8))!
        
        BPKCalendar(
            selection: .constant(minSelectedDate...maxSelectedDate),
            validRange: minValidDate...maxValidDate
        )
    }
}
