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

import Foundation

protocol CalendarGridCalculator {
    func calculateCalendarGrid(monthDate: Date) -> [[Date?]]
}

class InMemoryCacheCalendarGridCalculator: CalendarGridCalculator {
    private var cache: [Date: [[Date?]]] = [:]
    private let decoratee: CalendarGridCalculator
    
    init(decoratee: CalendarGridCalculator) {
        self.decoratee = decoratee
    }
    
    func calculateCalendarGrid(monthDate: Date) -> [[Date?]] {
        if let cached = cache[monthDate] {
            return cached
        }
        let calculated = decoratee.calculateCalendarGrid(monthDate: monthDate)
        cache[monthDate] = calculated
        return calculated
    }
}

struct DefaultCalendarGridCalculator: CalendarGridCalculator {
    let calendar: Calendar

    /// Calculated will look like this:
    ///     [
    ///         [nil, nil, nil, nil, 1, 2, 3],
    ///         [4, 5, 6, 7, 8, 9, 10],
    ///         ...,
    ///         [27, 28, 29, 30, 31, nil, nil]
    ///     ]
    /// Where initial nils are days from previous month, then 1...`numberOfDaysInMonth``,
    /// then nils to fill the last week
    func calculateCalendarGrid(monthDate: Date) -> [[Date?]] {
        let daysInAWeek: Int = 7
        let firstWeekday = calendar.firstWeekday // Locale-aware first day of the week
        let weekdayOfMonthStart = calendar.component(.weekday, from: monthDate)
        // Calculate the offset based on the first weekday
        let daysFromPreviousMonth = (weekdayOfMonthStart - firstWeekday + daysInAWeek) % daysInAWeek
        let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: monthDate)!.count
        let totalCellsUsed = numberOfDaysInMonth + daysFromPreviousMonth
        
        var calculated: [[Date?]] = Array(
            repeating: Array(repeating: nil, count: daysInAWeek),
            count: (totalCellsUsed + daysInAWeek - 1) / daysInAWeek
        )

        // Iterate through each day of the month
        for day in 0..<numberOfDaysInMonth {
            // Calculate the position in the grid
            let row = (day + daysFromPreviousMonth) / daysInAWeek
            let column = (day + daysFromPreviousMonth) % daysInAWeek
            
            // Calculate the date for the current day
            let date = calendar.date(byAdding: .day, value: day, to: monthDate)
            
            // Assign the date to the calculated grid
            calculated[row][column] = date
        }
        return calculated
    }
}
