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

    /// The `canvasColor` dynamic color from the Backpack palette.
    
    static let canvasColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.004, green:0.035, blue:0.075, alpha:1))

    /// The `canvasContrastColor` dynamic color from the Backpack palette.
    
    static let canvasContrastColor = BPKColor(red:0.937, green:0.945, blue:0.949, alpha:1)
        .darkVariant(BPKColor(red:0.004, green:0.035, blue:0.075, alpha:1))

    /// The `coreEcoColor` dynamic color from the Backpack palette.
    
    static let coreEcoColor = BPKColor(red:0.059, green:0.631, blue:0.663, alpha:1)
        .darkVariant(BPKColor(red:0.059, green:0.631, blue:0.663, alpha:1))

    /// The `coreAccentColor` dynamic color from the Backpack palette.
    
    static let coreAccentColor = BPKColor(red:0.000, green:0.384, blue:0.890, alpha:1)
        .darkVariant(BPKColor(red:0.518, green:0.914, blue:1.000, alpha:1))

    /// The `corePrimaryColor` dynamic color from the Backpack palette.
    
    static let corePrimaryColor = BPKColor(red:0.020, green:0.125, blue:0.235, alpha:1)
        .darkVariant(BPKColor(red:0.020, green:0.255, blue:0.518, alpha:1))

    /// The `statusSuccessSpotColor` dynamic color from the Backpack palette.
    
    static let statusSuccessSpotColor = BPKColor(red:0.047, green:0.514, blue:0.541, alpha:1)
        .darkVariant(BPKColor(red:0.384, green:0.945, blue:0.776, alpha:1))

    /// The `statusSuccessFillColor` dynamic color from the Backpack palette.
    
    static let statusSuccessFillColor = BPKColor(red:0.831, green:1.000, blue:0.949, alpha:1)
        .darkVariant(BPKColor(red:0.694, green:1.000, blue:0.906, alpha:1))

    /// The `statusDangerSpotColor` dynamic color from the Backpack palette.
    
    static let statusDangerSpotColor = BPKColor(red:0.906, green:0.031, blue:0.400, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:0.392, blue:0.612, alpha:1))

    /// The `statusWarningSpotColor` dynamic color from the Backpack palette.
    
    static let statusWarningSpotColor = BPKColor(red:0.961, green:0.365, blue:0.259, alpha:1)
        .darkVariant(BPKColor(red:0.996, green:0.922, blue:0.529, alpha:1))

    /// The `statusDangerFillColor` dynamic color from the Backpack palette.
    
    static let statusDangerFillColor = BPKColor(red:1.000, green:0.914, blue:0.976, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:0.792, blue:0.867, alpha:1))

    /// The `statusWarningFillColor` dynamic color from the Backpack palette.
    
    static let statusWarningFillColor = BPKColor(red:1.000, green:0.969, blue:0.812, alpha:1)
        .darkVariant(BPKColor(red:0.984, green:0.945, blue:0.733, alpha:1))

    /// The `surfaceContrastColor` dynamic color from the Backpack palette.
    
    static let surfaceContrastColor = BPKColor(red:0.020, green:0.125, blue:0.235, alpha:1)
        .darkVariant(BPKColor(red:0.075, green:0.114, blue:0.169, alpha:1))

    /// The `surfaceDefaultColor` dynamic color from the Backpack palette.
    
    static let surfaceDefaultColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.075, green:0.114, blue:0.169, alpha:1))

    /// The `surfaceElevatedColor` dynamic color from the Backpack palette.
    
    static let surfaceElevatedColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1))

    /// The `surfaceHighlightColor` dynamic color from the Backpack palette.
    
    static let surfaceHighlightColor = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)
        .darkVariant(BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1))

    /// The `textOnDarkColor` dynamic color from the Backpack palette.
    
    static let textOnDarkColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1))

    /// The `textOnLightColor` dynamic color from the Backpack palette.
    
    static let textOnLightColor = BPKColor(red:0.086, green:0.086, blue:0.086, alpha:1)
        .darkVariant(BPKColor(red:0.086, green:0.086, blue:0.086, alpha:1))

    /// The `textLinkColor` dynamic color from the Backpack palette.
    
    static let textLinkColor = BPKColor(red:0.000, green:0.384, blue:0.890, alpha:1)
        .darkVariant(BPKColor(red:0.518, green:0.914, blue:1.000, alpha:1))

    /// The `textDisabledColor` dynamic color from the Backpack palette.
    
    static let textDisabledColor = BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0.2)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.2))

    /// The `textPrimaryColor` dynamic color from the Backpack palette.
    
    static let textPrimaryColor = BPKColor(red:0.086, green:0.086, blue:0.086, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1))

    /// The `textQuaternaryColor` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let textQuaternaryColor = BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0.2)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.2))

    /// The `textErrorColor` dynamic color from the Backpack palette.
    
    static let textErrorColor = BPKColor(red:0.906, green:0.031, blue:0.400, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:0.392, blue:0.612, alpha:1))

    /// The `textTertiaryColor` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let textTertiaryColor = BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0.2)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.2))

    /// The `textSecondaryColor` dynamic color from the Backpack palette.
    
    static let textSecondaryColor = BPKColor(red:0.329, green:0.345, blue:0.376, alpha:1)
        .darkVariant(BPKColor(red:0.741, green:0.769, blue:0.796, alpha:1))

    /// The `textPrimaryInverseColor` dynamic color from the Backpack palette.
    
    static let textPrimaryInverseColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.086, green:0.086, blue:0.086, alpha:1))

    /// The `scrimColor` dynamic color from the Backpack palette.
    
    static let scrimColor = BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0.7019607843137254)
        .darkVariant(BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0.7019607843137254))

    /// The `backgroundElevation03Color` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let backgroundElevation03Color = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1))

    /// The `backgroundElevation02Color` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let backgroundElevation02Color = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1))

    /// The `lineOnDarkColor` dynamic color from the Backpack palette.
    
    static let lineOnDarkColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.5019607843137255)
        .darkVariant(BPKColor(red:0.267, green:0.314, blue:0.373, alpha:1))

    /// The `lineColor` dynamic color from the Backpack palette.
    
    static let lineColor = BPKColor(red:0.761, green:0.788, blue:0.804, alpha:1)
        .darkVariant(BPKColor(red:0.267, green:0.314, blue:0.373, alpha:1))

    /// The `backgroundElevation01Color` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let backgroundElevation01Color = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.075, green:0.114, blue:0.169, alpha:1))

    /// The `backgroundAlternativeSecondaryColor` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let backgroundAlternativeSecondaryColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.004, green:0.035, blue:0.075, alpha:1))

    /// The `backgroundColor` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let backgroundColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.004, green:0.035, blue:0.075, alpha:1))

    /// The `backgroundTertiaryColor` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let backgroundTertiaryColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.004, green:0.035, blue:0.075, alpha:1))

    /// The `backgroundSecondaryColor` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let backgroundSecondaryColor = BPKColor(red:0.937, green:0.945, blue:0.949, alpha:1)
        .darkVariant(BPKColor(red:0.075, green:0.114, blue:0.169, alpha:1))

    /// The `backgroundAlternativeColor` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let backgroundAlternativeColor = BPKColor(red:0.937, green:0.945, blue:0.949, alpha:1)
        .darkVariant(BPKColor(red:0.075, green:0.114, blue:0.169, alpha:1))

    /// The `primaryColor` dynamic color from the Backpack palette.
    @available(*, deprecated, message: "This colour will be removed in the next major version")
    static let primaryColor = BPKColor(red:0.000, green:0.384, blue:0.890, alpha:1)
        .darkVariant(BPKColor(red:0.518, green:0.914, blue:1.000, alpha:1))
}
