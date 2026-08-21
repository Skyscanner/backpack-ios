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
enum ButtonComparison: CaseIterable {
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
                .buttonOnly("Fill", .buttonPrimaryNormalBackgroundColor, note: "light = Core / Primary"),
                .token("Text", "Text / On dark", .textOnDarkColor),
                .buttonOnly("Pressed", .buttonPrimaryPressedBackgroundColor),
                .buttonOnly("Disabled", .buttonDisabledBackgroundColor)
            ]
        case .secondary:
            return [
                .buttonOnly("Fill", .buttonSecondaryNormalBackgroundColor, note: "= Surface / Highlight"),
                .token("Text", "Text / Primary", .textPrimaryColor),
                .buttonOnly("Pressed", .buttonSecondaryPressedBackgroundColor),
                .buttonOnly("Disabled", .buttonDisabledBackgroundColor)
            ]
        case .destructive:
            return [
                .buttonOnly("Fill", .buttonDestructiveNormalBackgroundColor, note: "= Surface / Highlight"),
                .buttonOnly("Text", .buttonDestructiveNormalForegroundColor, note: "= Text / Error"),
                .buttonOnly("Pressed", .buttonDestructivePressedBackgroundColor),
                .buttonOnly("Disabled", .buttonDisabledBackgroundColor)
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

/// One line of the colour legend under a button: the state, the colour, its hex in the current
/// mode, and what design knows it as (the Figma variable name, or "button-only colour").
struct Swatch: Identifiable {
    enum Source {
        case token(Backpack_SwiftUI.BPKColor)
        case buttonOnly(Backpack_SwiftUI.BPKColor)
        case platform
    }

    let state: String
    let name: String
    let source: Source
    var id: String { state + name }

    static func token(_ state: String, _ figmaName: String, _ color: Backpack_SwiftUI.BPKColor) -> Swatch {
        Swatch(state: state, name: figmaName, source: .token(color))
    }

    /// A button-only value, read from the library's internal colour so light and dark stay in sync.
    static func buttonOnly(_ state: String, _ color: Backpack_SwiftUI.BPKColor, note: String = "") -> Swatch {
        let name = note.isEmpty ? "button-only" : "button-only, \(note)"
        return Swatch(state: state, name: name, source: .buttonOnly(color))
    }

    static func platform(_ state: String, note: String = "") -> Swatch {
        let name = note.isEmpty ? "from the platform" : "from the platform, \(note)"
        return Swatch(state: state, name: name, source: .platform)
    }

    func uiColor(for scheme: ColorScheme) -> UIColor? {
        let traits = UITraitCollection(userInterfaceStyle: scheme == .dark ? .dark : .light)
        switch source {
        case .token(let color), .buttonOnly(let color):
            return color.value.resolvedColor(with: traits)
        case .platform:
            return nil
        }
    }
}

/// One row per state: Backpack today, the native component, and whether they match.
struct ComparisonTable: View {
    let backpack: [Swatch]
    let native: [Swatch]
    @Environment(\.colorScheme)
    private var colorScheme
    // Column widths follow the reader's text size, like the text they hold.
    @ScaledMetric(relativeTo: .caption)
    private var stateWidth: CGFloat = 64
    @ScaledMetric(relativeTo: .caption)
    private var sameWidth: CGFloat = 48

    private var states: [String] {
        var seen: [String] = []
        for state in backpack.map(\.state) + native.map(\.state) where !seen.contains(state) {
            seen.append(state)
        }
        return seen
    }

    var body: some View {
        VStack(alignment: .leading, spacing: BPKSpacing.sm) {
            row(
                state: { BPKText("State", style: .label2) },
                backpack: { BPKText("Backpack", style: .label2) },
                native: { BPKText("Native", style: .label2) },
                same: { BPKText("Same", style: .label2) }
            )
            Divider()
            ForEach(states, id: \.self) { state in
                let left = backpack.first { $0.state == state }
                let right = native.first { $0.state == state }
                let leftColor = left?.uiColor(for: colorScheme)
                let rightColor = right?.uiColor(for: colorScheme)
                row(
                    state: { secondary(state) },
                    backpack: { if let left { SwatchCell(swatch: left, color: leftColor) } },
                    native: { if let right { SwatchCell(swatch: right, color: rightColor) } },
                    same: { secondary(sameText(leftColor, rightColor)) }
                )
            }
        }
    }

    private func sameText(_ left: UIColor?, _ right: UIColor?) -> String {
        guard let left, let right else { return "\u{2013}" }
        return left.hexString == right.hexString ? "yes" : "no"
    }

    private func row<S: View, B: View, N: View, M: View>(
        @ViewBuilder state: () -> S,
        @ViewBuilder backpack: () -> B,
        @ViewBuilder native: () -> N,
        @ViewBuilder same: () -> M
    ) -> some View {
        HStack(alignment: .center, spacing: BPKSpacing.md) {
            state().frame(width: stateWidth, alignment: .leading)
            backpack().frame(maxWidth: .infinity, alignment: .leading)
            native().frame(maxWidth: .infinity, alignment: .leading)
            same().frame(width: sameWidth, alignment: .leading)
        }
    }

    private func secondary(_ text: String) -> some View {
        BPKText(text, style: .caption)
            .foregroundColor(.textSecondaryColor)
    }
}

/// Swatch, hex in the current mode, and the name. One line at normal text sizes; at accessibility
/// sizes the name stacks under the hex so the row stays readable instead of wrapping mid-word.
private struct SwatchCell: View {
    let swatch: Swatch
    let color: UIColor?
    // The swatch follows the reader's text size, like the hex and name beside it.
    @ScaledMetric(relativeTo: .caption)
    private var swatchSize: CGFloat = 14
    @Environment(\.sizeCategory)
    private var sizeCategory
    @Environment(\.stackedSwatchCells)
    private var stackedByContainer

    private var stacked: Bool { stackedByContainer || sizeCategory.isAccessibilityCategory }

    var body: some View {
        HStack(alignment: stacked ? .top : .center, spacing: BPKSpacing.sm) {
            if let color {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(color))
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color(BPKColor.lineColor), lineWidth: 1))
                    .frame(width: swatchSize, height: swatchSize)
                if stacked {
                    VStack(alignment: .leading, spacing: 0) {
                        hex(color)
                        name
                    }
                } else {
                    hex(color)
                    name
                }
            } else {
                name
            }
        }
    }

    private func hex(_ color: UIColor) -> some View {
        BPKText(color.hexString, style: .caption)
            .fixedSize()
    }

    private var name: some View {
        BPKText(swatch.name, style: .caption)
            .foregroundColor(.textSecondaryColor)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
    }
}

/// Set by narrow containers (a phone screen) so every cell stacks hex over name instead of wrapping.
private struct StackedSwatchCellsKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var stackedSwatchCells: Bool {
        get { self[StackedSwatchCellsKey.self] }
        set { self[StackedSwatchCellsKey.self] = newValue }
    }
}

private extension UIColor {
    /// Hex of the colour; translucent colours also show their opacity, since the hex alone would mislead.
    var hexString: String {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let channels = [red, green, blue].map { Int(round($0 * 255)) }
        let rgb = String(format: "#%02X%02X%02X", channels[0], channels[1], channels[2])
        let percent = Int(round(alpha * 100))
        return percent < 100 ? "\(rgb) \(percent)%" : rgb
    }
}
