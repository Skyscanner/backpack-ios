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

protocol BPKButtonColorSet {
    var regular: BPKButtonColors { get }
    var highlighted: BPKButtonColors { get }
    var disabled: BPKButtonColors { get }
    var loading: BPKButtonColors { get }
}

struct PrimaryBPKButtonColorSet: BPKButtonColorSet {
    private static let pressedMonteverde = BPKColor(value: UIColor(red: 0, green: 0.416, blue: 0.38, alpha: 1))
    
    var regular = BPKButtonColors(background: .buttonPrimaryNormalBackgroundColor, foreground: .textOnDarkColor)
    var highlighted = BPKButtonColors(background: .buttonPrimaryPressedBackgroundColor, foreground: .textOnDarkColor)
    var disabled = BPKButtonColors(background: .buttonDisabledBackgroundColor, foreground: .textDisabledColor)
    var loading = BPKButtonColors(background: .buttonPrimaryPressedBackgroundColor, foreground: .textOnDarkColor)
    
    init() {}
}

struct SecondaryBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .buttonSecondaryNormalBackgroundColor, foreground: .textPrimaryColor)
    var highlighted = BPKButtonColors(background: .buttonSecondaryPressedBackgroundColor, foreground: .textPrimaryColor)
    var disabled = BPKButtonColors(background: .buttonDisabledBackgroundColor, foreground: .textDisabledColor)
    var loading = BPKButtonColors(background: .buttonSecondaryPressedBackgroundColor, foreground: .textPrimaryColor)
    
    init() {}
}

struct SecondaryOnDarkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .buttonSecondaryOnDarkNormalBackgroundColor, foreground: .textOnDarkColor)
    var highlighted = BPKButtonColors(background: .buttonSecondaryOnDarkPressedBackgroundColor, foreground: .textOnDarkColor)
    var disabled = BPKButtonColors(
        background: .buttonSecondaryOnDisabledBackgroundColor,
        foreground: .buttonSecondaryOnDisabledForegroundColor)
    var loading = BPKButtonColors(background: .buttonSecondaryOnDarkPressedBackgroundColor, foreground: .textOnDarkColor)
    
    init() {}
}

struct DestructiveBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .buttonDestructiveNormalBackgroundColor, foreground: .buttonDestructiveNormalForegroundColor)
    var highlighted = BPKButtonColors(background: .buttonDestructivePressedBackgroundColor, foreground: .textPrimaryInverseColor)
    var disabled = BPKButtonColors(background: .buttonDisabledBackgroundColor, foreground: .textDisabledColor)
    var loading = BPKButtonColors(background: .buttonDestructivePressedBackgroundColor, foreground: .textPrimaryInverseColor)
    
    init() {}
}

struct FeaturedBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .buttonFeaturedNormalBackgroundColor, foreground: .textPrimaryInverseColor)
    var highlighted = BPKButtonColors(background: .buttonFeaturedPressedBackgroundColor, foreground: .textPrimaryInverseColor)
    var disabled = BPKButtonColors(background: .buttonDisabledBackgroundColor, foreground: .textDisabledColor)
    var loading = BPKButtonColors(background: .buttonFeaturedPressedBackgroundColor, foreground: .textPrimaryInverseColor)
    
    init() {}
}

struct LinkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors.clear(withForeground: .buttonLinkNormalForegroundColor)
    var highlighted = BPKButtonColors.clear(withForeground: .buttonLinkPressedForegroundColor)
    var disabled = BPKButtonColors(background: .clear, foreground: .textDisabledColor)
    var loading = BPKButtonColors.clear(withForeground: .buttonLinkPressedForegroundColor)
    
    init() {}
}

struct LinkOnDarkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors.clear(withForeground: .buttonLinkOnDarkNormalForegroundColor)
    var highlighted = BPKButtonColors.clear(withForeground: .buttonLinkOnDarkPressedForegroundColor)
    var disabled = BPKButtonColors.clear(withForeground: .buttonLinkOnDarkDisabledForegroundColor)
    var loading = BPKButtonColors.clear(withForeground: .buttonLinkOnDarkPressedForegroundColor)
    
    init() {}
}

struct PrimaryOnDarkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .buttonPrimaryOnDarkNormalBackgroundColor, foreground: .textOnLightColor)
    var highlighted = BPKButtonColors(background: .buttonPrimaryOnDarkPressedBackgroundColor, foreground: .textOnLightColor)
    var disabled = BPKButtonColors(background: .buttonPrimaryOnDisabledBackgroundColor, foreground: .buttonPrimaryOnDisabledForegroundColor)
    var loading = BPKButtonColors(background: .buttonPrimaryOnDarkPressedBackgroundColor, foreground: .textOnLightColor)
    
    init() {}
}

struct PrimaryOnLightBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .buttonPrimaryOnLightNormalBackgroundColor, foreground: .textOnDarkColor)
    var highlighted = BPKButtonColors(background: .buttonPrimaryOnLightPressedBackgroundColor, foreground: .textOnDarkColor)
    var disabled = BPKButtonColors(background: .buttonPrimaryOnDisabledBackgroundColor, foreground: .buttonPrimaryOnDisabledForegroundColor)
    var loading = BPKButtonColors(background: .buttonPrimaryOnLightPressedBackgroundColor, foreground: .textOnLightColor)
    
    init() {}
}
