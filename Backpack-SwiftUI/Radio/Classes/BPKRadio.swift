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

import SwiftUI

public struct BPKRadio: View {
    @Environment(\.isEnabled) private var isEnabled

    private let isSelected: Bool
    private let accessibilityLabel: String
    private let style: BPKRadioStyle
    private let status: BPKRadioStatus
    private let action: () -> Void

    public init(
        isSelected: Bool,
        accessibilityLabel: String,
        style: BPKRadioStyle = .default,
        status: BPKRadioStatus = .regular,
        action: @escaping () -> Void
    ) {
        self.isSelected = isSelected
        self.accessibilityLabel = accessibilityLabel
        self.style = style
        self.status = status
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            BPKRadioControl(
                isSelected: isSelected,
                style: style,
                status: status,
                isEnabled: isEnabled
            )
        }
        .buttonStyle(.plain)
        .disabled(status == .disabled)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

private struct BPKRadioPreview: View {
    private let states: [(String, Bool, BPKRadioStatus)] = [
        ("Selected", true, .regular),
        ("Not selected", false, .regular),
        ("Selected error", true, .error),
        ("Not selected error", false, .error),
        ("Selected disabled", true, .disabled),
        ("Not selected disabled", false, .disabled)
    ]

    var body: some View {
        HStack(spacing: 0) {
            stateColumn(title: "Default", style: .default)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.canvasColor))

            stateColumn(title: "On Dark", style: .onContrast)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.surfaceContrastColor))
        }
    }

    private func stateColumn(title: String, style: BPKRadioStyle) -> some View {
        VStack(alignment: .leading, spacing: .lg) {
            BPKText(title, style: .heading3)
                .foregroundColor(labelColor(for: style, status: .regular))
            ForEach(Array(states.enumerated()), id: \.offset) { _, state in
                HStack(spacing: BPKSpacing.md.value) {
                    BPKRadio(
                        isSelected: state.1,
                        accessibilityLabel: state.0,
                        style: style,
                        status: state.2,
                        action: {}
                    )

                    Text(state.0)
                        .foregroundColor(labelColor(for: style, status: state.2))
                }
            }
        }
    }

    private func labelColor(for style: BPKRadioStyle, status: BPKRadioStatus) -> BPKColor {
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
    BPKRadioPreview()
}
