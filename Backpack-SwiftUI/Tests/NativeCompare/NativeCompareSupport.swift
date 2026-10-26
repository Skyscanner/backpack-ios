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

/// One Backpack component variant set against the stock SwiftUI control for the same job, the stock
/// one carrying Backpack SEMANTIC tokens only. Each case is one pair and one snapshot.
///
/// Everything here lives in the snapshot test target only, which is what lets it read the library's
/// internal colours through @testable import, so no hex is written. Nothing ships in Backpack_SwiftUI.
protocol NativeComparison: CaseIterable, Hashable {
    /// Heading of the pair.
    var label: String { get }
    /// The difference between the two, in one sentence.
    var difference: String { get }
    /// What the Backpack component paints with today.
    var bpkSwatches: [Swatch] { get }
    /// What the native column paints with: semantic tokens only.
    var nativeSwatches: [Swatch] { get }
    /// The pair, one entry per visual row (for example one row per enabled state).
    var columns: [ComparisonColumns] { get }
}

/// Backpack at the leading edge, the native control at the trailing half.
struct ComparisonColumns {
    let backpack: AnyView
    let native: AnyView

    init<Backpack: View, Native: View>(
        @ViewBuilder backpack: () -> Backpack,
        @ViewBuilder native: () -> Native
    ) {
        self.backpack = AnyView(backpack())
        self.native = AnyView(native())
    }
}

/// Every pair of one comparison, stacked, as a phone screen would show them.
struct NativeCompareView<Comparison: NativeComparison>: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: BPKSpacing.base) {
                ForEach(Array(Comparison.allCases), id: \.self) { pair in
                    NativeCompareRow(pair: pair)
                }
            }
            .padding()
        }
        .background(BPKColor.canvasColor)
        // A phone screen is too narrow for single-line cells; the 720pt snapshots are not.
        .environment(\.stackedSwatchCells, true)
    }
}

/// One comparison: header, the difference, the pair side by side, and the colour legend.
struct NativeCompareRow<Comparison: NativeComparison>: View {
    let pair: Comparison

    var body: some View {
        VStack(alignment: .leading, spacing: BPKSpacing.sm) {
            BPKText(pair.label, style: .heading5)
            BPKText(pair.difference, style: .footnote)
                .foregroundColor(.textSecondaryColor)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            twoColumns(alignment: .center) {
                BPKText("Backpack", style: .label2)
            } native: {
                BPKText("Native (SwiftUI)", style: .label2)
            }
            ForEach(Array(pair.columns.enumerated()), id: \.offset) { _, columns in
                twoColumns(alignment: .center) {
                    columns.backpack
                } native: {
                    columns.native
                }
            }
            ComparisonTable(backpack: pair.bpkSwatches, native: pair.nativeSwatches)
        }
        .padding(.vertical, .base)
        .padding(.horizontal, .base)
        .background(BPKColor.canvasColor)
    }

    /// Backpack at the leading edge, the native component at the trailing half, a fixed gap between.
    private func twoColumns<Leading: View, Trailing: View>(
        alignment: VerticalAlignment,
        @ViewBuilder backpack: () -> Leading,
        @ViewBuilder native: () -> Trailing
    ) -> some View {
        HStack(alignment: alignment, spacing: BPKSpacing.lg) {
            backpack().frame(maxWidth: .infinity, alignment: .leading)
            native().frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

/// One line of the colour legend under a pair: the state, the colour, its hex in the current
/// mode, and what design knows it as (the Figma variable name, or "component-only colour").
struct Swatch: Identifiable {
    enum Source {
        case token(Backpack_SwiftUI.BPKColor)
        case componentOnly(Backpack_SwiftUI.BPKColor)
        case platform
    }

    let state: String
    let name: String
    let source: Source
    var id: String { state + name }

    static func token(_ state: String, _ figmaName: String, _ color: Backpack_SwiftUI.BPKColor) -> Swatch {
        Swatch(state: state, name: figmaName, source: .token(color))
    }

    /// A component-only value, read from the library's internal colour so light and dark stay in sync.
    static func componentOnly(_ state: String, _ color: Backpack_SwiftUI.BPKColor, note: String = "") -> Swatch {
        let name = note.isEmpty ? "component-only" : "component-only, \(note)"
        return Swatch(state: state, name: name, source: .componentOnly(color))
    }

    static func platform(_ state: String, note: String = "") -> Swatch {
        let name = note.isEmpty ? "from the platform" : "from the platform, \(note)"
        return Swatch(state: state, name: name, source: .platform)
    }

    func uiColor(for scheme: ColorScheme) -> UIColor? {
        let traits = UITraitCollection(userInterfaceStyle: scheme == .dark ? .dark : .light)
        switch source {
        case .token(let color), .componentOnly(let color):
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

    /// Wraps rather than truncates, so a long state name ("Selected text") stays readable.
    private func secondary(_ text: String) -> some View {
        BPKText(text, style: .caption)
            .foregroundColor(.textSecondaryColor)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
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

extension UIColor {
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
