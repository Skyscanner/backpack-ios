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

import UIKit

/// Backpack Internal Colors
/// These colors are internal on purpose and can only be used by Backpack components
/// Do not use these colors in your own designs.
internal extension BPKColor {
    private init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(value: UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }


    /// The `chipOnDarkNormalBackgroundColor` internal color.
    
    static let chipOnDarkNormalBackgroundColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.2)
        .darkVariant(BPKColor(red:0.043, green:0.071, blue:0.114, alpha:1))

    /// The `chipOnDarkPressedBackgroundColor` internal color.
    
    static let chipOnDarkPressedBackgroundColor = BPKColor(red:0.776, green:0.800, blue:0.831, alpha:1)
        .darkVariant(BPKColor(red:0.000, green:0.157, blue:0.329, alpha:1))

    /// The `chipOnDarkOnBackgroundColor` internal color.
    
    static let chipOnDarkOnBackgroundColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.020, green:0.255, blue:0.518, alpha:1))

    /// The `chipDefaultNormalBackgroundColor` internal color.
    
    static let chipDefaultNormalBackgroundColor = BPKColor(red:0.867, green:0.867, blue:0.898, alpha:1)
        .darkVariant(BPKColor(red:0.043, green:0.071, blue:0.114, alpha:1))

    /// The `chipDefaultOnBackgroundColor` internal color.
    
    static let chipDefaultOnBackgroundColor = BPKColor(red:0.020, green:0.125, blue:0.235, alpha:1)
        .darkVariant(BPKColor(red:0.020, green:0.255, blue:0.518, alpha:1))

    /// The `chipDisabledBackgroundColor` internal color.
    
    static let chipDisabledBackgroundColor = BPKColor(red:0.867, green:0.882, blue:0.894, alpha:1)
        .darkVariant(BPKColor(red:0.043, green:0.067, blue:0.102, alpha:1))

    /// The `chipDefaultPressedBackgroundColor` internal color.
    
    static let chipDefaultPressedBackgroundColor = BPKColor(red:0.776, green:0.800, blue:0.831, alpha:1)
        .darkVariant(BPKColor(red:0.000, green:0.157, blue:0.329, alpha:1))
}
