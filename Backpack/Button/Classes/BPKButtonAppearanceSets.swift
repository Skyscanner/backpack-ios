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

import Foundation

@objcMembers
@IBDesignable
public class BPKButtonAppearanceSets: NSObject {
        
    private static var disabledAppearance = BPKButtonAppearance.with(
        background: BPKColor.buttonDisabledBackgroundColor,
        foreground: BPKColor.textDisabledColor
    )
    
    public static var primary = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: BPKColor.buttonPrimaryNormalBackgroundColor,
            foreground: BPKColor.textOnDarkColor),
        loading: .with(
            background: BPKColor.buttonPrimaryPressedBackgroundColor,
            foreground: BPKColor.textOnDarkColor),
        disabledAppearance: disabledAppearance,
        highlightedAppearance: .with(
            background: BPKColor.buttonPrimaryPressedBackgroundColor,
            foreground: BPKColor.textOnDarkColor
        )
    )
    
    public static var secondary = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: BPKColor.buttonSecondaryNormalBackgroundColor,
            foreground: BPKColor.textPrimaryColor),
        loading: .with(
            background: BPKColor.buttonSecondaryPressedBackgroundColor,
            foreground: BPKColor.textPrimaryColor),
        disabledAppearance: disabledAppearance,
        highlightedAppearance: .with(
            background: BPKColor.buttonSecondaryPressedBackgroundColor,
            foreground: BPKColor.textPrimaryColor
        )
    )
    
    public static var featured = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: BPKColor.buttonFeaturedNormalBackgroundColor,
            foreground: BPKColor.textPrimaryInverseColor),
        loading: .with(
            background: BPKColor.buttonFeaturedPressedBackgroundColor,
            foreground: BPKColor.textPrimaryInverseColor),
        disabledAppearance: disabledAppearance,
        highlightedAppearance: .with(
            background: BPKColor.buttonFeaturedPressedBackgroundColor,
            foreground: BPKColor.textPrimaryInverseColor
        )
    )
    
    public static var destructive = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: BPKColor.buttonDestructiveNormalBackgroundColor,
            foreground: BPKColor.buttonDestructiveNormalForegroundColor),
        loading: .with(
            background: BPKColor.buttonDestructivePressedBackgroundColor,
            foreground: BPKColor.textPrimaryInverseColor),
        disabledAppearance: disabledAppearance,
        highlightedAppearance: .with(
            background: BPKColor.buttonDestructivePressedBackgroundColor,
            foreground: BPKColor.textPrimaryInverseColor
        )
    )
    
    public static var link = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: BPKColor.clear,
            foreground: BPKColor.buttonLinkNormalForegroundColor),
        loading: .with(
            background: BPKColor.clear,
            foreground: BPKColor.buttonLinkPressedForegroundColor),
        disabledAppearance: .with(
            background: BPKColor.clear.withAlphaComponent(0),
            foreground: BPKColor.textDisabledColor
        ),
        highlightedAppearance: .with(
            background: BPKColor.clear,
            foreground: BPKColor.buttonLinkPressedForegroundColor
        )
    )
    
    public static var linkOnDark = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: BPKColor.clear,
            foreground: BPKColor.buttonLinkOnDarkNormalForegroundColor),
        loading: .with(
            background: BPKColor.clear,
            foreground: BPKColor.buttonLinkOnDarkPressedForegroundColor),
        disabledAppearance: .with(
            background: BPKColor.clear.withAlphaComponent(0),
            foreground: BPKColor.buttonLinkOnDarkDisabledForegroundColor
        ),
        highlightedAppearance: .with(
            background: BPKColor.clear,
            foreground: BPKColor.buttonLinkOnDarkPressedForegroundColor
        )
    )
    
    public static var primaryOnDark = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: BPKColor.buttonPrimaryOnDarkNormalBackgroundColor,
            foreground: BPKColor.textOnLightColor),
        loading: .with(
            background: BPKColor.buttonPrimaryOnDarkPressedBackgroundColor,
            foreground: BPKColor.textOnLightColor),
        disabledAppearance: .with(
            background: BPKColor.buttonPrimaryOnDarkDisabledBackgroundColor,
            foreground: BPKColor.buttonPrimaryOnDarkDisabledForegroundColor
        ),
        highlightedAppearance: .with(
            background: BPKColor.buttonPrimaryOnDarkPressedBackgroundColor,
            foreground: BPKColor.textOnLightColor
        )
    )
    
    public static var secondaryOnDark = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: BPKColor.buttonSecondaryOnDarkNormalBackgroundColor,
            foreground: BPKColor.textOnDarkColor),
        loading: .with(
            background: BPKColor.buttonSecondaryOnDarkPressedBackgroundColor,
            foreground: BPKColor.textOnDarkColor),
        disabledAppearance: .with(
            background: BPKColor.buttonSecondaryOnDarkDisabledBackgroundColor,
            foreground: BPKColor.buttonSecondaryOnDarkDisabledForegroundColor
        ),
        highlightedAppearance: .with(
            background: BPKColor.buttonSecondaryOnDarkPressedBackgroundColor,
            foreground: BPKColor.textOnDarkColor
        )
    )
    
    public static var primaryOnLight = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: BPKColor.buttonPrimaryOnLightNormalBackgroundColor,
            foreground: BPKColor.textOnDarkColor),
        loading: .with(
            background: BPKColor.buttonPrimaryOnLightPressedBackgroundColor,
            foreground: BPKColor.textOnDarkColor),
        disabledAppearance: .with(
            background: BPKColor.buttonPrimaryOnLightDisabledBackgroundColor,
            foreground: BPKColor.buttonPrimaryOnLightDisabledForegroundColor
        ),
        highlightedAppearance: .with(
            background: BPKColor.buttonPrimaryOnLightPressedBackgroundColor,
            foreground: BPKColor.textOnDarkColor
        )

    )
    
    public static func appearance(fromStyle style: BPKButtonStyle) -> BPKButtonAppearanceSet {
        switch style {
        case .primary: return self.primary
        case .secondary: return self.secondary
        case .secondaryOnDark: return self.secondaryOnDark
        case .destructive: return self.destructive
        case .featured: return self.featured
        case .link: return self.link
        case .linkOnDark: return self.linkOnDark
        case .primaryOnDark: return self.primaryOnDark
        case .primaryOnLight: return self.primaryOnLight
        default: return self.primary
        }
    }
}

fileprivate extension UIColor {
    static var pressedMonteverde: UIColor {
        UIColor(red: 0, green: 0.416, blue: 0.38, alpha: 1)
    }
    
    static var clear = BPKColor.clear
    
    static var primaryColor = BPKColor.skyBlue.darkVariant(.bpk.skyBlueTint01)
    
    static var destructiveColor: UIColor {
        UIColor(red: 0.699, green: 0.182, blue: 0.269, alpha: 1)
            .darkVariant(
                UIColor(red: 0.972, green: 0.361, blue: 0.465, alpha: 1)
            )
    }
    
    static var bpk = BPKColor.self
    
    func darkVariant(_ dark: UIColor) -> UIColor {
        BPKColor.dynamicColor(withLightVariant: self, darkVariant: dark)
    }
}

fileprivate extension BPKButtonAppearance {
    static func with(background: UIColor, foreground: UIColor) -> BPKButtonAppearance {
        BPKButtonAppearance(
            borderColor: nil,
            gradientStart: background,
            gradientEnd: background,
            foregroundColor: foreground
        )
    }
}
