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

public enum RangeAccessibilityLabelsConfigurations {
    case dynamic(accessibilityLabelCallback: ((Date) -> (label: String, hint: String)))
    case predefined(start: AccessibilityLabels, end: AccessibilityLabels)
    
    func startSelectionLabel(date: Date) -> String? {
        switch self {
        case .dynamic(let callback):
            return callback(date).label
        case .predefined(let labels, _):
            return labels.selectionState
        }
    }
    
    func startSelectionHint(date: Date) -> String? {
        switch self {
        case .dynamic(let callback):
            return callback(date).hint
        case .predefined(let labels, _):
            return labels.selectionHint
        }
    }
    
    func endSelectionLabel(date: Date) -> String? {
        switch self {
        case .dynamic(let callback):
            return callback(date).label
        case .predefined(_, let labels):
            return labels.selectionState
        }
    }
    
    func endSelectionHint(date: Date) -> String? {
        switch self {
        case .dynamic(let callback):
            return callback(date).hint
        case .predefined(_, let labels):
            return labels.selectionHint
        }
    }
}
