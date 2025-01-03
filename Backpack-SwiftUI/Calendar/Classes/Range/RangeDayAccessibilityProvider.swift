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

struct RangeDayAccessibilityProvider {
    let accessibilityConfigurations: RangeAccessibilityConfigurations
    let dateFormatter: DateFormatter
    
    func accessibilityLabel(for dayDate: Date) -> String {
        dateFormatter.string(from: dayDate)
    }
    
    func accessibilityLabel(for dayDate: Date, selection: ClosedRange<Date>) -> String {
        let baseLabel = accessibilityLabel(for: dayDate)
        var state: String?
        if selection.contains(dayDate) {
            if selection.lowerBound == selection.upperBound {
                state = accessibilityConfigurations.startAndEndSelectionState
            } else if dayDate == selection.lowerBound {
                state = accessibilityConfigurations.startSelectionState
            } else if dayDate == selection.upperBound {
                state = accessibilityConfigurations.endSelectionState
            } else {
                state = accessibilityConfigurations.betweenSelectionState
            }
        }
        guard let state else { return baseLabel }
        return "\(baseLabel), \(state)"
    }
    
    func accessibilityLabel(for dayDate: Date, intermediateSelectionDate: Date) -> String {
        let baseLabel = accessibilityLabel(for: dayDate)
        let state = accessibilityConfigurations.startSelectionState
        return "\(baseLabel), \(state)"
    }
    
    func accessibilityHint(for dayDate: Date, rangeSelectionState: CalendarRangeSelectionState?) -> String {
        if shouldClearSelectedDates(for: dayDate, rangeSelectionState: rangeSelectionState) {
            return accessibilityConfigurations.startSelectionHint
        }
        return accessibilityConfigurations.endSelectionHint
    }

    private func shouldClearSelectedDates(
        for date: Date,
        rangeSelectionState: CalendarRangeSelectionState?
    ) -> Bool {
        switch rangeSelectionState {
        case .intermediate(let initialDateSelection):
            return date < initialDateSelection
        case .range, .wholeMonth:
            return true
        case nil:
            return false
        }
    }
}
