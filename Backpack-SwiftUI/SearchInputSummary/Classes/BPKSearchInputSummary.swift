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
import Backpack_Common

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
    private var docking: Docking = .float
    private var minHeight: CGFloat = 48.0
    private let accessibilityIdentifier: String
    private var customAccessibilityValue: String?
    private let readOnly: Bool
    private let clearAction: ClearAction?

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
        clearAction: ClearAction? = nil,
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
                .accessibilityLabel(accessibilityLabel)
                .accessibilityAddTraits(readOnly ? [] : .isSearchField)
                .accessibilityIdentifier(accessibilityIdentifier)
                .focused($focused)
            accessory
        }
        .frame(maxWidth: .infinity, minHeight: minHeight)
        .padding(.horizontal, BPKSpacing.base)
        .background(.surfaceDefaultColor)
        .clipShape(dockingShape)
        .overlay(dockingBorder)
        
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
    }

    private var accessibilityLabel: String {
        if case let .text(prefixText)? = inputPrefix {
            return "\(prefixText), \(placeholder)"
        }
        return placeholder
    }

    @ViewBuilder
    private var accessory: some View {
        if let clearAction {
            Button(action: clearAction.action) {
                BPKIconView(.closeCircle)
                    .foregroundColor(.textSecondaryColor)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(clearAction.accessibilityLabel)
            .accessibilityAddTraits(.isButton)
            .opacity(text.isEmpty ? 0.0 : 1.0)
        }
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

    /// Sets the docking position for stacked search inputs.
    /// - Parameter docking: The docking position (.float, .top, .middle, .bottom)
    /// - Returns: A modified search input summary with the specified docking
    public func docking(_ docking: Docking) -> BPKSearchInputSummary {
        var result = self
        result.docking = docking
        return result
    }

    /// Sets the minimum height for the search input.
    /// - Parameter height: The minimum height in points. Default is 48.
    /// - Returns: A modified search input summary with the specified minimum height
    public func inputMinHeight(_ height: CGFloat) -> BPKSearchInputSummary {
        var result = self
        result.minHeight = height
        return result
    }

    private var isBorderHighlighted: Bool {
        focused || style == .focused
    }

    private var dockingShape: UnevenRoundedRectangle {
        UnevenRoundedRectangle(
            topLeadingRadius: docking.topCornerRadius,
            bottomLeadingRadius: docking.bottomCornerRadius,
            bottomTrailingRadius: docking.bottomCornerRadius,
            topTrailingRadius: docking.topCornerRadius
        )
    }

    private var dockingBorder: some View {
        let lineWidth = isBorderHighlighted ? 2.0 : 1.0
        return dockingShape
            .stroke(.clear, lineWidth: lineWidth)
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
        ScrollView {
            VStack(spacing: .lg) {
                // Float (default - standalone) with clear action
                VStack(alignment: .leading, spacing: .sm) {
                    BPKText("With clear action", style: .caption)
                        .foregroundColor(.textOnDarkColor)
                    BPKSearchInputSummary(
                        placeholder: "Standalone input",
                        inputPrefix: .icon(.search),
                        clearAction: .init(accessibilityLabel: "Clear", action: {}),
                        .constant("Some value")
                    )
                }

                // Docked stack example (no clear action)
                VStack(alignment: .leading, spacing: .sm) {
                    BPKText("Docked stack (no clear action)", style: .caption)
                        .foregroundColor(.textOnDarkColor)
                    VStack(spacing: 0) {
                        BPKSearchInputSummary(
                            placeholder: "Where from?",
                            inputPrefix: .icon(.flightTakeoff),
                            .constant("")
                        )
                        .docking(.top)

                        BPKSearchInputSummary(
                            placeholder: "Where to?",
                            inputPrefix: .icon(.flightLanding),
                            .constant("")
                        )
                        .docking(.middle)

                        BPKSearchInputSummary(
                            placeholder: "Select dates",
                            inputPrefix: .icon(.calendar),
                            .constant("")
                        )
                        .docking(.bottom)
                    }
                }

                // Two docked inputs with values
                VStack(alignment: .leading, spacing: .sm) {
                    BPKText("With values", style: .caption)
                        .foregroundColor(.textOnDarkColor)
                    VStack(spacing: 0) {
                        BPKSearchInputSummary(
                            placeholder: "Origin",
                            inputPrefix: .icon(.flightTakeoff),
                            .constant("London")
                        )
                        .docking(.top)

                        BPKSearchInputSummary(
                            placeholder: "Destination",
                            inputPrefix: .icon(.flightLanding),
                            .constant("Paris")
                        )
                        .docking(.bottom)
                    }
                }

                // With focus state
                VStack(alignment: .leading, spacing: .sm) {
                    BPKText("With focus highlight", style: .caption)
                        .foregroundColor(.textOnDarkColor)
                    VStack(spacing: 0) {
                        BPKSearchInputSummary(
                            placeholder: "Where from?",
                            inputPrefix: .icon(.flightTakeoff),
                            .constant("Edinburgh")
                        )
                        .docking(.top)
                        .customStyle(.focused)

                        BPKSearchInputSummary(
                            placeholder: "Where to?",
                            inputPrefix: .icon(.flightLanding),
                            .constant("")
                        )
                        .docking(.bottom)
                    }
                }
            }
            .padding()
        }
        .background(.corePrimaryColor)
    }
}
