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
        .darkVariant(BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1))

    /// The `chipOnDarkPressedBackgroundColor` internal color.
    
    static let chipOnDarkPressedBackgroundColor = BPKColor(red:0.761, green:0.788, blue:0.804, alpha:1)
        .darkVariant(BPKColor(red:0.000, green:0.169, blue:0.357, alpha:1))

    /// The `chipOnDarkOnBackgroundColor` internal color.
    
    static let chipOnDarkOnBackgroundColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:0.020, green:0.255, blue:0.518, alpha:1))

    /// The `chipDefaultNormalBackgroundColor` internal color.
    
    static let chipDefaultNormalBackgroundColor = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)
        .darkVariant(BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1))

    /// The `chipDefaultOnBackgroundColor` internal color.
    
    static let chipDefaultOnBackgroundColor = BPKColor(red:0.020, green:0.125, blue:0.235, alpha:1)
        .darkVariant(BPKColor(red:0.020, green:0.255, blue:0.518, alpha:1))

    /// The `chipDisabledBackgroundColor` internal color.
    
    static let chipDisabledBackgroundColor = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)
        .darkVariant(BPKColor(red:0.043, green:0.071, blue:0.114, alpha:1))

    /// The `chipDefaultPressedBackgroundColor` internal color.
    
    static let chipDefaultPressedBackgroundColor = BPKColor(red:0.761, green:0.788, blue:0.804, alpha:1)
        .darkVariant(BPKColor(red:0.000, green:0.169, blue:0.357, alpha:1))

    /// The `buttonSecondaryPressedBackgroundColor` internal color.
    
    static let buttonSecondaryPressedBackgroundColor = BPKColor(red:0.761, green:0.788, blue:0.804, alpha:1)
        .darkVariant(BPKColor(red:0.004, green:0.035, blue:0.075, alpha:1))

    /// The `buttonLinkNormalForegroundColor` internal color.
    
    static let buttonLinkNormalForegroundColor = BPKColor(red:0.000, green:0.384, blue:0.890, alpha:1)
        .darkVariant(BPKColor(red:0.518, green:0.914, blue:1.000, alpha:1))

    /// The `buttonLinkOnDarkDisabledForegroundColor` internal color.
    
    static let buttonLinkOnDarkDisabledForegroundColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.2)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.2))

    /// The `buttonSecondaryNormalBackgroundColor` internal color.
    
    static let buttonSecondaryNormalBackgroundColor = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)
        .darkVariant(BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1))

    /// The `buttonPrimaryOnLightPressedBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightPressedBackgroundColor = BPKColor(red:0.082, green:0.275, blue:0.475, alpha:1)
        .darkVariant(BPKColor(red:0.082, green:0.275, blue:0.475, alpha:1))

    /// The `buttonFeaturedNormalBackgroundColor` internal color.
    
    static let buttonFeaturedNormalBackgroundColor = BPKColor(red:0.000, green:0.384, blue:0.890, alpha:1)
        .darkVariant(BPKColor(red:0.518, green:0.914, blue:1.000, alpha:1))

    /// The `buttonFeaturedPressedBackgroundColor` internal color.
    
    static let buttonFeaturedPressedBackgroundColor = BPKColor(red:0.008, green:0.302, blue:0.686, alpha:1)
        .darkVariant(BPKColor(red:0.820, green:0.969, blue:1.000, alpha:1))

    /// The `buttonPrimaryOnLightNormalBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightNormalBackgroundColor = BPKColor(red:0.020, green:0.125, blue:0.235, alpha:1)
        .darkVariant(BPKColor(red:0.020, green:0.125, blue:0.235, alpha:1))

    /// The `buttonPrimaryOnLightDisabledForegroundColor` internal color.
    
    static let buttonPrimaryOnLightDisabledForegroundColor = BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0.2)
        .darkVariant(BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0.2))

    /// The `buttonSecondaryOnDarkDisabledBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkDisabledBackgroundColor = BPKColor(red:0.043, green:0.071, blue:0.114, alpha:1)
        .darkVariant(BPKColor(red:0.043, green:0.071, blue:0.114, alpha:1))

    /// The `buttonDestructiveNormalForegroundColor` internal color.
    
    static let buttonDestructiveNormalForegroundColor = BPKColor(red:0.784, green:0.016, blue:0.337, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:0.392, blue:0.612, alpha:1))

    /// The `buttonPrimaryOnDarkNormalBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkNormalBackgroundColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1))

    /// The `buttonPrimaryOnDarkDisabledForegroundColor` internal color.
    
    static let buttonPrimaryOnDarkDisabledForegroundColor = BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0.2)
        .darkVariant(BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0.2))

    /// The `buttonSecondaryOnDarkPressedBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkPressedBackgroundColor = BPKColor(red:0.004, green:0.035, blue:0.075, alpha:1)
        .darkVariant(BPKColor(red:0.004, green:0.035, blue:0.075, alpha:1))

    /// The `buttonLinkPressedForegroundColor` internal color.
    
    static let buttonLinkPressedForegroundColor = BPKColor(red:0.082, green:0.275, blue:0.475, alpha:1)
        .darkVariant(BPKColor(red:0.820, green:0.969, blue:1.000, alpha:1))

    /// The `buttonPrimaryOnLightDisabledBackgroundColor` internal color.
    
    static let buttonPrimaryOnLightDisabledBackgroundColor = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)
        .darkVariant(BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1))

    /// The `buttonDestructiveNormalBackgroundColor` internal color.
    
    static let buttonDestructiveNormalBackgroundColor = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)
        .darkVariant(BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1))

    /// The `buttonPrimaryNormalBackgroundColor` internal color.
    
    static let buttonPrimaryNormalBackgroundColor = BPKColor(red:0.020, green:0.125, blue:0.235, alpha:1)
        .darkVariant(BPKColor(red:0.020, green:0.255, blue:0.518, alpha:1))

    /// The `buttonDestructivePressedBackgroundColor` internal color.
    
    static let buttonDestructivePressedBackgroundColor = BPKColor(red:0.784, green:0.016, blue:0.337, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:0.392, blue:0.612, alpha:1))

    /// The `buttonPrimaryPressedBackgroundColor` internal color.
    
    static let buttonPrimaryPressedBackgroundColor = BPKColor(red:0.082, green:0.275, blue:0.475, alpha:1)
        .darkVariant(BPKColor(red:0.000, green:0.169, blue:0.357, alpha:1))

    /// The `buttonPrimaryOnDarkDisabledBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkDisabledBackgroundColor = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)
        .darkVariant(BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1))

    /// The `buttonLinkOnDarkPressedForegroundColor` internal color.
    
    static let buttonLinkOnDarkPressedForegroundColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.5019607843137255)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.5019607843137255))

    /// The `buttonLinkOnDarkNormalForegroundColor` internal color.
    
    static let buttonLinkOnDarkNormalForegroundColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:1))

    /// The `buttonDisabledBackgroundColor` internal color.
    
    static let buttonDisabledBackgroundColor = BPKColor(red:0.878, green:0.890, blue:0.898, alpha:1)
        .darkVariant(BPKColor(red:0.043, green:0.071, blue:0.114, alpha:1))

    /// The `buttonSecondaryOnDarkNormalBackgroundColor` internal color.
    
    static let buttonSecondaryOnDarkNormalBackgroundColor = BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1)
        .darkVariant(BPKColor(red:0.141, green:0.200, blue:0.275, alpha:1))

    /// The `buttonSecondaryOnDarkDisabledForegroundColor` internal color.
    
    static let buttonSecondaryOnDarkDisabledForegroundColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.2)
        .darkVariant(BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.2))

    /// The `buttonPrimaryOnDarkPressedBackgroundColor` internal color.
    
    static let buttonPrimaryOnDarkPressedBackgroundColor = BPKColor(red:0.761, green:0.788, blue:0.804, alpha:1)
        .darkVariant(BPKColor(red:0.761, green:0.788, blue:0.804, alpha:1))

    /// The `skeletonShimmerStartEndColor` internal color.
    
    static let skeletonShimmerStartEndColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0)
        .darkVariant(BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0))

    /// The `skeletonShimmerCenterColor` internal color.
    
    static let skeletonShimmerCenterColor = BPKColor(red:1.000, green:1.000, blue:1.000, alpha:0.6)
        .darkVariant(BPKColor(red:0.000, green:0.000, blue:0.000, alpha:0.2))
}
