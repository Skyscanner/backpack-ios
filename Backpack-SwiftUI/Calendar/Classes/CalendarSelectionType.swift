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

/// The `CalendarSelectionType` enum represents the different types of selection that can be made in a calendar.
public enum CalendarSelectionType {
    /// A range selection, where the user can select a range of dates.
    case range(
        selection: Binding<CalendarRangeSelectionState?>,
        accessibilityConfigurations: RangeAccessibilityConfigurations
    )
    
    /// A single selection, where the user can select a single date.
    case single(
        selected: Binding<Date?>,
        accessibilityConfigurations: SingleAccessibilityConfigurations
    )

    /// A month selection, where the user can select the whole month.
    case month(
        selection: Binding<CalendarMonthSelectionState?>,
        accessibilityConfigurations: MonthAccessibilityConfigurations
    )
}
