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
        if disabled {
            return .buttonDisabledBackgroundColor
        }
        switch style {
        case .`default`:
            if selected || isPressed {
                return .corePrimaryColor
            }
            
            return .lineColor
        case .onDark:
            if selected {
                return .surfaceDefaultColor
            }
            
            if isPressed {
                return .chipOnDarkPressedStrokeColor
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
        if disabled {
            return .chipDisabledBackgroundColor
        }
        switch style {
        case .`default`:
            return selected ? .corePrimaryColor : .clear
        case .onDark:
            return selected ? .chipOnDarkOnBackgroundColor : .clear
        case .onImage:
            if selected { return .corePrimaryColor }

            if isPressed { return .canvasContrastColor }

            return .surfaceDefaultColor
        }
    }
    
    private func foregroundColor(_ isPressed: Bool) -> BPKColor {
        if disabled {
            return .textDisabledColor
        }
        switch style {
        case .`default`, .onImage:
            return selected ? .textOnDarkColor : .textPrimaryColor
        case .onDark:
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
