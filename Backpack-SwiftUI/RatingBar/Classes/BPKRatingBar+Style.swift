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
    /// The style options for the rating bar.
    public enum Style {
        /// The default style.
        case `default`
        
        /// The style for use on high contrast backgrounds.
        case onContrast
        
        var ratingBarBackgroundColor: BPKColor {
            switch self {
            case .default:
                BPKColor(value: UIColor(red: 0.88, green: 0.89, blue: 0.9, alpha: 1))
                    .darkVariant(.surfaceElevatedColor)
            case .onContrast:
                BPKColor(value: .white)
                    .darkVariant(BPKColor(value: UIColor(red: 0.14, green: 0.2, blue: 0.27, alpha: 1)))
            }
        }
    }
}
