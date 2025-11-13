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

/// Create a single-selection configuration with given accessibility strings.
/// - Parameters:
///   - selectionHint: The hint provided to assistive technologies informing a user how to select a date.
public enum SingleAccessibilityConfigurations {
    case dynamic(accessibilityLabelCallback: ((Date) -> (label: String, hint: String)))
    case predefined(labels: AccessibilityLabels)

    func selectionLabel(date: Date) -> String? {
        switch self {
        case .dynamic(let callback):
            return callback(date).label
        case .predefined(let labels):
            return labels.selectionState
        }
    }
    
    func selectionHint(date: Date) -> String? {
        switch self {
        case .dynamic(let callback):
            return callback(date).hint
        case .predefined(let labels):
            return labels.selectionHint
        }
    }
}
