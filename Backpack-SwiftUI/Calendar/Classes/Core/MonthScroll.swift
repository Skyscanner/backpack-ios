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

struct MonthScroll {
    var scrollId: String?
    let formatter: DateFormatter

    init(scrollId: String? = nil) {
        self.scrollId = scrollId

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        self.formatter = dateFormatter
    }

    init(monthToScroll: Date) {
        self.init()
        self.scrollId = formatter.string(from: monthToScroll)
    }

    func generateIdFor(date: Date) -> String {
        formatter.string(from: date)
    }
}

// MARK: - Start Date for scrolling

extension CalendarSelectionType {
    var startDateIfAny: Date? {
        switch self {
        case .range(let selection, _):
            if let rangeState = selection.wrappedValue {
                return rangeState.startDateIfAny
            }
            return nil
        case .single(let selection, _):
            return selection.wrappedValue
        }
    }
}

extension CalendarRangeSelectionState {
    var startDateIfAny: Date? {
        switch self {
        case .intermediate(let startDate):
            return startDate
        case .range(let selectedDateRange):
            return selectedDateRange.lowerBound
        }
    }
}
