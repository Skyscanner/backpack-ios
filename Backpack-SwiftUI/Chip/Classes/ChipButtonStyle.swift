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

import SwiftUI
import Backpack_Common

struct ChipButtonStyle: ButtonStyle {
    let style: BPKChipStyle
    let selected: Bool
    let disabled: Bool
    let config: BpkConfiguration?

    func makeBody(configuration: Self.Configuration) -> some View {
        
        if config?.chipConfig != nil {
            chipLabelView(configuration: configuration)
                .clipShape(cornerShape)
                .overlay(
                    cornerShape
                        .stroke(Color(outlineColor(configuration.isPressed)), lineWidth: 1)
                )
                .if(style == .onImage) { $0.shadow(.sm) }
                .if(!BPKFont.enableDynamicType, transform: {
                    $0.sizeCategory(.large)
                })
        } else {
            chipLabelView(configuration: configuration)
                .clipShape(RoundedRectangle(cornerRadius: .sm))
                .outline(outlineColor(configuration.isPressed), cornerRadius: .sm)
                .if(style == .onImage) { $0.shadow(.sm) }
                .if(!BPKFont.enableDynamicType, transform: {
                    $0.sizeCategory(.large)
                })
        }
    }
    
    private func chipLabelView(
        configuration: Self.Configuration
    ) -> some View {
        configuration.label
            .frame(minHeight: .xl)
            .lineLimit(1)
            .background(backgroundColor(configuration.isPressed))
            .foregroundColor(foregroundColor(configuration.isPressed))
    }
    
    private var cornerShape: some Shape {
        if let radiusToken = config?.chipConfig?.radiusToken, radiusToken == .roundCorners {
            return AnyShape(Capsule())
        } else {
            return AnyShape(RoundedRectangle(cornerRadius: BPKCornerRadius.sm.value))
        }
    }
    
    private func outlineColor(_ isPressed: Bool) -> BPKColor {
        
        let chipConfig = self.config?.chipConfig
        
        if disabled {
            return .buttonDisabledBackgroundColor
        }
        switch style {
        case .`default`:
            if selected || isPressed {
                return chipConfig != nil ? .coreAccentColor : .corePrimaryColor
            }
            
            return config != nil ? .clear : .lineColor
        case .onDark:
            if selected {
                return chipConfig != nil ? .textOnDarkColor : .surfaceDefaultColor
            }
            
            if isPressed {
                return chipConfig != nil ? .textOnDarkColor : .chipOnDarkPressedStrokeColor
            }
            
            return .lineOnDarkColor
        case .onImage:
            if selected {
                return .corePrimaryColor
            }
            
            if isPressed {
                return .canvasContrastColor
            }
            
            return .surfaceDefaultColor
        }
    }
    
    private func backgroundColor(_ isPressed: Bool) -> BPKColor {
        
        let chipConfig = self.config?.chipConfig
        
        if disabled {
            return .chipDisabledBackgroundColor
        }
        switch style {
        case .`default`:
            
            if chipConfig != nil {
                return selected ? .coreAccentColor : .surfaceDefaultColor
            }
            
            return selected ? .corePrimaryColor : .clear
        case .onDark:
            
            // To add to foundations.
            let chipOnFillLight = UIColor(red: 21/255, green: 70/255, blue: 121/255, alpha: 1)
            let chipOnFillDark = UIColor(red: 2/255, green: 77/255, blue: 175/255, alpha: 1)
            let chipOnFill = UIColor.dynamicColorTest(light: chipOnFillLight, dark: chipOnFillDark)
            
            if chipConfig != nil {
                return selected ? .textOnDarkColor : BPKColor(value: chipOnFill)
            }
            
            return selected ? .chipOnDarkOnBackgroundColor : .clear
        case .onImage:
            if selected { return .corePrimaryColor }

            if isPressed { return .canvasContrastColor }

            return .surfaceDefaultColor
        }
    }
    
    private func foregroundColor(_ isPressed: Bool) -> BPKColor {
        
        let chipConfig = self.config?.chipConfig
        
        if disabled {
            return .textDisabledColor
        }
        switch style {
        case .`default`:
            
            if chipConfig != nil {
                return selected ? .textPrimaryInverseColor : .textPrimaryColor
            }
            
            return selected ? .textOnDarkColor : .textPrimaryColor
        case .onImage:
            
            return selected ? .textOnDarkColor : .textPrimaryColor
            
        case .onDark:
            
            if chipConfig != nil {
                return selected ? .textOnLightColor : .textOnDarkColor
            }
            
            return selected ? .textPrimaryColor : .textOnDarkColor
        }
    }
}

// Helper struct to type-erase shapes
struct AnyShape: Shape {
    private let _path: (CGRect) -> Path
    
    init<S: Shape>(_ shape: S) {
        _path = shape.path(in:)
    }
    
    func path(in rect: CGRect) -> Path {
        return _path(rect)
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
