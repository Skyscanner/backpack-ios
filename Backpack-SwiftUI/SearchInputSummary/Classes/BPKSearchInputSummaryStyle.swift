/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

extension BPKSearchInputSummary {
    /// The style of the text field.
    public enum Style {
        /// The default state.
        case `default`
        /// Highlight borders as it's in a focus state
        case focused
    }

    /// The docking position for stacked search inputs.
    /// Controls which corners are rounded when inputs are grouped together.
    public enum Docking {
        /// All corners rounded (standalone input, not docked to others)
        case float
        /// Only top corners rounded (first input in a vertical stack)
        case top
        /// No corners rounded (middle input in a vertical stack)
        case middle
        /// Only bottom corners rounded (last input in a vertical stack)
        case bottom

        var topCornerRadius: CGFloat {
            switch self {
            case .float, .top:
                return BPKCornerRadius.md.value
            case .middle, .bottom:
                return 0
            }
        }

        var bottomCornerRadius: CGFloat {
            switch self {
            case .float, .bottom:
                return BPKCornerRadius.md.value
            case .middle, .top:
                return 0
            }
        }
    }
}
