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

/// Create a multi-selection configuration with given accessibility strings.
/// - Parameters:
///   - rangeAccessibilityLabels: The eunmaration with a hint and a state selection accessibility labels
///   - betweenSelectionState: The label provided to assistive technologies informing a user that a date lies
///     between the first and second selected dates.
///   - startAndEndSelectionState: The label provided to assistive technologies informing a user that a date
///     is selected as both the first and second date in the range.
///   - returnDatePrompt: The prompt provided to assistive technologies informing a user that they should now
///     select a second date.
public struct RangeAccessibilityConfigurations {
    let rangeAccessibilityLabels: RangeAccessibilityLabelsConfigurations
    let betweenSelectionState: String
    let startAndEndSelectionState: String
    let returnDatePrompt: String

    public init(
        accessibilityLabelCallback: @escaping ((Date) -> (String, String)),
        betweenSelectionState: String,
        startAndEndSelectionState: String,
        returnDatePrompt: String
    ) {
        self.rangeAccessibilityLabels = .dynamic(accessibilityLabelCallback: accessibilityLabelCallback)
        self.betweenSelectionState = betweenSelectionState
        self.startAndEndSelectionState = startAndEndSelectionState
        self.returnDatePrompt = returnDatePrompt
    }
    
    public init(
        startSelectionHint: String,
        endSelectionHint: String,
        startSelectionState: String,
        endSelectionState: String,
        betweenSelectionState: String,
        startAndEndSelectionState: String,
        returnDatePrompt: String
    ) {
        let startAccessibilityLabel = AccessibilityLabels(
            selectionState: startSelectionState,
            selectionHint: startSelectionHint
        )
        let endAccessibilityLabel = AccessibilityLabels(
            selectionState: endSelectionState,
            selectionHint: endSelectionHint
        )
        self.rangeAccessibilityLabels = .predefined(start: startAccessibilityLabel, end: endAccessibilityLabel)
        self.betweenSelectionState = betweenSelectionState
        self.startAndEndSelectionState = startAndEndSelectionState
        self.returnDatePrompt = returnDatePrompt
    }
}
