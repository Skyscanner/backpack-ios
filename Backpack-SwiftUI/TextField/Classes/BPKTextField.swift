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

/// A control that displays an editable text interface.
///
/// Use `inputState(_ state: State)` to change the state of the text field.
public struct BPKTextField: View {
    public enum PrefixState {
        case text(String)
        case searchIcon
    }
    
    struct Icon {
        let icon: BPKIcon
        let color: BPKColor
    }
    
    @Binding private var text: String
    private let placeholder: String
    private let prefixState: PrefixState?
    private var state: State = .default

    /// Creates a `BPKTextField`.
    ///
    /// - Parameters:
    ///   - placeholder: The placeholder text to display when the text field is empty.
    ///   - text: The text to display in the text field.
    public init(
        placeholder: String = "",
        prefixState: PrefixState? = nil,
        _ text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.prefixState = prefixState
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
            accessory
        }
        .padding(.md)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .sm))
        .outline(state.borderColor, cornerRadius: .sm)
    }
    
    private var accessory: some View {
        HStack {
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
    }
    
    private var prefixView: some View {
        HStack {
            switch prefixState {
            case .text(let prefixText):
                BPKText(prefixText, style: .bodyDefault)
                    .foregroundColor(.textSecondaryColor)
            case .searchIcon:
                BPKIconView(BPKIcon(name: "search"))
                    .foregroundColor(.textPrimaryColor)
                    .accessibilityHidden(true)
            case nil:
                EmptyView()
            }
        }
    }
    
    public func inputState(_ state: State) -> BPKTextField {
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

struct BPKTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKTextField(.constant(""))
            BPKTextField(placeholder: "Enter", .constant(""))
            BPKTextField(.constant("Value"))
            BPKTextField(.constant("Disabled"))
                .inputState(.disabled)
            BPKTextField(.constant("Value"))
                .inputState(.error)
            BPKTextField(.constant("Value"))
                .inputState(.clear(accessibilityLabel: "clear", action: {}))
            BPKTextField(.constant("Value"))
                .inputState(.valid)
        }
        .padding()
        .background(.coreEcoColor)
    }
}
