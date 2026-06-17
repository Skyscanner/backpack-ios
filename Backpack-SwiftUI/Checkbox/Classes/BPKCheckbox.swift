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
    @State private var isOn: Bool = false

    let text: String
    let selected: Bool
    let style: BPKCheckboxStyle
    let status: BPKCheckboxStatus
    let onTap: () -> Void

    private var disabled = false

    public init(
        _ text: String,
        selected: Bool = false,
        style: BPKCheckboxStyle = .default,
        status: BPKCheckboxStatus = .regular,
        onTap: @escaping () -> Void
    ) {
        self.text = text
        self.selected = selected
        self.style = style
        self.status = status
        self.isOn = selected
        self.onTap = onTap
    }

    public var body: some View {
        Toggle(isOn: $isOn) {
            Text(text)
                .foregroundColor(Color(textColor))
        }
        .toggleStyle(BPKCheckboxToggleStyle(
            selected: selected,
            disabled: disabled,
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
    let style: BPKCheckboxStyle
    let status: BPKCheckboxStatus

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(Color(outlineColor(configuration.isOn)),
                        lineWidth: configuration.isOn ? 0 : 6)
                .background(backgroundColor(configuration.isOn))
                .frame(width: 20, height: 20)
                .cornerRadius(5.0)
                .overlay {
                    if configuration.isOn {
                        setCheckIcon()
                            .foregroundColor(iconColor)
                    }
                }
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }

    private func setCheckIcon() -> BPKIconView {
        switch status {
        case .regular:
            return BPKIconView(.tick, size: .small)
        case .error:
            return BPKIconView(.baggageCross, size: .small)
        case .intermediate:
            return BPKIconView(.minus, size: .small)
        }
    }

    private func backgroundColor(_ isOn: Bool) -> BPKColor {
        guard isOn else { return .clear }

        switch style {
        case .default, .onContrast:
            return .surfaceHeroColor
        }
    }

    private var iconColor: BPKColor {
        switch style {
        case .default, .onContrast:
            return .textPrimaryInverseColor
        }
    }

    private func outlineColor(_ isOn: Bool) -> BPKColor {
        if disabled {
            return .lineColor
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
                return .textOnDarkColor
            case .error:
                return .textErrorColor
            }
        }
    }
}

#Preview {
    HStack {
        VStack(alignment: .leading, spacing: 10) {
            BPKCheckbox("Regular", selected: true, onTap: {})
            BPKCheckbox("Unchecked", onTap: {})
            BPKCheckbox("Error", status: .error, onTap: {})
            BPKCheckbox("Intermediate", selected: true, status: .intermediate, onTap: {})
            BPKCheckbox("Disabled", onTap: {}).disabled(true)
        }

        VStack(alignment: .leading, spacing: 10) {
            BPKCheckbox("Regular", selected: true, style: .onContrast, onTap: {})
            BPKCheckbox("Unchecked", style: .onContrast, onTap: {})
            BPKCheckbox("Error", style: .onContrast, status: .error, onTap: {})
            BPKCheckbox("Intermediate", selected: true, style: .onContrast, status: .intermediate, onTap: {})
            BPKCheckbox("Disabled", style: .onContrast, onTap: {}).disabled(true)
        }
        .padding()
        .background(Color(.surfaceContrastColor))
    }
}
