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

struct SingleDayAccessibilityProvider {
    let accessibilityConfigurations: SingleAccessibilityConfigurations
    let dateFormatter: DateFormatter
    
    func accessibilityLabel(for dayDate: Date, selection: CalendarSingleSelectionState?) -> String {
        let baseLabel = if let label = accessibilityConfigurations.selectionLabel(date: dayDate) {
            "\(dateFormatter.string(from: dayDate)) \(label)"
        } else {
            dateFormatter.string(from: dayDate)
        }

        if case .wholeMonth(let range, let accessibilityConfig) = selection {
            var state: String?
            if range.contains(dayDate) {
                if dayDate == range.lowerBound {
                    state = accessibilityConfig.startSelectionState
                } else if dayDate == range.upperBound {
                    state = accessibilityConfig.endSelectionState
                } else {
                    state = accessibilityConfig.betweenSelectionState
                }
            }
            guard let state else { return baseLabel }
            return "\(baseLabel), \(state)"
        } else {
            return baseLabel
        }
    }

    func accessibilityHint(for dayDate: Date, selection: CalendarSingleSelectionState?) -> String {
        guard
            let hint = accessibilityConfigurations.selectionHint(date: dayDate),
            selection?.isSelected(dayDate) != true
        else {
            return ""
        }
        return hint
    }
}

extension CalendarSingleSelectionState {
    func isSelected(_ date: Date) -> Bool {
        switch self {
        case .single(let selectedDate):
            return selectedDate == date
        case .wholeMonth(let range, _):
            return range.contains(date)
        }
    }
}
