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

struct BPKRadioControl: View {
    private enum Constants {
        static let size = BPKSpacing.sm.value * 5
        static let innerCircleSize = BPKSpacing.md.value
        static let borderWidth = (size - innerCircleSize) / 4
    }

    let isSelected: Bool
    let style: BPKRadioStyle
    let status: BPKRadioStatus
    let isEnabled: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(Color(backgroundColor))
                .overlay {
                    Circle()
                        .strokeBorder(Color(foregroundColor), lineWidth: Constants.borderWidth)
                }

            if isSelected {
                Circle()
                    .fill(Color(foregroundColor))
                    .frame(
                        width: Constants.innerCircleSize,
                        height: Constants.innerCircleSize
                    )
            }
        }
        .frame(width: Constants.size, height: Constants.size)
        .accessibilityHidden(true)
    }

    private var foregroundColor: BPKColor {
        guard isEnabled, status != .disabled else {
            return disabledColor
        }

        switch status {
        case .regular:
            return regularColor
        case .error:
            return .radioInvalidBackgroundColor
        case .disabled:
            return disabledColor
        }
    }

    private var regularColor: BPKColor {
        switch (style, isSelected) {
        case (.default, true):
            return .radioDefaultSelectedBackgroundColor
        case (.default, false):
            return .radioDefaultUnselectedStrokeColor
        case (.onContrast, true):
            return .radioOnContrastSelectedBackgroundColor
        case (.onContrast, false):
            return .radioDefaultUnselectedStrokeColor
        }
    }

    private var backgroundColor: BPKColor {
        guard isEnabled, status == .regular, !isSelected else {
            return .clear
        }

        switch style {
        case .default:
            return .clear
        case .onContrast:
            return .radioOnContrastUnselectedBackgroundColor
        }
    }

    private var disabledColor: BPKColor {
        switch style {
        case .default:
            return .radioDefaultDisabledBackgroundColor
        case .onContrast:
            return .textDisabledOnDarkColor
        }
    }
}
