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

// swiftlint:disable bpk_use_colour_token
// swiftlint:disable identifier_name
// swiftlint:disable indentation_width
internal extension BPKColor {

    private static var dynamicColorsCache = NSCache<NSString, UIColor>()
    
    static func dynamicColor(lightVariant: UIColor, darkVariant: UIColor) -> UIColor {
        // 1. Build a cache key
        let key = "\(lightVariant.cacheKey)_\(darkVariant.cacheKey)" as NSString
            
            // 2. Return cached if we have it
            if let cached = dynamicColorsCache.object(forKey: key) {
                return cached
            }
            
            // 3. Create the dynamic provider
            let dynamic = UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? darkVariant : lightVariant
            }
            
            // 4. Cache & return
            dynamicColorsCache.setObject(dynamic, forKey: key)
            return dynamic
    }

    /// The `badgeBackgroundNormalColor` internal color.
    
    static let badgeBackgroundNormalColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.937, green: 0.953, blue: 0.973, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `infoBannerDefaultColor` internal color.
    
    static let infoBannerDefaultColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.937, green: 0.953, blue: 0.973, alpha: 1),
        darkVariant: UIColor(red: 0.075, green: 0.114, blue: 0.169, alpha: 1))

    /// The `infoBannerOnContrastColor` internal color.
    
    static let infoBannerOnContrastColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.075, green: 0.114, blue: 0.169, alpha: 1))

    /// The `infoBannerSuccessColor` internal color.
    
    static let infoBannerSuccessColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.047, green: 0.514, blue: 0.541, alpha: 1),
        darkVariant: UIColor(red: 0.384, green: 0.945, blue: 0.776, alpha: 1))

    /// The `infoBannerErrorColor` internal color.
    
    static let infoBannerErrorColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.906, green: 0.031, blue: 0.400, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `infoBannerInfoColor` internal color.
    
    static let infoBannerInfoColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.384, green: 0.412, blue: 0.443, alpha: 1),
        darkVariant: UIColor(red: 0.741, green: 0.769, blue: 0.796, alpha: 1))

    /// The `infoBannerWarningColor` internal color.
    
    static let infoBannerWarningColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.961, green: 0.365, blue: 0.259, alpha: 1),
        darkVariant: UIColor(red: 0.996, green: 0.922, blue: 0.529, alpha: 1))

    /// The `chipOnDarkPressedStrokeColor` internal color.
    
    static let chipOnDarkPressedStrokeColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `chipOnDarkOnBackgroundColor` internal color.
    
    static let chipOnDarkOnBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `chipDisabledBackgroundColor` internal color.
    
    static let chipDisabledBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `chipOnDarkOnDismissIconColor` internal color.
    
    static let chipOnDarkOnDismissIconColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.384, green: 0.412, blue: 0.443, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255))

    /// The `mapPreviousSelectionColor` internal color.
    
    static let mapPreviousSelectionColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.812, green: 0.894, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.812, green: 0.894, blue: 1.000, alpha: 1))

    /// The `mapClusterPinColor` internal color.
    
    static let mapClusterPinColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `mapClusterPinPreviousSelectionColor` internal color.
    
    static let mapClusterPinPreviousSelectionColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.580, green: 0.765, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.580, green: 0.765, blue: 1.000, alpha: 1))

    /// The `mapMarkerViewedForegroundColor` internal color.
    
    static let mapMarkerViewedForegroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.8),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.8))

    /// The `mapPoiPinColor` internal color.
    
    static let mapPoiPinColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.557, green: 0.278, blue: 0.729, alpha: 1),
        darkVariant: UIColor(red: 0.557, green: 0.278, blue: 0.729, alpha: 1))

    /// The `buttonSecondaryPressedBackgroundColor` internal color.
    
    static let buttonSecondaryPressedBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.757, green: 0.780, blue: 0.812, alpha: 1),
        darkVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1))

    /// The `buttonLinkNormalForegroundColor` internal color.
    
    static let buttonLinkNormalForegroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1),
        darkVariant: UIColor(red: 0.518, green: 0.914, blue: 1.000, alpha: 1))

    /// The `buttonLinkOnDarkDisabledForegroundColor` internal color.
    
    static let buttonLinkOnDarkDisabledForegroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonSecondaryNormalBackgroundColor` internal color.
    
    static let buttonSecondaryNormalBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonPrimaryOnLightPressedBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightPressedBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `buttonFeaturedNormalBackgroundColor` internal color.
    
    static let buttonFeaturedNormalBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1),
        darkVariant: UIColor(red: 0.518, green: 0.914, blue: 1.000, alpha: 1))

    /// The `buttonFeaturedPressedBackgroundColor` internal color.
    
    static let buttonFeaturedPressedBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1),
        darkVariant: UIColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnLightNormalBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightNormalBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1))

    /// The `buttonPrimaryOnLightDisabledForegroundColor` internal color.
    
    static let buttonPrimaryOnLightDisabledForegroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonSecondaryOnDarkDisabledBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkDisabledBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonDestructiveNormalForegroundColor` internal color.
    
    static let buttonDestructiveNormalForegroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.906, green: 0.031, blue: 0.400, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `buttonPrimaryOnDarkNormalBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkNormalBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnDarkDisabledForegroundColor` internal color.
    
    static let buttonPrimaryOnDarkDisabledForegroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonSecondaryOnDarkPressedBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkPressedBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1),
        darkVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1))

    /// The `buttonLinkPressedForegroundColor` internal color.
    
    static let buttonLinkPressedForegroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1),
        darkVariant: UIColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnLightDisabledBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightDisabledBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonDestructiveNormalBackgroundColor` internal color.
    
    static let buttonDestructiveNormalBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonPrimaryNormalBackgroundColor` internal color.
    
    static let buttonPrimaryNormalBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1))

    /// The `buttonDestructivePressedBackgroundColor` internal color.
    
    static let buttonDestructivePressedBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.906, green: 0.031, blue: 0.400, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `buttonPrimaryPressedBackgroundColor` internal color.
    
    static let buttonPrimaryPressedBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `buttonPrimaryOnDarkDisabledBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkDisabledBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonLinkOnDarkPressedForegroundColor` internal color.
    
    static let buttonLinkOnDarkPressedForegroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255))

    /// The `buttonLinkOnDarkNormalForegroundColor` internal color.
    
    static let buttonLinkOnDarkNormalForegroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonDisabledBackgroundColor` internal color.
    
    static let buttonDisabledBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonSecondaryOnDarkNormalBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkNormalBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.10196078431372549),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.10196078431372549))

    /// The `buttonSecondaryOnDarkDisabledForegroundColor` internal color.
    
    static let buttonSecondaryOnDarkDisabledForegroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonPrimaryOnDarkPressedBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkPressedBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.757, green: 0.780, blue: 0.812, alpha: 1),
        darkVariant: UIColor(red: 0.757, green: 0.780, blue: 0.812, alpha: 1))

    /// The `barTrackDefaultColor` internal color.
    
    static let barTrackDefaultColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `barTrackOnContrastColor` internal color.
    
    static let barTrackOnContrastColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `skeletonShimmerStartEndColor` internal color.
    
    static let skeletonShimmerStartEndColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0))

    /// The `skeletonShimmerCenterColor` internal color.
    
    static let skeletonShimmerCenterColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.6),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `sponsoredBannerBackgroundColor` internal color.
    
    static let sponsoredBannerBackgroundColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.937, green: 0.953, blue: 0.973, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `navigationTabHoverColor` internal color.
    
    static let navigationTabHoverColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

    /// The `navigationTabOutlineColor` internal color.
    
    static let navigationTabOutlineColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.757, green: 0.780, blue: 0.812, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `cardButtonContainedFillColor` internal color.
    
    static let cardButtonContainedFillColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.8),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.8))

    /// The `segmentedControlCanvasDefaultColor` internal color.
    
    static let segmentedControlCanvasDefaultColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.937, green: 0.953, blue: 0.973, alpha: 1),
        darkVariant: UIColor(red: 0.075, green: 0.114, blue: 0.169, alpha: 1))

    /// The `segmentedControlSurfaceContrastColor` internal color.
    
    static let segmentedControlSurfaceContrastColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.10196078431372549),
        darkVariant: UIColor(red: 0.075, green: 0.114, blue: 0.169, alpha: 1))

    /// The `segmentedControlSurfaceContrastOnColor` internal color.
    
    static let segmentedControlSurfaceContrastOnColor = BPKColor.dynamicColor(
        lightVariant: UIColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))
}

private extension UIColor {
    /// A crude cache-key generator: e.g. “#RRGGBBAA”
    var cacheKey: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return "non-rgb-color:\(self.description)"
        }

        return String(format: "#%02X%02X%02X%02X",
                      Int(round(red * 255)),
                      Int(round(green * 255)),
                      Int(round(blue * 255)),
                      Int(round(alpha * 255)))
    }
}

