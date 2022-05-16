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
    
    var regular = BPKButtonColors(background: .monteverde, foreground: .textPrimary)
    var highlighted = BPKButtonColors(background: pressedMonteverde, foreground: .textPrimary)
    var disabled = BPKButtonColors.dynamicDisabled
    var loading = BPKButtonColors.dynamicDisabled
    
    init() {}
}

struct SecondaryBPKButtonColorSet: BPKButtonColorSet {
    private static let textSecondary = BPKColor.skyBlueShade01.darkVariant(.skyBlueTint01)
    
    var regular = BPKButtonColors(background: .backgroundSecondary, foreground: textSecondary)
    var highlighted = BPKButtonColors(background: .skyGrayTint05.darkVariant(.blackTint01), foreground: textSecondary)
    var disabled = BPKButtonColors.dynamicDisabled
    var loading = BPKButtonColors.dynamicDisabled
    
    init() {}
}

struct SecondaryOnDarkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .white.withAlphaComponent(0.1), foreground: .white)
    var highlighted = BPKButtonColors(background: .white.withAlphaComponent(0.15), foreground: .white)
    var disabled = BPKButtonColors.staticDisabled
    var loading = BPKButtonColors.staticDisabled
    
    init() {}
}

struct DestructiveBPKButtonColorSet: BPKButtonColorSet {
    private static let destructiveLight = BPKColor(value: UIColor(red: 0.699, green: 0.182, blue: 0.269, alpha: 1))
    private static let destructiveDark = BPKColor(value: UIColor(red: 0.972, green: 0.361, blue: 0.465, alpha: 1))
    private static let destructiveColor = destructiveLight.darkVariant(destructiveDark)
    
    var regular = BPKButtonColors(background: .backgroundSecondary, foreground: destructiveColor)
    var highlighted = BPKButtonColors(background: destructiveColor, foreground: .textPrimary)
    var disabled = BPKButtonColors.dynamicDisabled
    var loading = BPKButtonColors.dynamicDisabled
    
    init() {}
}

struct FeaturedBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .primaryColor, foreground: .textPrimary)
    var highlighted = BPKButtonColors(background: .skyBlueShade01, foreground: .textPrimary)
    var disabled = BPKButtonColors.dynamicDisabled
    var loading = BPKButtonColors.dynamicDisabled
    
    init() {}
}

struct LinkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors.clear(withForeground: .primaryColor)
    var highlighted = BPKButtonColors.clear(withForeground: .skyBlueShade01.darkVariant(.skyBlue))
    var disabled = BPKButtonColors.clearDisabled
    var loading = BPKButtonColors.clearDisabled
    
    init() {}
}

struct LinkOnDarkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors.clear(withForeground: .white)
    var highlighted = BPKButtonColors.clear(withForeground: .white.withAlphaComponent(0.6))
    var disabled = BPKButtonColors.clearDisabled
    var loading = BPKButtonColors.clearDisabled
    
    init() {}
}

struct PrimaryOnDarkBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .white, foreground: .skyGray)
    var highlighted = BPKButtonColors(background: .skyGrayTint05, foreground: .skyGray)
    var disabled = BPKButtonColors.staticDisabled
    var loading = BPKButtonColors.staticDisabled
    
    init() {}
}

struct PrimaryOnLightBPKButtonColorSet: BPKButtonColorSet {
    var regular = BPKButtonColors(background: .skyGray, foreground: .white)
    var highlighted = BPKButtonColors(background: .skyGrayTint01, foreground: .white)
    var disabled = BPKButtonColors.staticDisabled
    var loading = BPKButtonColors.staticDisabled
    
    init() {}
}

private extension BPKColor {
    static let textPrimary = BPKColor.white.darkVariant(.black)
    static let backgroundSecondary = BPKColor.skyGrayTint06.darkVariant(.blackTint02)
}
