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

public func dynamicColor(lightVariant: UIColor, darkVariant: UIColor) -> UIColor {
    UIColor { $0.userInterfaceStyle == .dark ? darkVariant : lightVariant }
}

/// Backpack Dynamic Colors
public extension BPKColor {
    private func darkVariant(_ darkVariant: BPKColor) -> BPKColor {
        BPKColor(value: dynamicColor(lightVariant: value, darkVariant: darkVariant.value))
    }

    /// The `backgroundAlternativeColor` dynamic color from the Backpack palette.
    static let backgroundAlternativeColor = skyGrayTint07.darkVariant(black)

    /// The `backgroundAlternativeSecondaryColor` dynamic color from the Backpack palette.
    static let backgroundAlternativeSecondaryColor = white.darkVariant(blackTint01)

    /// The `backgroundColor` dynamic color from the Backpack palette.
    static let backgroundColor = white.darkVariant(black)

    /// The `backgroundElevation01Color` dynamic color from the Backpack palette.
    static let backgroundElevation01Color = white.darkVariant(blackTint01)

    /// The `backgroundElevation02Color` dynamic color from the Backpack palette.
    static let backgroundElevation02Color = white.darkVariant(blackTint02)

    /// The `backgroundElevation03Color` dynamic color from the Backpack palette.
    static let backgroundElevation03Color = white.darkVariant(blackTint03)

    /// The `backgroundSecondaryColor` dynamic color from the Backpack palette.
    static let backgroundSecondaryColor = skyGrayTint07.darkVariant(blackTint01)

    /// The `backgroundTertiaryColor` dynamic color from the Backpack palette.
    static let backgroundTertiaryColor = white.darkVariant(blackTint02)

    /// The `lineColor` dynamic color from the Backpack palette.
    static let lineColor = skyGrayTint05.darkVariant(blackTint04)

    /// The `primaryColor` dynamic color from the Backpack palette.
    static let primaryColor = skyBlue.darkVariant(skyBlueTint01)

    /// The `textPrimaryColor` dynamic color from the Backpack palette.
    static let textPrimaryColor = skyGray.darkVariant(white)

    /// The `textQuaternaryColor` dynamic color from the Backpack palette.
    static let textQuaternaryColor = skyGrayTint03.darkVariant(blackTint06)

    /// The `textSecondaryColor` dynamic color from the Backpack palette.
    static let textSecondaryColor = skyGrayTint02.darkVariant(skyGrayTint04)

    /// The `textTertiaryColor` dynamic color from the Backpack palette.
    static let textTertiaryColor = skyGrayTint03.darkVariant(blackTint06)
}
