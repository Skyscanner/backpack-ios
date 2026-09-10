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

/// One Backpack button style set against the stock SwiftUI button for the same job, tinted with
/// Backpack SEMANTIC tokens only. Role map shared with Android: app-native/docs/semantic-token-mapping.md.
///
/// Lives in the snapshot test target only, which is what lets it read the library's internal button
/// colours through @testable import, so no hex is written here. Nothing ships in Backpack_SwiftUI.
/// Shared layout and legend: NativeCompareSupport.swift.
enum ButtonComparison: NativeComparison {
    case primary
    case secondary
    case destructive
    case link

    var label: String {
        switch self {
        case .primary: return "Primary"
        case .secondary: return "Secondary"
        case .destructive: return "Destructive"
        case .link: return "Link"
        }
    }

    var bpkStyle: Backpack_SwiftUI.BPKButton.Style {
        switch self {
        case .primary: return .primary
        case .secondary: return .secondary
        case .destructive: return .destructive
        case .link: return .link
        }
    }

    /// What BPKButton paints with today (no button configuration, as the app runs).
    var bpkSwatches: [Swatch] {
        switch self {
        case .primary:
            return [
                .componentOnly("Fill", .buttonPrimaryNormalBackgroundColor, note: "light = Core / Primary"),
                .token("Text", "Text / On dark", .textOnDarkColor),
                .componentOnly("Pressed", .buttonPrimaryPressedBackgroundColor),
                .componentOnly("Disabled", .buttonDisabledBackgroundColor)
            ]
        case .secondary:
            return [
                .componentOnly("Fill", .buttonSecondaryNormalBackgroundColor, note: "= Surface / Highlight"),
                .token("Text", "Text / Primary", .textPrimaryColor),
                .componentOnly("Pressed", .buttonSecondaryPressedBackgroundColor),
                .componentOnly("Disabled", .buttonDisabledBackgroundColor)
            ]
        case .destructive:
            return [
                .componentOnly("Fill", .buttonDestructiveNormalBackgroundColor, note: "= Surface / Highlight"),
                .componentOnly("Text", .buttonDestructiveNormalForegroundColor, note: "= Text / Error"),
                .componentOnly("Pressed", .buttonDestructivePressedBackgroundColor),
                .componentOnly("Disabled", .buttonDisabledBackgroundColor)
            ]
        case .link:
            return [
                .token("Text", "Text / Primary, underlined", .textPrimaryColor),
                .token("Disabled", "Text / Disabled", .textDisabledColor)
            ]
        }
    }

    /// The difference between the two, in one sentence.
    var difference: String {
        switch self {
        case .primary:
            return "Light: same. Dark: Backpack fills #024DAF, Core / Primary is #054184. "
                + "Press and disabled are button-only on Backpack."
        case .secondary:
            return "Same fill in both modes, a button-only copy of Surface / Highlight. "
                + "The stock bordered button tints its fill from Core / Primary instead."
        case .destructive:
            return "Same text colour. Backpack's fill and text are button-only copies of Surface / Highlight "
                + "and Text / Error; the stock bordered button tints its fill from Status / Danger spot."
        case .link:
            return "Same colour. Backpack underlines the label; SwiftUI does not."
        }
    }

    /// What the native column paints with: semantic tokens only.
    var nativeSwatches: [Swatch] {
        switch self {
        case .primary:
            return [
                .token("Fill", "Core / Primary", .corePrimaryColor),
                .token("Text", "Text / On dark", .textOnDarkColor),
                .platform("Pressed"),
                .platform("Disabled")
            ]
        case .secondary:
            return [
                .platform("Fill", note: "tint Core / Primary"),
                .token("Text", "Core / Primary", .corePrimaryColor),
                .platform("Pressed"),
                .platform("Disabled")
            ]
        case .destructive:
            return [
                .platform("Fill", note: "tint Status / Danger spot"),
                .token("Text", "Status / Danger spot", .statusDangerSpotColor),
                .platform("Pressed"),
                .platform("Disabled")
            ]
        case .link:
            return [
                .token("Text", "Text / Primary", .textPrimaryColor),
                .platform("Pressed"),
                .platform("Disabled")
            ]
        }
    }

    /// The pair in enabled and disabled state, one row each.
    var columns: [ComparisonColumns] {
        [true, false].map { enabled in
            ComparisonColumns {
                BPKButton("Button", enabled: .constant(enabled)) {}
                    .buttonStyle(bpkStyle)
            } native: {
                native(enabled: enabled)
            }
        }
    }

    /// The stock SwiftUI button for the job, carrying Backpack semantic tokens only: tint colour,
    /// Backpack's button type style (label1) and Backpack's button corner radius (sm).
    @ViewBuilder
    func native(enabled: Bool) -> some View {
        switch self {
        case .primary:
            Button("Button") {}
                .buttonStyle(.borderedProminent)
                .tint(Color(BPKColor.corePrimaryColor))
                .foregroundColor(enabled ? BPKColor.textOnDarkColor : BPKColor.textDisabledColor)
                .nativeBackpackChrome()
                .disabled(!enabled)
        case .secondary:
            Button("Button") {}
                .buttonStyle(.bordered)
                .tint(Color(BPKColor.corePrimaryColor))
                .nativeBackpackChrome()
                .disabled(!enabled)
        case .destructive:
            Button("Button", role: .destructive) {}
                .buttonStyle(.bordered)
                .tint(Color(BPKColor.statusDangerSpotColor))
                .nativeBackpackChrome()
                .disabled(!enabled)
        case .link:
            Button("Button") {}
                .buttonStyle(.borderless)
                .tint(Color(BPKColor.textPrimaryColor))
                .font(BPKFontStyle.label1.font)
                .disabled(!enabled)
        }
    }
}

private extension View {
    /// Backpack's button type style and corner radius, both semantic tokens, on a stock SwiftUI button.
    func nativeBackpackChrome() -> some View {
        self
            .font(BPKFontStyle.label1.font)
            .buttonBorderShape(.roundedRectangle(radius: BPKCornerRadius.sm.value))
    }
}
