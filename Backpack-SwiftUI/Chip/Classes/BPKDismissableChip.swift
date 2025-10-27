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

public struct BPKDismissableChip: View {
    let text: String
    let icon: BPKIcon?
    let style: BPKChipStyle
    let onClick: () -> Void
    let config: BpkConfiguration?
    
    public init(
        _ text: String,
        icon: BPKIcon? = nil,
        style: BPKChipStyle = .default,
        onClick: @escaping () -> Void
    ) {
        self.text = text
        self.icon = icon
        self.style = style
        self.onClick = onClick
        self.config = BpkConfiguration.shared
    }
    
    public var body: some View {
        HStack(spacing: .md) {
            if let icon {
                BPKIconView(icon)
                
            }
            Text(text)
                .font(style: .footnote)
            BPKIconView(.closeCircle)
                .foregroundColor(accessoryViewColor)
        }
        .padding(.trailing, .md)
        .padding(.leading, .base)
        .padding(.vertical, config?.chipConfig?.height ?? BPKSpacing.none.value)
        .frame(minHeight: .xl)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        .clipShape(cornerShape)
        .if(style == .onImage) { $0.shadow(.sm) }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(text)
        .accessibilityAddTraits(.isButton)
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
        .onTapGesture(perform: onClick)
    }
    
    private var accessoryViewColor: BPKColor {
        let chipConfig = self.config?.chipConfig
        
        switch style {
        case .`default`: return chipConfig != nil ? .textPrimaryInverseColor : .textDisabledOnDarkColor
        case .onDark: return chipConfig != nil ? .textOnLightColor : .chipOnDarkOnDismissIconColor
        case .onImage: return .textDisabledOnDarkColor
        }
    }
    
    private var cornerShape: some Shape {
        if let radiusToken = config?.chipConfig?.radiusToken, radiusToken == .roundCorners {
            return AnyShape(Capsule())
        } else {
            return AnyShape(RoundedRectangle(cornerRadius: BPKCornerRadius.sm.value))
        }
    }
    
    private var backgroundColor: BPKColor {
        let chipConfig = self.config?.chipConfig
        
        // To add to foundations.
        let chipOnFillLight = UIColor(red: 21/255, green: 70/255, blue: 121/255, alpha: 1)
        let chipOnFillDark = UIColor(red: 0.000, green: 0.384, blue: 0.890, alpha: 1)
        let chipOnFill = UIColor.dynamicColorTest(light: chipOnFillLight, dark: chipOnFillDark)
        
        switch style {
        case .`default`: return chipConfig != nil ? .coreAccentColor : .corePrimaryColor
        case .onDark: return chipConfig != nil ? .textOnDarkColor  : .chipOnDarkOnBackgroundColor
        case .onImage: return .corePrimaryColor
        }
    }
    
    private var foregroundColor: BPKColor {
        let chipConfig = self.config?.chipConfig
        
        switch style {
        case .`default`: return chipConfig != nil ? .textPrimaryInverseColor : .textOnDarkColor
        case .onDark: return chipConfig != nil ? .textOnLightColor : .textPrimaryColor
        case .onImage: return .textOnDarkColor
        }
    }
}

struct BPKDismissableChip_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKDismissableChip("Dismiss") {}
            BPKDismissableChip("Dismiss", icon: .account) {}
            BPKDismissableChip("Dismiss", style: .onDark) {}
                .padding()
                .background(.surfaceContrastColor)
            BPKDismissableChip("Dismiss", style: .onImage) {}
                .padding()
                .background(.statusSuccessSpotColor)
        }
    }
}
