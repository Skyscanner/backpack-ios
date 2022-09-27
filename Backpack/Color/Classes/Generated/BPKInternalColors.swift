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

    /// The `chipOnDarkNormalBackgroundColor` internal color.
    
    static let chipOnDarkNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `chipOnDarkPressedBackgroundColor` internal color.
    
    static let chipOnDarkPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.776, green: 0.800, blue: 0.831, alpha: 1),
        darkVariant: UIColor(red: 0.000, green: 0.157, blue: 0.329, alpha: 1))

    /// The `chipOnDarkOnBackgroundColor` internal color.
    
    static let chipOnDarkOnBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `chipDefaultNormalBackgroundColor` internal color.
    
    static let chipDefaultNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.867, green: 0.867, blue: 0.898, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.071, blue: 0.114, alpha: 1))

    /// The `chipDefaultOnBackgroundColor` internal color.
    
    static let chipDefaultOnBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.020, green: 0.125, blue: 0.235, alpha: 1),
        darkVariant: UIColor(red: 0.020, green: 0.255, blue: 0.518, alpha: 1))

    /// The `chipDisabledBackgroundColor` internal color.
    
    static let chipDisabledBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.867, green: 0.882, blue: 0.894, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.067, blue: 0.102, alpha: 1))

    /// The `chipDefaultPressedBackgroundColor` internal color.
    
    static let chipDefaultPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.776, green: 0.800, blue: 0.831, alpha: 1),
        darkVariant: UIColor(red: 0.000, green: 0.157, blue: 0.329, alpha: 1))

    /// The `buttonSecondaryPressedBackgroundColor` internal color.
    
    static let buttonSecondaryPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.776, green: 0.800, blue: 0.831, alpha: 1),
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

    /// The `buttonDestructiveNormalForegroundColor` internal color.
    
    static let buttonDestructiveNormalForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.847, green: 0.031, blue: 0.373, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `buttonSecondaryOnDisabledBackgroundColor` internal color.
    
    static let buttonSecondaryOnDisabledBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.043, green: 0.067, blue: 0.102, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.067, blue: 0.102, alpha: 1))

    /// The `buttonPrimaryOnDarkNormalBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonSecondaryOnDarkPressedBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1),
        darkVariant: UIColor(red: 0.004, green: 0.035, blue: 0.075, alpha: 1))

    /// The `buttonPrimaryOnDisabledForegroundColor` internal color.
    
    static let buttonPrimaryOnDisabledForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))

    /// The `buttonLinkPressedForegroundColor` internal color.
    
    static let buttonLinkPressedForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.820, green: 0.969, blue: 1.000, alpha: 1))

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
        withLightVariant: UIColor(red: 0.906, green: 0.031, blue: 0.400, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 0.392, blue: 0.612, alpha: 1))

    /// The `buttonPrimaryPressedBackgroundColor` internal color.
    
    static let buttonPrimaryPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1),
        darkVariant: UIColor(red: 0.082, green: 0.275, blue: 0.475, alpha: 1))

    /// The `buttonLinkOnDarkPressedForegroundColor` internal color.
    
    static let buttonLinkOnDarkPressedForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.5019607843137255))

    /// The `buttonLinkOnDarkNormalForegroundColor` internal color.
    
    static let buttonLinkOnDarkNormalForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1))

    /// The `buttonPrimaryOnDisabledBackgroundColor` internal color.
    
    static let buttonPrimaryOnDisabledBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.867, green: 0.882, blue: 0.894, alpha: 1),
        darkVariant: UIColor(red: 0.867, green: 0.882, blue: 0.894, alpha: 1))

    /// The `buttonDisabledBackgroundColor` internal color.
    
    static let buttonDisabledBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.867, green: 0.882, blue: 0.894, alpha: 1),
        darkVariant: UIColor(red: 0.043, green: 0.067, blue: 0.102, alpha: 1))

    /// The `buttonSecondaryOnDarkNormalBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkNormalBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1),
        darkVariant: UIColor(red: 0.141, green: 0.200, blue: 0.275, alpha: 1))

    /// The `buttonPrimaryOnDarkPressedBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkPressedBackgroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 0.796, green: 0.808, blue: 0.824, alpha: 1),
        darkVariant: UIColor(red: 0.796, green: 0.808, blue: 0.824, alpha: 1))

    /// The `buttonSecondaryOnDisabledForegroundColor` internal color.
    
    static let buttonSecondaryOnDisabledForegroundColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2),
        darkVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.2))

    /// The `skeletonShimmerStartEndColor` internal color.
    
    static let skeletonShimmerStartEndColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0))

    /// The `skeletonShimmerCenterColor` internal color.
    
    static let skeletonShimmerCenterColor = BPKColor.dynamicColor(
        withLightVariant: UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.6),
        darkVariant: UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2))
}
