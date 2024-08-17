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

/// The `CalendarRangeSelectionState` enum represents the different states of a range selection.
public enum CalendarRangeSelectionState {
    /// The intermediate state, where the user has selected the first date of the range, but not the second.
    case intermediate(Date)

    /// The final state, where the user has selected both dates of the range.
    case range(ClosedRange<Date>)

    /// The state the user has selected the whole month range.
    case wholeMonth(ClosedRange<Date>)
}
