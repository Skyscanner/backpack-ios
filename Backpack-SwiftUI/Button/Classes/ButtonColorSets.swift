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

extension BPKButton {
    struct ColorSets {
        let regular: Colors
        let highlighted: Colors
        let disabled: Colors
        let loading: Colors
        
        struct Colors {
            let background: BPKColor
            let foreground: BPKColor
            
            static let staticDisabled = Colors(background: .skyGrayTint06, foreground: .skyGrayTint04)
            static let clearDisabled = Colors(background: .clear, foreground: .skyGrayTint04.darkVariant(.blackTint03))
            static let dynamicDisabled = Colors(
                background: .skyGrayTint06.darkVariant(.blackTint01),
                foreground: .skyGrayTint04.darkVariant(.blackTint03)
            )
        }
        
        private static func regular(regular: Colors, highlighted: Colors) -> ColorSets {
            ColorSets(
                regular: regular,
                highlighted: highlighted,
                disabled: .dynamicDisabled,
                loading: .dynamicDisabled
            )
        }
        
        private static func regularStatic(regular: Colors, highlighted: Colors) -> ColorSets {
            ColorSets(
                regular: regular,
                highlighted: highlighted,
                disabled: .staticDisabled,
                loading: .staticDisabled
            )
        }
        
        private static func clear(regular: BPKColor, highlighted: BPKColor) -> ColorSets {
            ColorSets(
                regular: Colors(background: .clear, foreground: regular),
                highlighted: Colors(background: .clear, foreground: highlighted),
                disabled: .clearDisabled,
                loading: .clearDisabled
            )
        }
    }
}

extension BPKButton.ColorSets {
    static let primary = regular(
        regular: .init(background: .monteverde, foreground: .textPrimary),
        highlighted: .init(background: .pressedMonteverde, foreground: .textPrimary)
    )
    static let secondary = regular(
        regular: .init(background: .backgroundSecondary, foreground: .textSecondary),
        highlighted: .init(background: .skyGrayTint05.darkVariant(.blackTint01), foreground: .textSecondary)
    )
    static let secondaryOnDark = regular(
        regular: .init(background: .white.withAlphaComponent(0.1), foreground: .white),
        highlighted: .init(background: .white.withAlphaComponent(0.15), foreground: .white)
    )
    static let destructive = regular(
        regular: .init(background: .backgroundSecondary, foreground: .destructiveColor),
        highlighted: .init(background: .destructiveColor, foreground: .textPrimary)
    )
    static let featured = regular(
        regular: .init(background: .primaryColor, foreground: .textPrimary),
        highlighted: .init(background: .skyBlueShade01, foreground: .textPrimary)
    )
    static let link = clear(
        regular: .primaryColor,
        highlighted: .skyBlueShade01.darkVariant(.skyBlue)
    )
    static let linkOnDark = clear(
        regular: .white,
        highlighted: .white.withAlphaComponent(0.6)
    )
    static let primaryOnDark = regularStatic(
        regular: .init(background: .white, foreground: .skyGray),
        highlighted: .init(background: .skyGrayTint05, foreground: .skyGray)
    )
    static let primaryOnLight = regularStatic(
        regular: .init(background: .skyGray, foreground: .white),
        highlighted: .init(background: .skyGrayTint01, foreground: .white)
    )
}

private extension BPKColor {
    static let pressedMonteverde = BPKColor(value: UIColor(red: 0, green: 0.416, blue: 0.38, alpha: 1))
    
    static let textPrimary = BPKColor.white.darkVariant(.black)
    static let textSecondary = BPKColor.skyBlueShade01.darkVariant(.skyBlueTint01)
    
    static let backgroundSecondary = BPKColor.skyGrayTint06.darkVariant(.blackTint02)
    
    static let destructiveLight = BPKColor(value: UIColor(red: 0.699, green: 0.182, blue: 0.269, alpha: 1))
    static let destructiveDark = BPKColor(value: UIColor(red: 0.972, green: 0.361, blue: 0.465, alpha: 1))
    static let destructiveColor = destructiveLight.darkVariant(destructiveDark)
}
