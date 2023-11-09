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
internal extension BPKColor {

    /// The `badgeBackgroundNormalDay` internal color.
    
    static let badgeBackgroundNormalDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.937, green: 0.945, blue: 0.949, alpha: 1),
        darkVariant: UIColor(red: 0.937, green: 0.945, blue: 0.949, alpha: 1))

    /// The `badgeBackgroundNormalNight` internal color.
    
    static let badgeBackgroundNormalNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `infoBannerSuccessColor` internal color.
    
    static let infoBannerSuccessColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.047, green: 0.514, blue: 0.541, alpha: 1),
        darkVariant: UIColor(red: 0.047, green: 0.514, blue: 0.541, alpha: 1))

    /// The `infoBannerWarningColor` internal color.
    
    static let infoBannerWarningColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.961, green: 0.365, blue: 0.259, alpha: 1),
        darkVariant: UIColor(red: 0.961, green: 0.365, blue: 0.259, alpha: 1))

    /// The `infoBannerErrorColor` internal color.
    
    static let infoBannerErrorColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.906, green: 0.031, blue: 0.400, alpha: 1),
        darkVariant: UIColor(red: 0.906, green: 0.031, blue: 0.400, alpha: 1))

    /// The `infoBannerInfoColor` internal color.
    
    static let infoBannerInfoColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1),
        darkVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1))

    /// The `chipOnDarkPressedStrokeDay` internal color.
    
    static let chipOnDarkPressedStrokeDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `chipOnDarkPressedStrokeNight` internal color.
    
    static let chipOnDarkPressedStrokeNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `chipOnDarkOnBackgroundDay` internal color.
    
    static let chipOnDarkOnBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `chipOnDarkOnBackgroundNight` internal color.
    
    static let chipOnDarkOnBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `chipDisabledBackgroundDay` internal color.
    
    static let chipDisabledBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1))

    /// The `chipDisabledBackgroundNight` internal color.
    
    static let chipDisabledBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `chipOnDarkOnDismissIconDay` internal color.
    
    static let chipOnDarkOnDismissIconDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.329, green: 0.345, blue: 0.376, alpha: 1),
        darkVariant: UIColor(red: 0.329, green: 0.345, blue: 0.376, alpha: 1))

    /// The `chipOnDarkOnDismissIconNight` internal color.
    
    static let chipOnDarkOnDismissIconNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255))

    /// The `mapPreviousSelectionDay` internal color.
    
    static let mapPreviousSelectionDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.812, green: 0.894, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.812, green: 0.894, blue: 1.000, alpha: 1))

    /// The `mapClusterPinNight` internal color.
    
    static let mapClusterPinNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `mapClusterPinPreviousSelectionNight` internal color.
    
    static let mapClusterPinPreviousSelectionNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.580, green: 0.765, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.580, green: 0.765, blue: 1.000, alpha: 1))

    /// The `mapClusterPinDay` internal color.
    
    static let mapClusterPinDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1))

    /// The `mapClusterPinPreviousSelectionDay` internal color.
    
    static let mapClusterPinPreviousSelectionDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.580, green: 0.765, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.580, green: 0.765, blue: 1.000, alpha: 1))

    /// The `mapMarkerViewedForegroundNight` internal color.
    
    static let mapMarkerViewedForegroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.8),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.8))

    /// The `mapMarkerViewedForegroundDay` internal color.
    
    static let mapMarkerViewedForegroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.8),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.8))

    /// The `mapPoiPinNight` internal color.
    
    static let mapPoiPinNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.557, green: 0.278, blue: 0.729, alpha: 1),
        darkVariant: UIColor(red: 0.557, green: 0.278, blue: 0.729, alpha: 1))

    /// The `mapPreviousSelectionNight` internal color.
    
    static let mapPreviousSelectionNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.812, green: 0.894, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.812, green: 0.894, blue: 1.000, alpha: 1))

    /// The `mapPoiPinDay` internal color.
    
    static let mapPoiPinDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.557, green: 0.278, blue: 0.729, alpha: 1),
        darkVariant: UIColor(red: 0.557, green: 0.278, blue: 0.729, alpha: 1))

    /// The `buttonSecondaryPressedBackgroundNight` internal color.
    
    static let buttonSecondaryPressedBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1),
        darkVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1))

    /// The `buttonLinkNormalForegroundNight` internal color.
    
    static let buttonLinkNormalForegroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.518, green: 0.914, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.518, green: 0.914, blue: 1.000, alpha: 1))

    /// The `buttonLinkOnDarkDisabledForegroundNight` internal color.
    
    static let buttonLinkOnDarkDisabledForegroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonSecondaryNormalBackgroundNight` internal color.
    
    static let buttonSecondaryNormalBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonPrimaryOnLightPressedBackgroundDay` internal color.
    
    static let buttonPrimaryOnLightPressedBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1))

    /// The `buttonFeaturedNormalBackgroundDay` internal color.
    
    static let buttonFeaturedNormalBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1),
        darkVariant: UIColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1))

    /// The `buttonFeaturedPressedBackgroundNight` internal color.
    
    static let buttonFeaturedPressedBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnLightNormalBackgroundNight` internal color.
    
    static let buttonPrimaryOnLightNormalBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1))

    /// The `buttonSecondaryPressedBackgroundDay` internal color.
    
    static let buttonSecondaryPressedBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1),
        darkVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1))

    /// The `buttonLinkNormalForegroundDay` internal color.
    
    static let buttonLinkNormalForegroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1),
        darkVariant: UIColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1))

    /// The `buttonPrimaryOnLightDisabledForegroundNight` internal color.
    
    static let buttonPrimaryOnLightDisabledForegroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `buttonSecondaryOnDarkDisabledBackgroundNight` internal color.
    
    static let buttonSecondaryOnDarkDisabledBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonDestructiveNormalForegroundNight` internal color.
    
    static let buttonDestructiveNormalForegroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `buttonLinkOnDarkDisabledForegroundDay` internal color.
    
    static let buttonLinkOnDarkDisabledForegroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonSecondaryNormalBackgroundDay` internal color.
    
    static let buttonSecondaryNormalBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1))

    /// The `buttonPrimaryOnLightNormalBackgroundDay` internal color.
    
    static let buttonPrimaryOnLightNormalBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1))

    /// The `buttonPrimaryOnLightDisabledForegroundDay` internal color.
    
    static let buttonPrimaryOnLightDisabledForegroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `buttonPrimaryOnDarkNormalBackgroundNight` internal color.
    
    static let buttonPrimaryOnDarkNormalBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonFeaturedPressedBackgroundDay` internal color.
    
    static let buttonFeaturedPressedBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1),
        darkVariant: UIColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1))

    /// The `buttonPrimaryOnDarkDisabledForegroundNight` internal color.
    
    static let buttonPrimaryOnDarkDisabledForegroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `buttonSecondaryOnDarkDisabledBackgroundDay` internal color.
    
    static let buttonSecondaryOnDarkDisabledBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonSecondaryOnDarkPressedBackgroundNight` internal color.
    
    static let buttonSecondaryOnDarkPressedBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1),
        darkVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1))

    /// The `buttonDestructiveNormalForegroundDay` internal color.
    
    static let buttonDestructiveNormalForegroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.784, green: 0.016, blue: 0.337, alpha: 1),
        darkVariant: UIColor(red: 0.784, green: 0.016, blue: 0.337, alpha: 1))

    /// The `buttonPrimaryOnDarkNormalBackgroundDay` internal color.
    
    static let buttonPrimaryOnDarkNormalBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnDarkDisabledForegroundDay` internal color.
    
    static let buttonPrimaryOnDarkDisabledForegroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `buttonLinkPressedForegroundNight` internal color.
    
    static let buttonLinkPressedForegroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

    /// The `buttonSecondaryOnDarkPressedBackgroundDay` internal color.
    
    static let buttonSecondaryOnDarkPressedBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1),
        darkVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1))

    /// The `buttonPrimaryOnLightDisabledBackgroundNight` internal color.
    
    static let buttonPrimaryOnLightDisabledBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1))

    /// The `buttonLinkPressedForegroundDay` internal color.
    
    static let buttonLinkPressedForegroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1))

    /// The `buttonDestructiveNormalBackgroundNight` internal color.
    
    static let buttonDestructiveNormalBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonPrimaryNormalBackgroundNight` internal color.
    
    static let buttonPrimaryNormalBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `buttonDestructivePressedBackgroundNight` internal color.
    
    static let buttonDestructivePressedBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `buttonPrimaryPressedBackgroundNight` internal color.
    
    static let buttonPrimaryPressedBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.169, blue: 0.357, alpha: 1),
        darkVariant: UIColor(red: 0.000, green: 0.169, blue: 0.357, alpha: 1))

    /// The `buttonPrimaryOnLightDisabledBackgroundDay` internal color.
    
    static let buttonPrimaryOnLightDisabledBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1))

    /// The `buttonPrimaryOnDarkDisabledBackgroundNight` internal color.
    
    static let buttonPrimaryOnDarkDisabledBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1))

    /// The `buttonPrimaryNormalBackgroundDay` internal color.
    
    static let buttonPrimaryNormalBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1))

    /// The `buttonDestructiveNormalBackgroundDay` internal color.
    
    static let buttonDestructiveNormalBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1))

    /// The `buttonLinkOnDarkPressedForegroundNight` internal color.
    
    static let buttonLinkOnDarkPressedForegroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255))

    /// The `buttonDestructivePressedBackgroundDay` internal color.
    
    static let buttonDestructivePressedBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.784, green: 0.016, blue: 0.337, alpha: 1),
        darkVariant: UIColor(red: 0.784, green: 0.016, blue: 0.337, alpha: 1))

    /// The `buttonPrimaryPressedBackgroundDay` internal color.
    
    static let buttonPrimaryPressedBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1))

    /// The `buttonPrimaryOnDarkDisabledBackgroundDay` internal color.
    
    static let buttonPrimaryOnDarkDisabledBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1))

    /// The `buttonLinkOnDarkNormalForegroundNight` internal color.
    
    static let buttonLinkOnDarkNormalForegroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonDisabledBackgroundNight` internal color.
    
    static let buttonDisabledBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonSecondaryOnDarkNormalBackgroundNight` internal color.
    
    static let buttonSecondaryOnDarkNormalBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonSecondaryOnDarkDisabledForegroundNight` internal color.
    
    static let buttonSecondaryOnDarkDisabledForegroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonLinkOnDarkPressedForegroundDay` internal color.
    
    static let buttonLinkOnDarkPressedForegroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255))

    /// The `buttonPrimaryOnDarkPressedBackgroundNight` internal color.
    
    static let buttonPrimaryOnDarkPressedBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1),
        darkVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1))

    /// The `buttonLinkOnDarkNormalForegroundDay` internal color.
    
    static let buttonLinkOnDarkNormalForegroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonDisabledBackgroundDay` internal color.
    
    static let buttonDisabledBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1))

    /// The `buttonSecondaryOnDarkNormalBackgroundDay` internal color.
    
    static let buttonSecondaryOnDarkNormalBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonSecondaryOnDarkDisabledForegroundDay` internal color.
    
    static let buttonSecondaryOnDarkDisabledForegroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonPrimaryOnDarkPressedBackgroundDay` internal color.
    
    static let buttonPrimaryOnDarkPressedBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1),
        darkVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1))

    /// The `buttonPrimaryOnLightPressedBackgroundNight` internal color.
    
    static let buttonPrimaryOnLightPressedBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1))

    /// The `buttonFeaturedNormalBackgroundNight` internal color.
    
    static let buttonFeaturedNormalBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.518, green: 0.914, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.518, green: 0.914, blue: 1.000, alpha: 1))

    /// The `skeletonShimmerStartEndDay` internal color.
    
    static let skeletonShimmerStartEndDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0))

    /// The `skeletonShimmerStartEndNight` internal color.
    
    static let skeletonShimmerStartEndNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0))

    /// The `skeletonShimmerCenterDay` internal color.
    
    static let skeletonShimmerCenterDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.6),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.6))

    /// The `skeletonShimmerCenterNight` internal color.
    
    static let skeletonShimmerCenterNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `sponsoredBannerBackgroundDay` internal color.
    
    static let sponsoredBannerBackgroundDay = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.937, green: 0.945, blue: 0.949, alpha: 1),
        darkVariant: UIColor(red: 0.937, green: 0.945, blue: 0.949, alpha: 1))

    /// The `sponsoredBannerBackgroundNight` internal color.
    
    static let sponsoredBannerBackgroundNight = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `badgeBackgroundNormalColor` internal color.
    
    static let badgeBackgroundNormalColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.937, green: 0.945, blue: 0.949, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `chipOnDarkPressedStrokeColor` internal color.
    
    static let chipOnDarkPressedStrokeColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `chipOnDarkOnBackgroundColor` internal color.
    
    static let chipOnDarkOnBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `chipDisabledBackgroundColor` internal color.
    
    static let chipDisabledBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `chipOnDarkOnDismissIconColor` internal color.
    
    static let chipOnDarkOnDismissIconColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.329, green: 0.345, blue: 0.376, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255))

    /// The `mapPreviousSelectionColor` internal color.
    
    static let mapPreviousSelectionColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.812, green: 0.894, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.812, green: 0.894, blue: 1.000, alpha: 1))

    /// The `mapClusterPinColor` internal color.
    
    static let mapClusterPinColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `mapClusterPinPreviousSelectionColor` internal color.
    
    static let mapClusterPinPreviousSelectionColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.580, green: 0.765, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.580, green: 0.765, blue: 1.000, alpha: 1))

    /// The `mapMarkerViewedForegroundColor` internal color.
    
    static let mapMarkerViewedForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.8),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.8))

    /// The `mapPoiPinColor` internal color.
    
    static let mapPoiPinColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.557, green: 0.278, blue: 0.729, alpha: 1),
        darkVariant: UIColor(red: 0.557, green: 0.278, blue: 0.729, alpha: 1))

    /// The `buttonSecondaryPressedBackgroundColor` internal color.
    
    static let buttonSecondaryPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1),
        darkVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1))

    /// The `buttonLinkNormalForegroundColor` internal color.
    
    static let buttonLinkNormalForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1),
        darkVariant: UIColor(red: 0.518, green: 0.914, blue: 1.000, alpha: 1))

    /// The `buttonLinkOnDarkDisabledForegroundColor` internal color.
    
    static let buttonLinkOnDarkDisabledForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonSecondaryNormalBackgroundColor` internal color.
    
    static let buttonSecondaryNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonPrimaryOnLightPressedBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1))

    /// The `buttonFeaturedNormalBackgroundColor` internal color.
    
    static let buttonFeaturedNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1),
        darkVariant: UIColor(red: 0.518, green: 0.914, blue: 1.000, alpha: 1))

    /// The `buttonFeaturedPressedBackgroundColor` internal color.
    
    static let buttonFeaturedPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.008, green: 0.302, blue: 0.686, alpha: 1),
        darkVariant: UIColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnLightNormalBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1))

    /// The `buttonPrimaryOnLightDisabledForegroundColor` internal color.
    
    static let buttonPrimaryOnLightDisabledForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `buttonSecondaryOnDarkDisabledBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkDisabledBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonDestructiveNormalForegroundColor` internal color.
    
    static let buttonDestructiveNormalForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.784, green: 0.016, blue: 0.337, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `buttonPrimaryOnDarkNormalBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnDarkDisabledForegroundColor` internal color.
    
    static let buttonPrimaryOnDarkDisabledForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `buttonSecondaryOnDarkPressedBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1),
        darkVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1))

    /// The `buttonLinkPressedForegroundColor` internal color.
    
    static let buttonLinkPressedForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnLightDisabledBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightDisabledBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1))

    /// The `buttonDestructiveNormalBackgroundColor` internal color.
    
    static let buttonDestructiveNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonPrimaryNormalBackgroundColor` internal color.
    
    static let buttonPrimaryNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `buttonDestructivePressedBackgroundColor` internal color.
    
    static let buttonDestructivePressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.784, green: 0.016, blue: 0.337, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `buttonPrimaryPressedBackgroundColor` internal color.
    
    static let buttonPrimaryPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.000, green: 0.169, blue: 0.357, alpha: 1))

    /// The `buttonPrimaryOnDarkDisabledBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkDisabledBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1))

    /// The `buttonLinkOnDarkPressedForegroundColor` internal color.
    
    static let buttonLinkOnDarkPressedForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255))

    /// The `buttonLinkOnDarkNormalForegroundColor` internal color.
    
    static let buttonLinkOnDarkNormalForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonDisabledBackgroundColor` internal color.
    
    static let buttonDisabledBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.878, green: 0.890, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `buttonSecondaryOnDarkNormalBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonSecondaryOnDarkDisabledForegroundColor` internal color.
    
    static let buttonSecondaryOnDarkDisabledForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `buttonPrimaryOnDarkPressedBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1),
        darkVariant: UIColor(red: 0.761, green: 0.788, blue: 0.804, alpha: 1))

    /// The `skeletonShimmerStartEndColor` internal color.
    
    static let skeletonShimmerStartEndColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0))

    /// The `skeletonShimmerCenterColor` internal color.
    
    static let skeletonShimmerCenterColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.6),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `sponsoredBannerBackgroundColor` internal color.
    
    static let sponsoredBannerBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.937, green: 0.945, blue: 0.949, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))
}
