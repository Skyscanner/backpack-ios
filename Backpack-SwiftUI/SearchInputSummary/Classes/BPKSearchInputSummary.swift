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
    private let inputPrefix: InputPrefix?
    private var style: Style = .default
    private let accessibilityIdentifier: String
    private var customAccessibilityValue: String?
    private let readOnly: Bool
    private let clearAction: ClearAction
    
    public struct ClearAction {
        public let accessibilityLabel: String
        public let action: () -> Void
        
        public init(accessibilityLabel: String, action: @escaping () -> Void) {
            self.accessibilityLabel = accessibilityLabel
            self.action = action
        }
    }
    
    public init(
        placeholder: String = "",
        inputPrefix: InputPrefix? = nil,
        clearAction: ClearAction,
        readOnly: Bool = false,
        accessibilityIdentifier: String = "search_field",
        customAccessibilityValue: String? = nil,
        _ text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.inputPrefix = inputPrefix
        self.clearAction = clearAction
        self.readOnly = readOnly
        self.accessibilityIdentifier = accessibilityIdentifier
        self.customAccessibilityValue = customAccessibilityValue
        self._text = text
    }
    
    public var body: some View {
        HStack(spacing: .md) {
            prefixView
                .accessibilityHidden(true)
            TextField(placeholder, text: $text, prompt: placeholderView)
                .font(style: .bodyDefault)
                .foregroundColor(.textPrimaryColor)
                .disabled(readOnly)
                .if(readOnly, transform: { view in
                    view.accessibilityElement()
                })
                .accessibilityValue(customAccessibilityValue ?? text)
                .accessibilityLabel(placeholder)
                .accessibilityAddTraits(readOnly ? [] : .isSearchField)
                .accessibilityIdentifier(accessibilityIdentifier)
                .focused($focused)
            accessory
        }
        .frame(maxWidth: .infinity, minHeight: 48.0)
        .padding(.horizontal, BPKSpacing.base)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .md))
        .outline(
            isBorderHighlighted ? .textLinkColor : .lineColor,
            cornerRadius: .md,
            lineWidth: isBorderHighlighted ? 2.0 : 1.0
        )
        
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
    }
    
    @ViewBuilder
    private var accessory: some View {
        Button(action: clearAction.action) {
            BPKIconView(.closeCircle)
                .foregroundColor(.textSecondaryColor)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(clearAction.accessibilityLabel)
        .accessibilityAddTraits(.isButton)
        .opacity(text.isEmpty ? 0.0 : 1.0)
    }
    
    @ViewBuilder
    private var placeholderView: Text {
        Text(placeholder)
            .foregroundColor(Color(BPKColor.textSecondaryColor.value))
    }
    
    @ViewBuilder
    private var prefixView: some View {
        if let inputPrefix {
            switch inputPrefix {
            case .text(let prefixText):
                BPKText(prefixText, style: .bodyDefault)
                    .foregroundColor(.textSecondaryColor)
            case .icon(let icon):
                BPKIconView(icon)
                    .foregroundColor(.textPrimaryColor)
            }
        }
    }
    
    public func customStyle(_ style: Style) -> BPKSearchInputSummary {
        var result = self
        result.style = style
        return result
    }
    
    private var isBorderHighlighted: Bool {
        focused || style == .focused
    }
}

fileprivate extension TextField {
    func font(style: BPKFontStyle) -> some View {
        self.font(style.font)
    }
}

struct BPKSearchInputSummary_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable line_length
        VStack {
            BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: {}), .constant(""))
            BPKSearchInputSummary(placeholder: "Enter", clearAction: .init(accessibilityLabel: "Clear", action: {}), .constant(""))
            BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: {}), .constant("Value"))
            BPKSearchInputSummary(inputPrefix: .text("From"), clearAction: .init(accessibilityLabel: "Clear", action: {}), .constant("Value"))
            BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: {}), readOnly: true, .constant("Read Only"))
            BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: {}), .constant("Manually highlighted"))
                .customStyle(.focused)
            BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: {}), .constant("Value"))
            BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "clear", action: {}), .constant("Value"))
        }
        .padding()
        .background(.coreEcoColor)
    }
}
