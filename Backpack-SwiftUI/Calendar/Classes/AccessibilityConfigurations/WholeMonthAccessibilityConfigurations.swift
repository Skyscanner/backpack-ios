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
///   - startSelectionHint: The hint provided to assistive technologies informing a user how to select the first
///     date in the range.
///   - endSelectionHint: The hint provided to assistive technologies informing a user how to select the second
///     date in the range.
///   - startSelectionState: The label provided to assistive technologies informing a user that a date is selected
///     as the first date in the range.
///   - endSelectionState: The label provided to assistive technologies informing a user that a date is selected
///     as the second date in the range.
///   - betweenSelectionState: The label provided to assistive technologies informing a user that a date lies
///     between the first and second selected dates.
///   - startAndEndSelectionState: The label provided to assistive technologies informing a user that a date
///     is selected as both the first and second date in the range.
///   - returnDatePrompt: The prompt provided to assistive technologies informing a user that they should now
///     select a second date.
public struct WholeMonthAccessibilityConfigurations {
    let startSelectionHint: String
    let endSelectionHint: String
    let startSelectionState: String
    let endSelectionState: String
    let betweenSelectionState: String
    let startAndEndSelectionState: String
    let returnDatePrompt: String

    public init(
        startSelectionHint: String,
        endSelectionHint: String,
        startSelectionState: String,
        endSelectionState: String,
        betweenSelectionState: String,
        startAndEndSelectionState: String,
        returnDatePrompt: String
    ) {
        self.startSelectionHint = startSelectionHint
        self.endSelectionHint = endSelectionHint
        self.startSelectionState = startSelectionState
        self.endSelectionState = endSelectionState
        self.betweenSelectionState = betweenSelectionState
        self.startAndEndSelectionState = startAndEndSelectionState
        self.returnDatePrompt = returnDatePrompt
    }
}
