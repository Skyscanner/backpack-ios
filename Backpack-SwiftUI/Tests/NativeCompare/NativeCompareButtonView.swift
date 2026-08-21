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

/// Side by side: BPKButton (left) against the stock SwiftUI button for the same job (right),
/// the SwiftUI one tinted with Backpack semantic tokens only. No button configuration: the app
/// does not run with one.
///
/// Lives in the snapshot test target only (one image per pair). Nothing here ships in Backpack_SwiftUI.
struct NativeCompareButtonView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: BPKSpacing.base) {
                ForEach(ButtonComparison.allCases, id: \.self) { pair in
                    NativeCompareButtonRow(pair: pair)
                }
            }
            .padding()
        }
        .background(BPKColor.canvasColor)
        // A phone screen is too narrow for single-line cells; the 720pt snapshots are not.
        .environment(\.stackedSwatchCells, true)
    }
}

/// One comparison: header, the pair in enabled and disabled state, and the colour legend.
struct NativeCompareButtonRow: View {
    let pair: ButtonComparison

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
            ForEach([true, false], id: \.self) { enabled in
                twoColumns(alignment: .center) {
                    BPKButton("Button", enabled: .constant(enabled)) {}
                        .buttonStyle(pair.bpkStyle)
                } native: {
                    pair.native(enabled: enabled)
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
