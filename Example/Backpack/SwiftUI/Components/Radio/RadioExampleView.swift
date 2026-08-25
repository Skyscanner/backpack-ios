/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2026 Skyscanner Ltd
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

import Backpack_SwiftUI
import SwiftUI

struct RadioExampleView: View {
    @State private var defaultSelection = 0
    @State private var onContrastSelection = 0

    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            radioGroup(
                title: "Default",
                style: .default,
                selection: $defaultSelection
            )
            .background(Color(.canvasColor))

            radioGroup(
                title: "On dark",
                style: .onContrast,
                selection: $onContrastSelection
            )
            .background(Color(.surfaceContrastColor))
        }
    }

    private func radioGroup(
        title: String,
        style: BPKRadioStyle,
        selection: Binding<Int>
    ) -> some View {
        VStack(alignment: .leading, spacing: .lg) {
            BPKText(title, style: .heading3)
                .foregroundColor(labelColor(for: style, status: .regular))

            radioRow(
                label: selection.wrappedValue == 0 ? "Selected" : "Not selected",
                isSelected: selection.wrappedValue == 0,
                style: style,
                action: { selection.wrappedValue = 0 }
            )
            radioRow(
                label: selection.wrappedValue == 1 ? "Selected" : "Not selected",
                isSelected: selection.wrappedValue == 1,
                style: style,
                action: { selection.wrappedValue = 1 }
            )
            radioRow(label: "Selected error", isSelected: true, style: style, status: .error)
            radioRow(label: "Not selected error", isSelected: false, style: style, status: .error)
            radioRow(label: "Selected disabled", isSelected: true, style: style, status: .disabled)
            radioRow(label: "Not selected disabled", isSelected: false, style: style, status: .disabled)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func radioRow(
        label: String,
        isSelected: Bool,
        style: BPKRadioStyle,
        status: BPKRadioStatus = .regular,
        action: @escaping () -> Void = {}
    ) -> some View {
        HStack(spacing: .md) {
            BPKRadio(
                isSelected: isSelected,
                accessibilityLabel: label,
                style: style,
                status: status,
                action: action
            )
            BPKText(label)
                .lineLimit(nil)
                .foregroundColor(labelColor(for: style, status: .regular))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }

    private func labelColor(for style: BPKRadioStyle, status: BPKRadioStatus) -> Backpack_SwiftUI.BPKColor {
        if status == .disabled {
            switch style {
            case .default:
                return .textDisabledColor
            case .onContrast:
                return .textDisabledOnDarkColor
            }
        }

        switch style {
        case .default:
            return .textPrimaryColor
        case .onContrast:
            return .textOnDarkColor
        }
    }
}

#Preview {
    RadioExampleView()
}
