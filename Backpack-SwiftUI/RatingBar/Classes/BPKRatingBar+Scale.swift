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

extension BPKRatingBar {
    /// An enumeration representing different rating scales.
    public enum RatingScale {
        /// A rating scale from zero to five.
        case zeroToFive
        
        /// A rating scale from zero to ten.
        case zeroToTen
        
        var scaleLabel: String {
            switch self {
            case .zeroToFive: return "5"
            case .zeroToTen: return "10"
            }
        }
        
        var rawScale: Float {
            switch self {
            case .zeroToFive: return 5
            case .zeroToTen: return 10
            }
        }
    }
}
