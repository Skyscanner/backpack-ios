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
public struct SingleAccessibilityConfigurations {
    let selectionHint: String
    let wholeMonth: WholeMonthAccessibilityConfigurations?

    public init(selectionHint: String, wholeMonth: WholeMonthAccessibilityConfigurations?) {
        self.selectionHint = selectionHint
        self.wholeMonth = wholeMonth
    }
}

public struct WholeMonthAccessibilityConfigurations {
    let startSelectionHint: String
    let endSelectionHint: String
    let startSelectionState: String
    let endSelectionState: String
    let startAndEndSelectionState: String
    let returnDatePrompt: String

    public init(
        startSelectionHint: String,
        endSelectionHint: String,
        startSelectionState: String,
        endSelectionState: String,
        startAndEndSelectionState: String,
        returnDatePrompt: String
    ) {
        self.startSelectionHint = startSelectionHint
        self.endSelectionHint = endSelectionHint
        self.startSelectionState = startSelectionState
        self.endSelectionState = endSelectionState
        self.startAndEndSelectionState = startAndEndSelectionState
        self.returnDatePrompt = returnDatePrompt
    }
}
