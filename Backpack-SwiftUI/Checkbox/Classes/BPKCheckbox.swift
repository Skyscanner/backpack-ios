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

public struct BPKCheckbox: View {
    @Binding var checked: Bool

    let text: String
    let icon: BPKIcon?
    let layout: BPKCheckboxLayout
    let style: BPKCheckboxStyle
    let status: BPKCheckboxStatus

    private var disabled = false

    public init(
        _ text: String,
        icon: BPKIcon? = nil,
        checked: Binding<Bool>,
        layout: BPKCheckboxLayout = BPKCheckboxLayout(),
        style: BPKCheckboxStyle = .default,
        status: BPKCheckboxStatus = .regular
    ) {
        self.text = text
        self.icon = icon
        self._checked = checked
        self.layout = layout
        self.style = style
        self.status = status
    }

    public var body: some View {
        Toggle(isOn: $checked) {
            HStack() {
                if let icon {
                    BPKIconView(icon, size: .small)
                        .foregroundColor(Color(textColor))
                }
                
                Text(text)
                    .frame(maxWidth: .infinity, alignment: layout.alignment)
                    .foregroundColor(Color(textColor))
            }
        }
        .toggleStyle(BPKCheckboxToggleStyle(
            selected: checked,
            disabled: disabled,
            layout: layout,
            style: style,
            status: status))
        .disabled(disabled)
    }

    public func disabled(_ disabled: Bool) -> BPKCheckbox {
        var checkBox = self
        checkBox.disabled = disabled
        return checkBox
    }

    private var textColor: BPKColor {
        switch style {
        case .default:
            return .textPrimaryColor
        case .onContrast:
            return .textOnDarkColor
        }
    }
}

struct BPKCheckboxToggleStyle: ToggleStyle {
    let selected: Bool
    let disabled: Bool
    let layout: BPKCheckboxLayout
    let style: BPKCheckboxStyle
    let status: BPKCheckboxStatus

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if layout.labelStyle == .leftSitting {
                configuration.label
            }
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(Color(outlineColor(configuration.isOn)),
                        lineWidth: configuration.isOn ? 0 : 6)
                .background(Color(backgroundColor(configuration.isOn)))
                .frame(width: 20, height: 20)
                .cornerRadius(5.0)
                .overlay {
                    if configuration.isOn {
                        setCheckIcon()
                            .foregroundColor(Color(iconColor))
                            .scaleEffect(0.85)
                    }
                }
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            if layout.labelStyle == .rightSitting  {
                configuration.label
            }
        }
    }

    private func setCheckIcon() -> BPKIconView {
        switch status {
        case .regular, .error:
            return BPKIconView(.checkboxTick, size: .large)
        case .intermediate:
            return BPKIconView(.checkboxMinus, size: .large)
        }
    }

    private func backgroundColor(_ isOn: Bool) -> BPKColor {
        guard isOn else { return .clear }

        switch style {
        case .default, .onContrast:
            return .coreAccentColor
        }
    }

    private var iconColor: BPKColor {
        switch style {
        case .default, .onContrast:
            return .textOnDarkColor.darkVariant(.textOnLightColor)
        }
    }

    private func outlineColor(_ isOn: Bool) -> BPKColor {
        if disabled {
            switch style {
            case .default:
                return .lineColor
            case .onContrast:
                return .textOnDarkColor.withAlphaComponent(0.2)
            }
        }

        switch style {
        case .default:
            switch status {
            case .regular, .intermediate:
                return .textSecondaryColor
            case .error:
                return .textErrorColor
            }
        case .onContrast:
            switch status {
            case .regular, .intermediate:
                return .textOnDarkColor.withAlphaComponent(0.55)
            case .error:
                return .textErrorColor
            }
        }
    }
}

struct CheckboxPreviewWrapper: View {
    @State private var regular = true
    @State private var unchecked = false
    @State private var error = false
    @State private var intermediate = true
    @State private var disabled = false

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                BPKCheckbox("Regular", checked: $regular)
                BPKCheckbox("Regular", icon: .accountIdCard, checked: $regular)
                BPKCheckbox("Unchecked", checked: $unchecked)
                BPKCheckbox("Error", checked: $error, status: .error)
                BPKCheckbox("Intermediate", checked: $intermediate, status: .intermediate)
                BPKCheckbox("Disabled", checked: $disabled).disabled(true)
                BPKCheckbox("Regular", checked: $regular, layout: BPKCheckboxLayout(labelStyle: .leftSitting))
                BPKCheckbox("Regular", icon: .baggage, checked: $regular, layout: BPKCheckboxLayout(labelStyle: .leftSitting))
            }
            .padding()

            VStack(alignment: .leading, spacing: 10) {
                BPKCheckbox("Regular", checked: $regular, style: .onContrast)
                BPKCheckbox("Regular", icon: .accountIdCard, checked: $regular, style: .onContrast)
                BPKCheckbox("Unchecked", checked: $unchecked, style: .onContrast)
                BPKCheckbox("Error", checked: $error, style: .onContrast, status: .error)
                BPKCheckbox("Intermediate", checked: $intermediate, style: .onContrast, status: .intermediate)
                BPKCheckbox("Disabled", checked: $disabled, style: .onContrast).disabled(true)
                BPKCheckbox("Regular", checked: $regular, layout: BPKCheckboxLayout(labelStyle: .leftSitting), style: .onContrast)
                BPKCheckbox("Regular", icon: .baggage, checked: $regular, layout: BPKCheckboxLayout(labelStyle: .leftSitting), style: .onContrast)
            }
            .padding()
            .background(Color(.surfaceContrastColor))
        }
    }
}

#Preview {
    CheckboxPreviewWrapper()
}
