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
    private init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(value: UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    func darkVariant(_ darkVariant: BPKColor) -> BPKColor {
        BPKColor(value: dynamicColor(lightVariant: value, darkVariant: darkVariant.value))
    }

    /// The `backgroundAlternativeColor` dynamic color from the Backpack palette.
    static let backgroundAlternativeColor = BPKColor(red:0.945, green:0.949, blue:0.973, alpha:1)
        .darkVariant(BPKColor(red:0.000, green:0.000, blue:0.000, alpha:1))

    /// The `backgroundAlternativeSecondaryColor` dynamic color from the Backpack palette.
    static let backgroundAlternativeSecondaryColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.114, green:0.106, blue:0.125, alpha:1))

    /// The `backgroundColor` dynamic color from the Backpack palette.
    static let backgroundColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.000, green:0.000, blue:0.000, alpha:1))

    /// The `backgroundElevation01Color` dynamic color from the Backpack palette.
    static let backgroundElevation01Color = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.114, green:0.106, blue:0.125, alpha:1))

    /// The `backgroundElevation02Color` dynamic color from the Backpack palette.
    static let backgroundElevation02Color = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.173, green:0.173, blue:0.180, alpha:1))

    /// The `backgroundElevation03Color` dynamic color from the Backpack palette.
    static let backgroundElevation03Color = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.227, green:0.227, blue:0.235, alpha:1))

    /// The `backgroundSecondaryColor` dynamic color from the Backpack palette.
    static let backgroundSecondaryColor = BPKColor(red:0.945, green:0.949, blue:0.973, alpha:1)
        .darkVariant(BPKColor(red:0.114, green:0.106, blue:0.125, alpha:1))

    /// The `backgroundTertiaryColor` dynamic color from the Backpack palette.
    static let backgroundTertiaryColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.173, green:0.173, blue:0.180, alpha:1))

    /// The `canvasContrastColor` dynamic color from the Backpack palette.
    static let canvasContrastColor = BPKColor(red:0.945, green:0.949, blue:0.973, alpha:1)
        .darkVariant(BPKColor(red:0.114, green:0.106, blue:0.125, alpha:1))

    /// The `canvasColor` dynamic color from the Backpack palette.
    static let canvasColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.000, green:0.000, blue:0.000, alpha:1))

    /// The `coreAccentColor` dynamic color from the Backpack palette.
    static let coreAccentColor = BPKColor(red:0.027, green:0.439, blue:0.890, alpha:1)
        .darkVariant(BPKColor(red:0.427, green:0.624, blue:0.922, alpha:1))

    /// The `coreEcoColor` dynamic color from the Backpack palette.
    static let coreEcoColor = BPKColor(red:0.059, green:0.631, blue:0.663, alpha:1)
        .darkVariant(BPKColor(red:0.059, green:0.631, blue:0.663, alpha:1))

    /// The `corePrimaryColor` dynamic color from the Backpack palette.
    static let corePrimaryColor = BPKColor(red:0.008, green:0.071, blue:0.173, alpha:1)
        .darkVariant(BPKColor(red:0.020, green:0.255, blue:0.518, alpha:1))

    /// The `lineColor` dynamic color from the Backpack palette.
    static let lineColor = BPKColor(red:0.804, green:0.804, blue:0.843, alpha:1)
        .darkVariant(BPKColor(red:0.282, green:0.282, blue:0.290, alpha:1))

    /// The `primaryColor` dynamic color from the Backpack palette.
    static let primaryColor = BPKColor(red:0.027, green:0.439, blue:0.890, alpha:1)
        .darkVariant(BPKColor(red:0.427, green:0.624, blue:0.922, alpha:1))

    /// The `scrimColor` dynamic color from the Backpack palette.
    static let scrimColor = BPKColor(red:0.008, green:0.071, blue:0.173, alpha:1)
        .darkVariant(BPKColor(red:0.008, green:0.071, blue:0.173, alpha:1))

    /// The `statusDangerFillColor` dynamic color from the Backpack palette.
    static let statusDangerFillColor = BPKColor(red:0.965, green:0.867, blue:0.882, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:0.792, blue:0.867, alpha:1))

    /// The `statusDangerSpotColor` dynamic color from the Backpack palette.
    static let statusDangerSpotColor = BPKColor(red:0.820, green:0.263, blue:0.357, alpha:1)
        .darkVariant(BPKColor(red:0.820, green:0.263, blue:0.357, alpha:1))

    /// The `statusSuccessFillColor` dynamic color from the Backpack palette.
    static let statusSuccessFillColor = BPKColor(red:0.816, green:0.933, blue:0.925, alpha:1)
        .darkVariant(BPKColor(red:0.694, green:1.000, blue:0.906, alpha:1))

    /// The `statusSuccessSpotColor` dynamic color from the Backpack palette.
    static let statusSuccessSpotColor = BPKColor(red:0.000, green:0.651, blue:0.596, alpha:1)
        .darkVariant(BPKColor(red:0.000, green:0.651, blue:0.596, alpha:1))

    /// The `statusWarningFillColor` dynamic color from the Backpack palette.
    static let statusWarningFillColor = BPKColor(red:1.000, green:0.922, blue:0.816, alpha:1)
        .darkVariant(BPKColor(red:0.984, green:0.945, blue:0.733, alpha:1))

    /// The `statusWarningSpotColor` dynamic color from the Backpack palette.
    static let statusWarningSpotColor = BPKColor(red:1.000, green:0.580, blue:0.000, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:0.710, blue:0.302, alpha:1))

    /// The `surfaceContrastColor` dynamic color from the Backpack palette.
    static let surfaceContrastColor = BPKColor(red:0.008, green:0.071, blue:0.173, alpha:1)
        .darkVariant(BPKColor(red:0.114, green:0.106, blue:0.125, alpha:1))

    /// The `surfaceDefaultColor` dynamic color from the Backpack palette.
    static let surfaceDefaultColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.114, green:0.106, blue:0.125, alpha:1))

    /// The `surfaceElevatedColor` dynamic color from the Backpack palette.
    static let surfaceElevatedColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.173, green:0.173, blue:0.180, alpha:1))

    /// The `surfaceHighlightColor` dynamic color from the Backpack palette.
    static let surfaceHighlightColor = BPKColor(red:0.867, green:0.867, blue:0.898, alpha:1)
        .darkVariant(BPKColor(red:0.173, green:0.173, blue:0.180, alpha:1))

    /// The `textDisabledColor` dynamic color from the Backpack palette.
    static let textDisabledColor = BPKColor(red:0.698, green:0.698, blue:0.749, alpha:1)
        .darkVariant(BPKColor(red:0.557, green:0.557, blue:0.576, alpha:1))

    /// The `textErrorColor` dynamic color from the Backpack palette.
    static let textErrorColor = BPKColor(red:0.820, green:0.263, blue:0.357, alpha:1)
        .darkVariant(BPKColor(red:0.820, green:0.263, blue:0.357, alpha:1))

    /// The `textLinkColor` dynamic color from the Backpack palette.
    static let textLinkColor = BPKColor(red:0.027, green:0.439, blue:0.890, alpha:1)
        .darkVariant(BPKColor(red:0.427, green:0.624, blue:0.922, alpha:1))

    /// The `textOnDarkColor` dynamic color from the Backpack palette.
    static let textOnDarkColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1))

    /// The `textOnLightColor` dynamic color from the Backpack palette.
    static let textOnLightColor = BPKColor(red:0.067, green:0.071, blue:0.212, alpha:1)
        .darkVariant(BPKColor(red:0.067, green:0.071, blue:0.212, alpha:1))

    /// The `textPrimaryColor` dynamic color from the Backpack palette.
    static let textPrimaryColor = BPKColor(red:0.067, green:0.071, blue:0.212, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1))

    /// The `textPrimaryInverseColor` dynamic color from the Backpack palette.
    static let textPrimaryInverseColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.067, green:0.071, blue:0.212, alpha:1))

    /// The `textQuaternaryColor` dynamic color from the Backpack palette.
    static let textQuaternaryColor = BPKColor(red:0.561, green:0.565, blue:0.627, alpha:1)
        .darkVariant(BPKColor(red:0.557, green:0.557, blue:0.576, alpha:1))

    /// The `textSecondaryColor` dynamic color from the Backpack palette.
    static let textSecondaryColor = BPKColor(red:0.408, green:0.412, blue:0.498, alpha:1)
        .darkVariant(BPKColor(red:0.698, green:0.698, blue:0.749, alpha:1))

    /// The `textTertiaryColor` dynamic color from the Backpack palette.
    static let textTertiaryColor = BPKColor(red:0.561, green:0.565, blue:0.627, alpha:1)
        .darkVariant(BPKColor(red:0.557, green:0.557, blue:0.576, alpha:1))
}
