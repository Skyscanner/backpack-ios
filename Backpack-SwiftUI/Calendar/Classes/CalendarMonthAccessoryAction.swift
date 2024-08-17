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

/// `CalendarMonthAccessoryAction` is a type alias for a closure that represents an action to
///     be performed when a user interacts with an accessory in the calendar.
public struct CalendarMonthAccessoryAction {
    let title: String
    let action: (CalendarMonth) -> Void

    /// - Parameters:
    ///  - title: The title of the accessory.
    ///  - action: The action to be performed when the user interacts with the accessory.
    ///           This closure takes a `CalendarMonth` as a parameter, which is the calendar month that the user interacted with.
    public init(title: String, action: @escaping (CalendarMonth) -> Void) {
        self.title = title
        self.action = action
    }
}
