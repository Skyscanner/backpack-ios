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

/// Represents a scrollable month with a unique identifier and anchor point for positioning.
public struct MonthScroll {
    /// Unique identifier for the scroll item.
    let scrollId: String

    /// Anchor point for the scroll position, defaulting to `.top`.
    let anchor: UnitPoint

    /// Whether to animate the change in scroll position or not
    let animated: Bool

    /// Static `DateFormatter` to format dates as "yyyy-MM" strings, used for generating `scrollId`s.
    /// - Example: For a date of December 25, 2024, it produces `"2024-12"`.
    private let formatter: DateFormatter

    // MARK: - Initialiser

    /// Initialises `MonthScroll` using a `Date` to generate the `scrollId`, with `anchor`.
    public init(monthToScroll: Date, anchor: UnitPoint = .top, animated: Bool = false) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"

        self.scrollId = dateFormatter.string(from: monthToScroll)
        self.anchor = anchor
        self.animated = animated
        self.formatter = dateFormatter
    }

    // MARK: - Public Methods

    /// Generates a unique identifier for a given `Date` using the "yyyy-MM" format.
    /// - Parameter date: The date to format.
    /// - Returns: A string representing the date in "yyyy-MM" format.
    /// - Example: For a date of December 25, 2024, this method returns `"2024-12"`.
    func generateIdFor(date: Date) -> String {
        formatter.string(from: date)
    }
}
