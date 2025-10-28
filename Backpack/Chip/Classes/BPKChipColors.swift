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
    
    private static let onDarkAppearance = AppearanceSet(
        normal: Colors(
            background: BPKColor.clear,
            content: BPKColor.textOnDarkColor,
            stroke: BPKColor.lineOnDarkColor),
        highlighted: Colors(
            background: BPKColor.clear,
            content: BPKColor.textPrimaryColor,
            stroke: BPKColor.chipOnDarkPressedStrokeColor),
        selected: Colors(
            background: BPKColor.chipOnDarkOnBackgroundColor,
            content: BPKColor.textPrimaryColor
        ),
        disabled: Colors(
            background: BPKColor.chipDisabledBackgroundColor,
            content: BPKColor.textDisabledColor
        )
    )
    
    private static let onDarkAppearanceExperiment = {
        // To add to foundations.
        let chipOnFill = UIColor.dynamicColorTest(
            light: UIColor(red: 21/255, green: 70/255, blue: 121/255, alpha: 1),
            dark: UIColor(red: 2/255, green: 77/255, blue: 175/255, alpha: 1)
        )
        
        return AppearanceSet(
            normal: Colors(
                background: chipOnFill,
                content: BPKColor.textOnDarkColor,
                stroke: BPKColor.clear),
            highlighted: Colors(
                background: chipOnFill,
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
    
    private static let defaultAppearance = AppearanceSet(
        normal: Colors(
            background: BPKColor.clear,
            content: BPKColor.textPrimaryColor,
            stroke: BPKColor.lineColor
        ),
        highlighted: Colors(
            background: BPKColor.clear,
            content: BPKColor.textPrimaryColor,
            stroke: BPKColor.corePrimaryColor
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

    private static let defaultAppearanceExperiment = AppearanceSet(
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
        
        let config = BpkConfiguration.shared.chipConfig
        
        switch style {
        case .`default`: return config != nil ? defaultAppearanceExperiment : defaultAppearance
        case .onDark: return config != nil ? onDarkAppearanceExperiment : onDarkAppearance
        case .onImage: return onImageAppearance
        }
    }
}

// As we are not adding the new colours to Foundations yet, this is to handle the new colouring.
extension UIColor {
    private static var dynamicColorsCache = NSCache<NSString, UIColor>()

    static func dynamicColorTest(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return light
        }

        let key = "\(light.cacheKey)_\(dark.cacheKey)" as NSString

        if let cached = dynamicColorsCache.object(forKey: key) {
            return cached
        }

        let dynamicColour = UIColor { traits -> UIColor in
            traits.userInterfaceStyle == .dark ? dark : light
        }

        dynamicColorsCache.setObject(dynamicColour, forKey: key)
        return dynamicColour
    }

    private var cacheKey: String {
        guard let components = cgColor.components else { return description }
        return components.map(String.init).joined(separator: "_")
    }
}
