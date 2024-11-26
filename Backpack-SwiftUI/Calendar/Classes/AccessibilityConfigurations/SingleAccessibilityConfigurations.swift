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

/// Create a single-selection configuration with given accessibility strings.
/// - Parameters:
///   - selectionHint: The hint provided to assistive technologies informing a user how to select a date.
///   - wholeMonth: The optional whole month selection configuration for assistive technologies.
public struct SingleAccessibilityConfigurations {
    let selectionHint: String
    let wholeMonth: WholeMonthAccessibilityConfigurations?

    public init(
        selectionHint: String,
        wholeMonth: WholeMonthAccessibilityConfigurations? = nil
    ) {
        self.selectionHint = selectionHint
        self.wholeMonth = wholeMonth
    }
}

/// Create a whole-month configuration with given accessibility strings for single selection.
/// - Parameters:
///   - startSelectionState: The label provided to assistive technologies informing a user that a date is selected
///     as the first date in the range.
///   - endSelectionState: The label provided to assistive technologies informing a user that a date is selected
///     as the second date in the range.
///   - betweenSelectionState: The label provided to assistive technologies informing a user that a date lies
///     between the first and second selected dates.
public struct WholeMonthAccessibilityConfigurations {
    let startSelectionState: String
    let endSelectionState: String
    let betweenSelectionState: String

    public init(
        startSelectionState: String,
        endSelectionState: String,
        betweenSelectionState: String
    ) {
        self.startSelectionState = startSelectionState
        self.endSelectionState = endSelectionState
        self.betweenSelectionState = betweenSelectionState
    }
}
