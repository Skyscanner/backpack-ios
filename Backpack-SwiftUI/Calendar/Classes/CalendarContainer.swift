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

struct CalendarContainer<MonthHeader: View, SelectableMonthGrid: View>: View {
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    @ViewBuilder let selectableGrid: (_ monthDate: Date) -> SelectableMonthGrid
    
    var monthsToShow: Int {
        let firstMonthComponents = calendar.dateComponents([.year, .month], from: validRange.lowerBound)
        let firstMonth = calendar.date(from: firstMonthComponents)!
        let components = calendar.dateComponents([.year, .month], from: firstMonth, to: validRange.upperBound)
        return components.month! + components.year! * 12
    }
    
    private func firstDayOf(monthIndex: Int) -> Date {
        let month = calendar.date(
            byAdding: .init(month: monthIndex),
            to: validRange.lowerBound
        )!
        return calendar.date(
            from: calendar.dateComponents(
                [.year, .month],
                from: month
            )
        )!
    }
    
    // swiftlint:disable all
    var body: some View {
        ScrollView {
            VStack(spacing: BPKSpacing.none) {
                ForEach(0...monthsToShow, id: \.self) { monthIndex in
                    let firstDayOfMonth = firstDayOf(monthIndex: monthIndex)
                    monthHeader(firstDayOfMonth)
                    selectableGrid(firstDayOfMonth)
                }
            }
        }
    }
}

struct RangeCalendarContainer<MonthHeader: View>: View {
    @State private var initialDateSelection: Date?
    
    @Binding var selection: ClosedRange<Date>?
    let calendar: Calendar
    let validRange: ClosedRange<Date>
    @ViewBuilder let monthHeader: (_ monthDate: Date) -> MonthHeader
    
    var monthsToShow: Int {
        let firstMonthComponents = calendar.dateComponents([.year, .month], from: validRange.lowerBound)
        let firstMonth = calendar.date(from: firstMonthComponents)!
        let components = calendar.dateComponents([.year, .month], from: firstMonth, to: validRange.upperBound)
        return components.month! + components.year! * 12
    }
    
    private func firstDayOf(monthIndex: Int) -> Date {
        let month = calendar.date(
            byAdding: .init(month: monthIndex),
            to: validRange.lowerBound
        )!
        return calendar.date(
            from: calendar.dateComponents(
                [.year, .month],
                from: month
            )
        )!
    }
    
    private func handleSelection(_ date: Date) {
        if selection != nil {
            initialDateSelection = date
            selection = nil
        } else {
            if let initialDateSelection {
                if date < initialDateSelection {
                    self.initialDateSelection = date
                } else {
                    selection = initialDateSelection...date
                    self.initialDateSelection = nil
                }
            } else {
                initialDateSelection = date
            }
        }
    }
    
    
    @ViewBuilder
    private func makeDayCell(_ dayDate: Date) -> some View {
        let matchingDayComponents = calendar.dateComponents([.year, .month, .day], from: dayDate)
        if !validRange.contains(dayDate) {
            DisabledSelectionCell(calendar: calendar, date: dayDate)
        } else if let initialDateSelection,
            calendar.date(initialDateSelection, matchesComponents: matchingDayComponents) {
            CalendarSelectableCell {
                SingleSelectedCell(calendar: calendar, date: initialDateSelection)
            } onSelection: {
                handleSelection(dayDate)
            }
        } else {
            CalendarSelectableCell {
                RangeSelectionCalendarDayCell(
                    date: dayDate,
                    selection: $selection,
                    calendar: calendar
                )
            } onSelection: {
                handleSelection(dayDate)
            }
        }
    }
    
    // swiftlint:disable all
    var body: some View {
        ScrollView {
            VStack(spacing: BPKSpacing.none) {
                ForEach(0...monthsToShow, id: \.self) { monthIndex in
                    let firstDayOfMonth = firstDayOf(monthIndex: monthIndex)
                    monthHeader(firstDayOfMonth)
                    CalendarMonthGrid(
                        monthDate: firstDayOfMonth,
                        calendar: calendar,
                        dayCell: makeDayCell) { correspondingDate, cellIndex in
                            EmptyRangeSelectionCalendarDayCell(
                                cellIndex: cellIndex,
                                correspondingDate: correspondingDate,
                                selection: selection,
                                firstDayOfMonth: firstDayOfMonth
                            )
                        }
                }
            }
        }
    }
}

struct CalendarContainer_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar.current
        let start = calendar.date(from: .init(year: 2023, month: 10, day: 30))!
        let end = calendar.date(from: .init(year: 2025, month: 12, day: 25))!
        
        CalendarContainer(
            calendar: calendar,
            validRange: start...end) { day in
                Text("Header for month: \(day)")
                    .padding()
            } selectableGrid: { monthNumber in
                VStack {
                    Text("Calendar Grid")
                        .border(.blue)
                    Divider()
                }
            }
    }
}
