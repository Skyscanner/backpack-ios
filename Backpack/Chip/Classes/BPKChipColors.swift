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

extension BPKChip {
    struct Colors {
        let background: UIColor
        let content: UIColor
        
        static func disabled(_ style: BPKChipStyle, backgroundTint: UIColor?) -> Colors {
            let contentColor = BPKColor.dynamicColor(
                withLightVariant: BPKColor.skyGrayTint04,
                darkVariant: BPKColor.blackTint06
            )
            
            switch style {
            case .outline:
                return Colors(background: BPKColor.clear, content: contentColor)
            case .filled:
                var lightColor = BPKColor.skyGrayTint07
                let darkColor = BPKColor.blackTint03
                
                if let backgroundTint = backgroundTint {
                    lightColor = BPKColor.blend(backgroundTint, with: BPKColor.backgroundTertiaryColor, weight: 0.2)
                }
                
                return Colors(
                    background: BPKColor.dynamicColor(withLightVariant: lightColor, darkVariant: darkColor),
                    content: contentColor)
            }
        }
        
        static func unselected(_ style: BPKChipStyle, backgroundTint: UIColor?) -> Colors {
            let contentColor = BPKColor.textPrimaryColor
            
            if let backgroundTint = backgroundTint {
                return Colors(
                    background: BPKColor.blend(backgroundTint, with: BPKColor.backgroundTertiaryColor, weight: 0.2),
                    content: contentColor
                )
            }
            
            switch style {
            case .filled:
                return Colors(
                    background: BPKColor.dynamicColor(
                        withLightVariant: BPKColor.skyGrayTint07,
                        darkVariant: BPKColor.blackTint03
                    ),
                    content: contentColor
                )
            case .outline:
                return Colors(
                    background: BPKColor.dynamicColor(
                        withLightVariant: BPKColor.white,
                        darkVariant: BPKColor.blackTint03
                    ),
                    content: contentColor
                )
            }
        }
        
        static func selected(backgroundTint: UIColor?, primaryColor: UIColor?) -> Colors {
            var backgroundColor = BPKColor.skyBlue
            
            if let backgroundTint = backgroundTint {
                backgroundColor = backgroundTint
            }
            
            if let primaryColor = primaryColor {
                backgroundColor = primaryColor
            }
            
            return Colors(background: backgroundColor, content: BPKColor.white)
        }
    }
}
