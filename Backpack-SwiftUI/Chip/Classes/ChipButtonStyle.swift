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
        chipLabelView(configuration: configuration)
            .clipShape(RoundedRectangle(cornerRadius: setRadius()))
            .outline(outlineColor(configuration.isPressed), cornerRadius: setRadius())
            .if(style == .onImage) { $0.shadow(.sm) }
            .if(!BPKFont.enableDynamicType, transform: {
                $0.sizeCategory(.large)
            })
    }
    
    private func setRadius() -> BPKCornerRadius {
        if config?.chipConfig != nil {
            return .lg
        }
        
        return .sm
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
    
    private func outlineColor(_ isPressed: Bool) -> BPKColor {
        
        let chipConfig = self.config?.chipConfig
        
        if disabled {
            return .buttonDisabledBackgroundColor
        }
        switch style {
        case .`default`, .onContrast:
            if selected || isPressed {
                return chipConfig != nil ? .coreAccentColor : .corePrimaryColor
            }
            
            return config != nil && style != .onContrast ? .lineColor : .clear
        case .onDark:
            if selected {
                return chipConfig != nil ? .textOnDarkColor : .surfaceDefaultColor
            }
            
            if isPressed {
                return chipConfig != nil ? .textOnDarkColor : .chipOnDarkPressedStrokeColor
            }
            
            return chipConfig != nil ? .clear : .lineOnDarkColor
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
                return selected ? .coreAccentColor : .clear
            }
            
            return selected ? .corePrimaryColor : .clear
        case .onContrast:
            return selected ? .coreAccentColor : .surfaceDefaultColor
        case .onDark:
            
            if chipConfig != nil, let chipDarkFill = chipConfig?.color {
                return selected ? .textOnDarkColor : BPKColor(value: chipDarkFill)
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
        case .`default`, .onContrast:
            
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
