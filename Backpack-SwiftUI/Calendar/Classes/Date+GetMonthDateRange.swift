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

extension Date {
    public func getMonthDateRange(calendar: Calendar) -> ClosedRange<Date>? {
        let components = calendar.dateComponents([.year, .month], from: self)
        
        guard let year = components.year, let month = components.month else {
            return nil
        }

        // Create DateComponents for the start of the month
        var startComponents = DateComponents()
        startComponents.year = year
        startComponents.month = month
        startComponents.day = 1

        // Get the start date of the month
        guard let startDate = calendar.date(from: startComponents) else {
            return nil
        }

        // Get the range of days in the month
        guard let range = calendar.range(of: .day, in: .month, for: startDate) else {
            return nil
        }

        // Create the end date of the month
        let endDay = range.upperBound - 1
        let endComponents = DateComponents(year: year, month: month, day: endDay)

        guard let endDate = calendar.date(from: endComponents) else {
            return nil
        }

        // Return the range of dates
        return startDate...endDate
    }
}
