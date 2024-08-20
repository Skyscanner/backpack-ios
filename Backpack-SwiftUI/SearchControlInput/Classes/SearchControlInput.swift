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

public enum SearchControlInputStyle {
    case regular
    case onContrast
}

/// A control that displays an text and an icon.
public struct BPKSearchControlInput: View {
    
    private let label: String
    private let placeholder: String
    private let value: String?
    private let icon: BPKIcon
    private let style: SearchControlInputStyle
    private let action: () -> Void
    private let accessibilityValueHandler: (() -> String)?
    
    /// Creates a `BPKSearchControlInput`.
    ///
    /// - Parameters:
    ///   - label: The displayed text.
    ///   - icon: The displayed icon.
    ///   - isOnContrast: Indicating whether the view is displayed on a contrasting background or not. Default is false.
    public init(
        label: String,
        placeholder: String,
        value: String? = nil,
        icon: BPKIcon,
        style: SearchControlInputStyle = .regular,
        accessibilityValueHandler: (() -> String)? = nil,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.placeholder = placeholder
        self.value = value
        self.icon = icon
        self.style = style
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
            .background(style == .regular ? .surfaceDefaultColor : .canvasContrastColor)
        }
        .accessibilityLabel(label)
        .accessibilityValue(accessibilityValue)
        .accessibilityIdentifier("search_control_input")
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
            BPKSearchControlInput(label: "Input", placeholder: "Placehokder", icon: .calendar) {  }
        }
        .padding()
        .background(.coreEcoColor)
    }
}
