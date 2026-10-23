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

struct BPKChipAppearanceSets {
    struct AppearanceSet {
        let normal: Colors
        let highlighted: Colors
        let selected: Colors
        let disabled: Colors
    }
    
    struct Colors {
        let background: UIColor
        let content: UIColor
        let stroke: UIColor?
        
        init(background: UIColor, content: UIColor, stroke: UIColor? = nil) {
            self.background = background
            self.content = content
            self.stroke = stroke
        }
    }
    
    
    private static let onDarkAppearance = {
        
        return AppearanceSet(
            normal: Colors(
                background: BPKColor.chipOnDarkOnFillColor,
                content: BPKColor.textOnDarkColor,
                stroke: BPKColor.clear),
            highlighted: Colors(
                background: BPKColor.chipOnDarkOnFillColor,
                content: BPKColor.textOnLightColor,
                stroke: BPKColor.textOnDarkColor),
            selected: Colors(
                background: BPKColor.textOnDarkColor,
                content: BPKColor.textOnLightColor
            ),
            disabled: Colors(
                background: BPKColor.chipDisabledBackgroundColor,
                content: BPKColor.textDisabledColor
            )
        )
    }()
    
    private static let onImageAppearance = AppearanceSet(
        normal: Colors(
            background: BPKColor.surfaceDefaultColor,
            content: BPKColor.textPrimaryColor
        ),
        highlighted: Colors(
            background: BPKColor.canvasContrastColor,
            content: BPKColor.textPrimaryColor
        ),
        selected: Colors(
            background: BPKColor.corePrimaryColor,
            content: BPKColor.textOnDarkColor
        ),
        disabled: Colors(
            background: BPKColor.chipDisabledBackgroundColor,
            content: BPKColor.textDisabledColor
        )
    )
    

    private static let defaultAppearance =  {
        
        return AppearanceSet(
            normal: Colors(
                background: BPKColor.clear,
                content: BPKColor.textPrimaryColor,
                stroke: BPKColor.lineColor
            ),
            highlighted: Colors(
                background: BPKColor.clear,
                content: BPKColor.textPrimaryColor,
                stroke: BPKColor.coreAccentColor
            ),
            selected: Colors(
                background: BPKColor.coreAccentColor,
                content: BPKColor.textPrimaryInverseColor
            ),
            disabled: Colors(
                background: BPKColor.chipDisabledBackgroundColor,
                content: BPKColor.textDisabledColor
            )
        )
    }()
    
    private static let onContrastAppearance = AppearanceSet(
        normal: Colors(
            background: BPKColor.surfaceDefaultColor,
            content: BPKColor.textPrimaryColor,
            stroke: BPKColor.clear
        ),
        highlighted: Colors(
            background: BPKColor.surfaceDefaultColor,
            content: BPKColor.textPrimaryColor,
            stroke: BPKColor.coreAccentColor
        ),
        selected: Colors(
            background: BPKColor.coreAccentColor,
            content: BPKColor.textPrimaryInverseColor
        ),
        disabled: Colors(
            background: BPKColor.chipDisabledBackgroundColor,
            content: BPKColor.textDisabledColor
        )
    )

    static func appearance(fromStyle style: BPKChipStyle) -> AppearanceSet {
        
        switch style {
        case .`default`: return defaultAppearance
        case .onContrast: return onContrastAppearance
        case .onDark: return onDarkAppearance
        case .onImage: return onImageAppearance
        }
    }
}
