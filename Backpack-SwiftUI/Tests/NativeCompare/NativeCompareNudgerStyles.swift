//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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
@testable import Backpack_SwiftUI

/// BPKNudger against the stock SwiftUI Stepper. The Stepper ignores tint, so its buttons carry no token;
/// its label carries Backpack type and colour.
enum NudgerComparison: NativeComparison {
    case value
    case atMinimum
    case titled
    case disabled

    var label: String {
        switch self {
        case .value: return "Nudger"
        case .atMinimum: return "Nudger at its minimum"
        case .titled: return "Nudger with title and subtitle"
        case .disabled: return "Nudger, disabled"
        }
    }

    var difference: String {
        switch self {
        case .value:
            return "Backpack is two secondary buttons (component-only fill) around a Text / Primary value. "
                + "The stock stepper ignores tint, keeps the platform grey and shows no value of its own."
        case .atMinimum:
            return "Backpack disables the minus button with the component-only disabled fill. "
                + "The stock stepper dims its minus control from the platform."
        case .titled:
            return "Backpack stacks heading5 and Text / Secondary text before the buttons. "
                + "The stock stepper takes the same label, in Backpack type, and keeps the platform buttons."
        case .disabled:
            return "Backpack greys both buttons and the value with Text / Disabled. "
                + "The stock stepper dims the whole control from the platform."
        }
    }

    private var nudgerValue: Int {
        self == .atMinimum ? 0 : 5
    }

    private var enabled: Bool {
        self != .disabled
    }

    var bpkSwatches: [Swatch] {
        switch self {
        case .value, .titled:
            return [
                .componentOnly("Button fill", .buttonSecondaryNormalBackgroundColor, note: "= Surface / Highlight"),
                .token("Button icon", "Text / Primary", .textPrimaryColor),
                .token("Value", "Text / Primary", .textPrimaryColor)
            ]
        case .atMinimum:
            return [
                .componentOnly("Button fill", .buttonSecondaryNormalBackgroundColor, note: "= Surface / Highlight"),
                .componentOnly("Minus fill", .buttonDisabledBackgroundColor),
                .token("Value", "Text / Primary", .textPrimaryColor)
            ]
        case .disabled:
            return [
                .componentOnly("Button fill", .buttonDisabledBackgroundColor),
                .token("Value", "Text / Disabled", .textDisabledColor)
            ]
        }
    }

    var nativeSwatches: [Swatch] {
        switch self {
        case .value, .titled:
            return [
                .platform("Button fill"),
                .platform("Button icon"),
                .token("Value", "Text / Primary", .textPrimaryColor)
            ]
        case .atMinimum:
            return [
                .platform("Button fill"),
                .platform("Minus fill"),
                .token("Value", "Text / Primary", .textPrimaryColor)
            ]
        case .disabled:
            return [
                .platform("Button fill"),
                .token("Value", "Text / Disabled", .textDisabledColor)
            ]
        }
    }

    var columns: [ComparisonColumns] {
        [
            ComparisonColumns {
                if self == .titled {
                    BPKNudger(
                        title: "Adults",
                        subtitle: "Aged 16+",
                        value: .constant(nudgerValue),
                        min: 0,
                        max: 10
                    )
                } else {
                    BPKNudger(value: .constant(nudgerValue), min: 0, max: 10, enabled: enabled)
                }
            } native: {
                Stepper(value: .constant(nudgerValue), in: 0...10) {
                    stepperLabel
                }
                .disabled(!enabled)
            }
        ]
    }

    /// The Stepper's leading label: the value, and for the titled pair the same title and subtitle.
    private var stepperLabel: some View {
        HStack(spacing: .md) {
            if self == .titled {
                VStack(alignment: .leading) {
                    Text("Adults")
                        .font(BPKFontStyle.heading5.font)
                        .foregroundColor(BPKColor.textPrimaryColor)
                    Text("Aged 16+")
                        .font(BPKFontStyle.bodyDefault.font)
                        .foregroundColor(BPKColor.textSecondaryColor)
                }
                Spacer()
            }
            Text("\(nudgerValue)")
                .font(BPKFontStyle.heading5.font)
                .foregroundColor(enabled ? BPKColor.textPrimaryColor : BPKColor.textDisabledColor)
        }
    }
}
