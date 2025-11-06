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

// swiftlint:disable indentation_width
import UIKit
import Backpack_Common
#if SWIFT_PACKAGE
import BackpackTokens
#endif

protocol BPKButtonColorSet {
    var regular: BPKButtonColors { get }
    var highlighted: BPKButtonColors { get }
    var disabled: BPKButtonColors { get }
    var loading: BPKButtonColors { get }
}

extension BPKButtonColorSet {
    var loading: BPKButtonColors {
        highlighted
    }
}

struct PrimaryBPKButtonColorSet: BPKButtonColorSet {
    private static let pressedMonteverde = BPKColor(value: UIColor(red: 0, green: 0.416, blue: 0.38, alpha: 1))
    
    var regular = BPKButtonColors(background: .buttonPrimaryNormalBackgroundColor, foreground: .textOnDarkColor)
    var highlighted = BPKButtonColors(background: .buttonPrimaryPressedBackgroundColor, foreground: .textOnDarkColor)
    var disabled = BPKButtonColors.buttonDisabled
    
    init() {}
}

struct SecondaryBPKButtonColorSet: BPKButtonColorSet {
    var config: BpkConfiguration?
    var regular = BPKButtonColors(background: .buttonSecondaryNormalBackgroundColor, foreground: .textPrimaryColor)
    var highlighted = BPKButtonColors(background: .buttonSecondaryPressedBackgroundColor, foreground: .textPrimaryColor)
    var disabled = BPKButtonColors.buttonDisabled
    
    init(config: BpkConfiguration?) {
        self.config = config
        
        if let backgroundColour = config?.buttonConfig?.secondaryButtonBackgroundColour,
            let foregroundColour = config?.buttonConfig?.secondaryButtonForegroundColour {
            regular = BPKButtonColors(background: BPKColor(value: backgroundColour),
                                      foreground: BPKColor(value: foregroundColour))
        }
        
        if let backgroundColourPressed = config?.buttonConfig?.secondaryButtonPressedBackgroundColour,
           let foregroundColour = config?.buttonConfig?.secondaryButtonForegroundColour {
            highlighted = BPKButtonColors(background: BPKColor(value: backgroundColourPressed),
                                          foreground: BPKColor(value: foregroundColour))
        }
    }
}

struct SecondaryOnDarkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .buttonSecondaryOnDarkNormalBackgroundColor, foreground: .textOnDarkColor)
    var highlighted = BPKButtonColors(
        background: .buttonSecondaryOnDarkPressedBackgroundColor,
        foreground: .textOnDarkColor)
    var disabled = BPKButtonColors(
        background: .buttonSecondaryOnDarkDisabledBackgroundColor,
        foreground: .buttonSecondaryOnDarkDisabledForegroundColor)
    
    init() {}
}

struct SecondaryOnContrastBPKButtonColorSet: BPKButtonColorSet {

    var regular: BPKButtonColors
    var highlighted: BPKButtonColors
    var disabled = BPKButtonColors.buttonDisabled
    
    init() {
        let regularLight = UIColor(red: 207/255, green: 228/255, blue: 255/255, alpha: 1)
        let regularDark = UIColor(red: 36/255, green: 51/255, blue: 70/255, alpha: 1)
        let regularColour = UIColor.dynamicColorTest(light: regularLight, dark: regularDark)

        let secondaryForegroundLight = UIColor(red: 2/255, green: 77/255, blue: 175/255, alpha: 1.0)
        let secondaryForegroundDark = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        let buttonForegroundColour = UIColor.dynamicColorTest(light: secondaryForegroundLight,
                                                              dark: secondaryForegroundDark)
        
        let highlightedLight = UIColor(red: 180/255, green: 215/255, blue: 255/255, alpha: 1)
        let highlightedDark = UIColor(red: 60/255, green: 80/255, blue: 95/255, alpha: 1)
        let highlightedColour = UIColor.dynamicColorTest(light: highlightedLight,
                                                         dark: highlightedDark)
        
        regular = BPKButtonColors(background: BPKColor(value: regularColour),
                                  foreground: BPKColor(value: buttonForegroundColour))
        highlighted = BPKButtonColors(background: BPKColor(value: highlightedColour),
                                      foreground: BPKColor(value: buttonForegroundColour))
    }
}

struct DestructiveBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(
        background: .buttonDestructiveNormalBackgroundColor,
        foreground: .buttonDestructiveNormalForegroundColor)
    var highlighted = BPKButtonColors(
        background: .buttonDestructivePressedBackgroundColor,
        foreground: .textPrimaryInverseColor)
    var disabled = BPKButtonColors.buttonDisabled
    
    init() {}
}

struct FeaturedBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(
        background: .buttonFeaturedNormalBackgroundColor,
        foreground: .textPrimaryInverseColor)
    var highlighted = BPKButtonColors(
        background: .buttonFeaturedPressedBackgroundColor,
        foreground: .textPrimaryInverseColor)
    var disabled = BPKButtonColors.buttonDisabled
    
    init() {}
}

struct LinkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors.clear(withForeground: .buttonLinkNormalForegroundColor)
    var highlighted = BPKButtonColors.clear(withForeground: .buttonLinkPressedForegroundColor)
    var disabled = BPKButtonColors(background: .clear, foreground: .textDisabledColor)
    
    init() {}
}

struct LinkOnDarkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors.clear(withForeground: .buttonLinkOnDarkNormalForegroundColor)
    var highlighted = BPKButtonColors.clear(withForeground: .buttonLinkOnDarkPressedForegroundColor)
    var disabled = BPKButtonColors.clear(withForeground: .buttonLinkOnDarkDisabledForegroundColor)
    
    init() {}
}

struct PrimaryOnDarkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .buttonPrimaryOnDarkNormalBackgroundColor, foreground: .textOnLightColor)
    var highlighted = BPKButtonColors(
        background: .buttonPrimaryOnDarkPressedBackgroundColor,
        foreground: .textOnLightColor)
    var disabled = BPKButtonColors(
        background: .buttonPrimaryOnDarkDisabledBackgroundColor,
        foreground: .buttonPrimaryOnDarkDisabledForegroundColor
    )
    
    init() {}
}

struct PrimaryOnLightBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .buttonPrimaryOnLightNormalBackgroundColor, foreground: .textOnDarkColor)
    var highlighted = BPKButtonColors(
        background: .buttonPrimaryOnLightPressedBackgroundColor,
        foreground: .textOnDarkColor)
    var disabled = BPKButtonColors(
        background: .buttonPrimaryOnLightDisabledBackgroundColor,
        foreground: .buttonPrimaryOnLightDisabledForegroundColor
    )
    
    init() {}
}
