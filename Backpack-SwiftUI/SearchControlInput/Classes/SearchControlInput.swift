/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

/// Style configuration for a background colour
public enum SearchControlInputStyle {
    case regular
    case onContrast
    
    var backgroundColor: BPKColor {
        switch self {
        case .regular:
            .surfaceDefaultColor
        case .onContrast:
            .canvasContrastColor
        }
    }
}

/// An actionable control field that displays an text and an icon.
public struct BPKSearchControlInput: View {
    
    private let accessibilityLabel: String
    private let placeholder: String
    private let value: String?
    private let icon: BPKIcon
    private let style: SearchControlInputStyle
    private let action: () -> Void
    private let accessibilityValueHandler: (() -> String)?
    
    /// Creates a `BPKSearchControlInput`.
    ///
    /// - Parameters:
    ///   - placeholder: Placeholder text when `value` is nil.
    ///   - value: Optional property to display a value.
    ///   - icon: The displayed icon.
    ///   - style: Enum value to define the appearence of the element.
    ///   - accessibilityLabel: Additional information about a purpose for accessibility users.
    ///   - accessibilityValueHandler: Handler function to provide a readable value description for accessibility..
    ///   - action: Click handler function.
    public init(
        placeholder: String,
        value: String?,
        icon: BPKIcon,
        style: SearchControlInputStyle = .regular,
        accessibilityLabel: String,
        accessibilityValueHandler: (() -> String)? = nil,
        action: @escaping () -> Void
    ) {
        self.placeholder = placeholder
        self.value = value
        self.icon = icon
        self.style = style
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityValueHandler = accessibilityValueHandler
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: .md) {
                BPKIconView(icon)
                    .foregroundColor(.textSecondaryColor)
                BPKText(value ?? placeholder)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(value == nil ? .textSecondaryColor : .textPrimaryColor)
            }
            .frame(maxWidth: .infinity, minHeight: 48.0, alignment: .leading)
            .padding(.horizontal, BPKSpacing.base)
            .background(style.backgroundColor)
        }
        .accessibilityLabel(accessibilityLabel)
        .accessibilityValue(accessibilityValue)
    }
    
    private var accessibilityValue: String {
        guard let accessibilityValueHandler else {
            return value ?? ""
        }
        return accessibilityValueHandler()
    }
}

struct BPKSearchControlInput_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKSearchControlInput(placeholder: "Field", value: nil, icon: .calendar, accessibilityLabel: "Input") {}
        }
        .padding()
        .background(.coreEcoColor)
    }
}
