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
import XCTest
@testable import Backpack_SwiftUI

final class BPKRadioTests: XCTestCase {
    func testStates() {
        assertSnapshot(RadioStatesTestView(style: .default))
    }

    func testOnContrastStates() {
        assertSnapshot(RadioStatesTestView(style: .onContrast))
    }
}

private struct RadioStatesTestView: View {
    let style: BPKRadioStyle

    private let states: [(String, Bool, BPKRadioStatus)] = [
        ("Selected", true, .regular),
        ("Not selected", false, .regular),
        ("Selected error", true, .error),
        ("Not selected error", false, .error),
        ("Selected disabled", true, .disabled),
        ("Not selected disabled", false, .disabled)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: .lg) {
            ForEach(Array(states.enumerated()), id: \.offset) { _, state in
                radioRow(label: state.0, isSelected: state.1, status: state.2)
            }

            radioRow(label: "Selected parent disabled", isSelected: true)
                .disabled(true)
            radioRow(label: "Not selected parent disabled", isSelected: false)
                .disabled(true)
        }
        .padding()
        .background(backgroundColor)
    }

    private func radioRow(
        label: String,
        isSelected: Bool,
        status: BPKRadioStatus = .regular
    ) -> some View {
        HStack(spacing: .md) {
            BPKRadio(
                isSelected: isSelected,
                accessibilityLabel: label,
                style: style,
                status: status,
                action: {}
            )
            BPKText(label)
                .foregroundColor(labelColor)
        }
    }

    private var labelColor: BPKColor {
        switch style {
        case .default:
            return .textPrimaryColor
        case .onContrast:
            return (.textOnDarkColor)
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .default:
            return Color(.canvasColor)
        case .onContrast:
            return Color(.surfaceContrastColor)
        }
    }
}
