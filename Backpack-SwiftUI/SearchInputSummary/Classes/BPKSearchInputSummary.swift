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

/// A control that displays an editable text interface for search inputs.
///
/// Use `inputState(_ state: State)` to change the state of the text field.
public struct BPKSearchInputSummary: View {
    public enum InputPrefix {
        case text(String)
        case icon(BPKIcon)
    }
    
    struct Icon {
        let icon: BPKIcon
        let color: BPKColor
    }
    
    @Binding private var text: String
    @FocusState private var focused: Bool
    private let placeholder: String
    private let inputPrefix: InputPrefix
    private var state: State = .default
    
    /// Creates a `BPKSearchInputSummary`.
    ///
    /// - Parameters:
    ///   - placeholder: The placeholder text to display when the text field is empty.
    ///   - inputPrefix: The prefix which would be displayed on the left of text input
    ///   - text: The text to display in the text field.
    public init(
        placeholder: String = "",
        inputPrefix: InputPrefix = .icon(.search),
        _ text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.inputPrefix = inputPrefix
        self._text = text
    }
    
    public var body: some View {
        HStack {
            prefixView
                .accessibilityHidden(true)
            TextField(placeholder, text: $text)
                .font(style: .bodyDefault)
                .foregroundColor(state.textColor)
                .disabled(state.isDisabled)
                .focused($focused)
            accessory
        }
        .padding(.md)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .sm))
        .outline(focused ? .textLinkColor : state.borderColor, cornerRadius: .sm, lineWidth: focused ? 2.0 : 1.0)
    }
    
    @ViewBuilder
    private var accessory: some View {
        if let icon = state.icon {
            if case let .clear(accessibilityLabel, action) = state {
                Button(action: action) {
                    BPKIconView(icon.icon)
                        .foregroundColor(icon.color)
                }
                    .accessibilityLabel(accessibilityLabel)
            } else {
                BPKIconView(icon.icon)
                    .foregroundColor(icon.color)
                    .accessibilityHidden(true)
            }
        }
    }
    
    @ViewBuilder
    private var prefixView: some View {
        switch inputPrefix {
        case .text(let prefixText):
            BPKText(prefixText, style: .bodyDefault)
                .foregroundColor(.textSecondaryColor)
        case .icon(let icon):
            BPKIconView(icon)
                .foregroundColor(.textPrimaryColor)
        }
    }
    
    public func inputState(_ state: State) -> BPKSearchInputSummary {
        var result = self
        result.state = state
        return result
    }
}

fileprivate extension TextField {
    func font(style: BPKFontStyle) -> some View {
        self.font(style.font)
    }
}

struct BPKSearchInputSummary_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKSearchInputSummary(.constant(""))
            BPKSearchInputSummary(placeholder: "Enter", .constant(""))
            BPKSearchInputSummary(.constant("Value"))
            BPKSearchInputSummary(inputPrefix: .text("From"), .constant("Value"))
            BPKSearchInputSummary(.constant("Disabled"))
                .inputState(.disabled)
            BPKSearchInputSummary(.constant("Value"))
                .inputState(.error)
            BPKSearchInputSummary(.constant("Value"))
                .inputState(.clear(accessibilityLabel: "clear", action: {}))
            BPKSearchInputSummary(.constant("Value"))
                .inputState(.valid)
        }
        .padding()
        .background(.coreEcoColor)
    }
}
