//
//  BPKButtonAppearanceSets.swift
//  Backpack
//
//  Created by Nicolas Frugoni on 18/02/2022.
//

import Foundation

@objcMembers
@IBDesignable
public class BPKButtonAppearanceSets: NSObject {
    
    private static var textPrimary = BPKColor.white.darkVariant(.black)
    private static var secondaryForeground = BPKColor.skyBlueShade01.darkVariant(.bpk.skyBlueTint01)
    private static var secondaryBackground = BPKColor.skyGrayTint06.darkVariant(.bpk.blackTint02)
    
    private static var disabledAppearance = BPKButtonAppearance.with(
        background: .bpk.skyGrayTint06.darkVariant(.bpk.blackTint01),
        foreground: .bpk.skyGrayTint04.darkVariant(.bpk.blackTint03)
    )
    
    private static var clearDisabledAppearance = BPKButtonAppearance.with(
        background: .clear,
        foreground: .bpk.skyGrayTint04.darkVariant(.bpk.blackTint03)
    )
    
    public static var primary = BPKButtonAppearanceSet(
        regularAppearance: .with(background: .bpk.monteverde, foreground: textPrimary),
        loading: disabledAppearance, disabledAppearance: disabledAppearance,
        highlightedAppearance: .with(background: .pressedMonteverde, foreground: textPrimary)
    )
    
    public static var secondary = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: secondaryBackground,
            foreground: secondaryForeground
        ),
        loading: disabledAppearance, disabledAppearance: disabledAppearance,
        highlightedAppearance: .with(
            background: .bpk.skyGrayTint05.darkVariant(.bpk.blackTint01),
            foreground: secondaryForeground
        )
    )
    
    public static var featured = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: .primaryColor,
            foreground: textPrimary
        ),
        loading: disabledAppearance, disabledAppearance: disabledAppearance,
        highlightedAppearance: .with(background: .bpk.skyBlueShade01, foreground: textPrimary)
    )
    
    public static var destructive = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: secondaryBackground,
            foreground: .destructiveColor
        ),
        loading: disabledAppearance, disabledAppearance: disabledAppearance,
        highlightedAppearance: .with(background: .destructiveColor, foreground: textPrimary)
    )
    
    public static var link = BPKButtonAppearanceSet(
        regularAppearance: .with(
            background: .clear,
            foreground: .primaryColor
        ),
        loading: clearDisabledAppearance, disabledAppearance: clearDisabledAppearance,
        highlightedAppearance: .with(
            background: .clear,
            foreground: .bpk.skyBlueShade01.darkVariant(.bpk.skyBlueTint01)
        )
    )
    
    public static var outline = BPKButtonAppearanceSet(
        regularAppearance: .with(
            border: .white,
            background: .clear,
            foreground: .white
        ),
        loading: disabledAppearance, disabledAppearance: disabledAppearance,
        highlightedAppearance: .with(
            border: .white.darkVariant(.white),
            background: .clear.darkVariant(.bpk.blackTint02),
            foreground: .white
        )
    )
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
    static func with(border: UIColor? = nil, background: UIColor, foreground: UIColor) -> BPKButtonAppearance {
        BPKButtonAppearance(
            borderColor: border,
            gradientStart: background,
            gradientEnd: background,
            foregroundColor: foreground
        )
    }
}
