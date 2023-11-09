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

/// Backpack Static Colors
public extension BPKColor {
    private init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(value: UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }

    /// The `black` color from the Backpack palette - rgb(1, 9, 19)
    
    static let black = BPKColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1)

    /// The `white` color from the Backpack palette - rgb(255, 255, 255)
    
    static let white = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1)

    /// The `skyBlue` color from the Backpack palette - rgb(0, 98, 227)
    
    static let skyBlue = BPKColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1)

    /// The `shadowSmColor` color from the Backpack palette - rgb(22, 22, 22)
    
    static let shadowSmColor = BPKColor(red: 0.086, green: 0.086, blue: 0.086, alpha: 1)

    /// The `shadowLgColor` color from the Backpack palette - rgb(22, 22, 22)
    
    static let shadowLgColor = BPKColor(red: 0.086, green: 0.086, blue: 0.086, alpha: 1)

    /// The `touchableOverlayColor` color from the Backpack palette - rgb(22, 22, 22)
    
    static let touchableOverlayColor = BPKColor(red: 0.086, green: 0.086, blue: 0.086, alpha: 1)
}
