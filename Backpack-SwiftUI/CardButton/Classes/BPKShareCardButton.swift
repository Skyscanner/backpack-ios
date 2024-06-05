/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2024 Skyscanner Ltd
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

public struct BPKShareCardButton: View {
    
    private let size: BPKCardButtonSize
    private let style: BPKCardButtonStyle
    private let accessibilityLabel: String
    private let action: () -> Void
    
    public init(
        size: BPKCardButtonSize,
        style: BPKCardButtonStyle,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) {
        self.size = size
        self.style = style
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            BPKIconView(.shareiOs, size: size.iconSize)
        }
        .buttonStyle(InternalShareCardButtonStyle(style: style))
        .frame(width: size.containerSize, height: size.containerSize)
        .background(style.containerColor)
        .clipShape(Circle())
        .accessibilityLabel(accessibilityLabel)
    }
}

private struct InternalShareCardButtonStyle: ButtonStyle {
    let style: BPKCardButtonStyle
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? highlightedColor: defaultColor)
    }
    
    var defaultColor: BPKColor {
        if case .onDark = style {
            return .textOnDarkColor
        }
        return .textPrimaryColor
    }
    
    var highlightedColor: BPKColor {
        if case .onDark = style {
            return .textDisabledOnDarkColor
        }
        return .textLinkColor
    }
}

#Preview {
    VStack {
        HStack(spacing: .lg) {
            BPKShareCardButton(size: .default, style: .default, accessibilityLabel: "") { }
            BPKShareCardButton(size: .small, style: .default, accessibilityLabel: "") { }
        }
        .padding()
        
        HStack(spacing: .lg) {
            BPKShareCardButton(size: .default, style: .contained, accessibilityLabel: "") { }
            BPKShareCardButton(size: .small, style: .contained, accessibilityLabel: "") { }
        }
        .padding()
        .background(.surfaceHighlightColor)
        
        HStack(spacing: .lg) {
            BPKShareCardButton(size: .default, style: .onDark, accessibilityLabel: "") { }
            BPKShareCardButton(size: .small, style: .onDark, accessibilityLabel: "") { }
        }
        .padding()
        .background(.black)
    }
}
