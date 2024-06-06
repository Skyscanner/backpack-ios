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

public struct BPKSaveCardButton: View {
    
    private let animationDuration: TimeInterval = 0.2
    private let maxScale: CGFloat = 1.25
    @State private var scale: CGFloat = 1.0
    @State private var isPressed: Bool = false
    
    let size: BPKCardButtonSize
    let style: BPKCardButtonStyle
    let checked: Bool
    let accessibilityLabel: String
    let action: () -> Void
    
    public init(
        size: BPKCardButtonSize,
        style: BPKCardButtonStyle,
        checked: Bool,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) {
        self.size = size
        self.style = style
        self.checked = checked
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            BPKIconView(icon, size: size.iconSize)
                .foregroundColor(color)
                .scaleEffect(scale)
        }
        .buttonStyle(InternalSaveCardButtonStyle(onIsPressedchange: { isPressed = $0 }))
        .frame(width: size.containerSize, height: size.containerSize)
        .background(style.containerColor)
        .clipShape(Circle())
        .accessibilityLabel(accessibilityLabel)
        .onChange(of: checked) { newValue in
            guard newValue else { return }
            showAnimation()
        }
    }
    
    private var icon: BPKIcon {
        (checked || isPressed) ? .heart : .heartOutline
    }
    
    private var color: BPKColor {
        switch style {
        case .onDark:
            return .textOnDarkColor
        case .default, .contained:
            return checked ? .textLinkColor: .textPrimaryColor
        }
    }
    
    private func showAnimation() {
        withAnimation(.linear(duration: animationDuration)) {
            scale = maxScale
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 2) {
            withAnimation(.linear(duration: animationDuration)) {
                scale = 1.0
            }
        }
    }
}

private struct InternalSaveCardButtonStyle: ButtonStyle {
    let onIsPressedchange: (Bool) -> Void
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed, perform: onIsPressedchange)
    }
}

// MARK: - previews
struct BPKSaveCardButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack(spacing: .lg) {
                InteractiveDemo(size: .default, style: .default)
                InteractiveDemo(size: .small, style: .default)
            }
            .padding()
            
            HStack(spacing: .lg) {
                InteractiveDemo(size: .default, style: .contained)
                InteractiveDemo(size: .small, style: .contained)
                
            }
            .padding()
            .background(.surfaceHighlightColor)
            
            HStack(spacing: .lg) {
                InteractiveDemo(size: .default, style: .onDark)
                InteractiveDemo(size: .small, style: .onDark)
            }
            .padding()
            .background(.black)
        }
    }
}

private struct InteractiveDemo: View {
    let size: BPKCardButtonSize
    let style: BPKCardButtonStyle
    
    @State private var checked: Bool = false
    
    var body: some View {
        BPKSaveCardButton(
            size: size,
            style: style,
            checked: checked,
            accessibilityLabel: "",
            action: {
                checked.toggle()
            }
        )
    }
}
