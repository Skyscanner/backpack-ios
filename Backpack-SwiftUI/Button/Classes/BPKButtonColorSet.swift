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
import Backpack_Common

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
    var regular = BPKButtonColors(background: .surfaceSubtleColor, foreground: .buttonSecondaryForegroundColor)
    var highlighted = BPKButtonColors(background: .buttonSecondaryPressedBackgroundColor, foreground: .buttonSecondaryForegroundColor)
    var disabled = BPKButtonColors.buttonDisabled
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
    var regular = BPKButtonColors(background: .buttonSecondaryOnContrastBackgroundColor, foreground: .buttonSecondaryForegroundColor)
    var highlighted = BPKButtonColors(background: .buttonSecondaryPressedBackgroundColor, foreground: .buttonSecondaryForegroundColor)
    var disabled = BPKButtonColors.buttonDisabled
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
    var regular = BPKButtonColors.clear(withForeground: .textPrimaryColor)
    var highlighted = BPKButtonColors.clear(withForeground: .textPrimaryColor)
    var disabled = BPKButtonColors(background: .clear, foreground: .textDisabledColor)
    
    init() {}
}

struct LinkOnDarkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors.clear(withForeground: .textOnDarkColor)
    var highlighted = BPKButtonColors.clear(withForeground: .textOnDarkColor)
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
