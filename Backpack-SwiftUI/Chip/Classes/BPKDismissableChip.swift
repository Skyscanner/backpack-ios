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

public struct BPKDismissableChip: View {
    let text: String
    let icon: BPKIcon?
    let style: BPKChipStyle
    let onClick: () -> Void
    
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
        .frame(minHeight: .xl)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        .clipShape(RoundedRectangle(cornerRadius: .sm))
        .if(style == .onImage) { $0.shadow(.sm) }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(text)
        .accessibilityAddTraits(.isButton)
        .sizeCategory(.large)
        .onTapGesture(perform: onClick)
    }
    
    private var accessoryViewColor: BPKColor {
        switch style {
        case .`default`: return .textDisabledOnDarkColor
        case .onDark: return .chipOnDarkOnDismissIconColor
        case .onImage: return .textDisabledOnDarkColor
        }
    }
    
    private var backgroundColor: BPKColor {
        switch style {
        case .`default`: return .corePrimaryColor
        case .onDark: return .chipOnDarkOnBackgroundColor
        case .onImage: return .corePrimaryColor
        }
    }
    
    private var foregroundColor: BPKColor {
        switch style {
        case .`default`: return .textOnDarkColor
        case .onDark: return .textPrimaryColor
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
