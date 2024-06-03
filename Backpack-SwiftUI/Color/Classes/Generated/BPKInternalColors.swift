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

// swiftlint:disable identifier_name
// swiftlint:disable line_length

/// Backpack Internal Colors
/// These colors are internal on purpose and can only be used by Backpack components
/// Do not use these colors in your own designs.
internal extension BPKColor {
    private init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(value: UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }

    /// The `badgeBackgroundNormalColor` internal color.
    
    static let badgeBackgroundNormalColor = BPKColor(red: 0.937, green: 0.953, blue: 0.973, alpha: 1)
        .darkVariant(BPKColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `infoBannerDefaultColor` internal color.
    
    static let infoBannerDefaultColor = BPKColor(red: 0.937, green: 0.953, blue: 0.973, alpha: 1)
        .darkVariant(BPKColor(red: 0.075, green: 0.114, blue: 0.169, alpha: 1))

    /// The `infoBannerOnContrastColor` internal color.
    
    static let infoBannerOnContrastColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1)
        .darkVariant(BPKColor(red: 0.075, green: 0.114, blue: 0.169, alpha: 1))

    /// The `infoBannerSuccessColor` internal color.
    
    static let infoBannerSuccessColor = BPKColor(red: 0.047, green: 0.514, blue: 0.541, alpha: 1)
        .darkVariant(BPKColor(red: 0.384, green: 0.945, blue: 0.776, alpha: 1))

    /// The `infoBannerErrorColor` internal color.
    
    static let infoBannerErrorColor = BPKColor(red: 0.906, green: 0.031, blue: 0.400, alpha: 1)
        .darkVariant(BPKColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `infoBannerInfoColor` internal color.
    
    static let infoBannerInfoColor = BPKColor(red: 0.384, green: 0.412, blue: 0.443, alpha: 1)
        .darkVariant(BPKColor(red: 0.741, green: 0.769, blue: 0.796, alpha: 1))

    /// The `infoBannerWarningColor` internal color.
    
    static let infoBannerWarningColor = BPKColor(red: 0.961, green: 0.365, blue: 0.259, alpha: 1)
        .darkVariant(BPKColor(red: 0.996, green: 0.922, blue: 0.529, alpha: 1))

    /// The `chipOnDarkPressedStrokeColor` internal color.
    
    static let chipOnDarkPressedStrokeColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1)
        .darkVariant(BPKColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `chipOnDarkOnBackgroundColor` internal color.
    
    static let chipOnDarkOnBackgroundColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1)
        .darkVariant(BPKColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `chipDisabledBackgroundColor` internal color.
    
    static let chipDisabledBackgroundColor = BPKColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1)
        .darkVariant(BPKColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `chipOnDarkOnDismissIconColor` internal color.
    
    static let chipOnDarkOnDismissIconColor = BPKColor(red: 0.384, green: 0.412, blue: 0.443, alpha: 1)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255))

    /// The `mapPreviousSelectionColor` internal color.
    
    static let mapPreviousSelectionColor = BPKColor(red: 0.812, green: 0.894, blue: 1.000, alpha: 1)
        .darkVariant(BPKColor(red: 0.812, green: 0.894, blue: 1.000, alpha: 1))

    /// The `mapClusterPinColor` internal color.
    
    static let mapClusterPinColor = BPKColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `mapClusterPinPreviousSelectionColor` internal color.
    
    static let mapClusterPinPreviousSelectionColor = BPKColor(red: 0.580, green: 0.765, blue: 1.000, alpha: 1)
        .darkVariant(BPKColor(red: 0.580, green: 0.765, blue: 1.000, alpha: 1))

    /// The `mapMarkerViewedForegroundColor` internal color.
    
    static let mapMarkerViewedForegroundColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.8)
        .darkVariant(BPKColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.8))

    /// The `mapPoiPinColor` internal color.
    
    static let mapPoiPinColor = BPKColor(red: 0.557, green: 0.278, blue: 0.729, alpha: 1)
        .darkVariant(BPKColor(red: 0.557, green: 0.278, blue: 0.729, alpha: 1))

    /// The `buttonSecondaryPressedBackgroundColor` internal color.
    
    static let buttonSecondaryPressedBackgroundColor = BPKColor(red: 0.757, green: 0.780, blue: 0.812, alpha: 1)
        .darkVariant(BPKColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1))

    /// The `buttonLinkNormalForegroundColor` internal color.
    
    static let buttonLinkNormalForegroundColor = BPKColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1)
        .darkVariant(BPKColor(red: 0.518, green: 0.914, blue: 1.000, alpha: 1))

    /// The `buttonLinkOnDarkDisabledForegroundColor` internal color.
    
    static let buttonLinkOnDarkDisabledForegroundColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonSecondaryNormalBackgroundColor` internal color.
    
    static let buttonSecondaryNormalBackgroundColor = BPKColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1)
        .darkVariant(BPKColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonPrimaryOnLightPressedBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightPressedBackgroundColor = BPKColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1)
        .darkVariant(BPKColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `buttonFeaturedNormalBackgroundColor` internal color.
    
    static let buttonFeaturedNormalBackgroundColor = BPKColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1)
        .darkVariant(BPKColor(red: 0.518, green: 0.914, blue: 1.000, alpha: 1))

    /// The `buttonFeaturedPressedBackgroundColor` internal color.
    
    static let buttonFeaturedPressedBackgroundColor = BPKColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1)
        .darkVariant(BPKColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnLightNormalBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightNormalBackgroundColor = BPKColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1)
        .darkVariant(BPKColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1))

    /// The `buttonPrimaryOnLightDisabledForegroundColor` internal color.
    
    static let buttonPrimaryOnLightDisabledForegroundColor = BPKColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonSecondaryOnDarkDisabledBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkDisabledBackgroundColor = BPKColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1)
        .darkVariant(BPKColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonDestructiveNormalForegroundColor` internal color.
    
    static let buttonDestructiveNormalForegroundColor = BPKColor(red: 0.906, green: 0.031, blue: 0.400, alpha: 1)
        .darkVariant(BPKColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `buttonPrimaryOnDarkNormalBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkNormalBackgroundColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnDarkDisabledForegroundColor` internal color.
    
    static let buttonPrimaryOnDarkDisabledForegroundColor = BPKColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonSecondaryOnDarkPressedBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkPressedBackgroundColor = BPKColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1)
        .darkVariant(BPKColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1))

    /// The `buttonLinkPressedForegroundColor` internal color.
    
    static let buttonLinkPressedForegroundColor = BPKColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1)
        .darkVariant(BPKColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnLightDisabledBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightDisabledBackgroundColor = BPKColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1)
        .darkVariant(BPKColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonDestructiveNormalBackgroundColor` internal color.
    
    static let buttonDestructiveNormalBackgroundColor = BPKColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1)
        .darkVariant(BPKColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonPrimaryNormalBackgroundColor` internal color.
    
    static let buttonPrimaryNormalBackgroundColor = BPKColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1)
        .darkVariant(BPKColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1))

    /// The `buttonDestructivePressedBackgroundColor` internal color.
    
    static let buttonDestructivePressedBackgroundColor = BPKColor(red: 0.906, green: 0.031, blue: 0.400, alpha: 1)
        .darkVariant(BPKColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `buttonPrimaryPressedBackgroundColor` internal color.
    
    static let buttonPrimaryPressedBackgroundColor = BPKColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1)
        .darkVariant(BPKColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `buttonPrimaryOnDarkDisabledBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkDisabledBackgroundColor = BPKColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1)
        .darkVariant(BPKColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonLinkOnDarkPressedForegroundColor` internal color.
    
    static let buttonLinkOnDarkPressedForegroundColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255))

    /// The `buttonLinkOnDarkNormalForegroundColor` internal color.
    
    static let buttonLinkOnDarkNormalForegroundColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonDisabledBackgroundColor` internal color.
    
    static let buttonDisabledBackgroundColor = BPKColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1)
        .darkVariant(BPKColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonSecondaryOnDarkNormalBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkNormalBackgroundColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.10196078431372549)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.10196078431372549))

    /// The `buttonSecondaryOnDarkDisabledForegroundColor` internal color.
    
    static let buttonSecondaryOnDarkDisabledForegroundColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonPrimaryOnDarkPressedBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkPressedBackgroundColor = BPKColor(red: 0.757, green: 0.780, blue: 0.812, alpha: 1)
        .darkVariant(BPKColor(red: 0.757, green: 0.780, blue: 0.812, alpha: 1))

    /// The `barTrackDefaultColor` internal color.
    
    static let barTrackDefaultColor = BPKColor(red: 0.878, green: 0.894, blue: 0.914, alpha: 1)
        .darkVariant(BPKColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `barTrackOnContrastColor` internal color.
    
    static let barTrackOnContrastColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1)
        .darkVariant(BPKColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `skeletonShimmerStartEndColor` internal color.
    
    static let skeletonShimmerStartEndColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0)
        .darkVariant(BPKColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0))

    /// The `skeletonShimmerCenterColor` internal color.
    
    static let skeletonShimmerCenterColor = BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.6)
        .darkVariant(BPKColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `sponsoredBannerBackgroundColor` internal color.
    
    static let sponsoredBannerBackgroundColor = BPKColor(red: 0.937, green: 0.953, blue: 0.973, alpha: 1)
        .darkVariant(BPKColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `navigationTabHoverColor` internal color.
    
    static let navigationTabHoverColor = BPKColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1)
        .darkVariant(BPKColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

    /// The `navigationTabOutlineColor` internal color.
    
    static let navigationTabOutlineColor = BPKColor(red: 0.757, green: 0.780, blue: 0.812, alpha: 1)
        .darkVariant(BPKColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))
}
