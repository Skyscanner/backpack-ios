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

/// BPKSegmentedControl against the stock SwiftUI Picker in its segmented style. The segmented Picker
/// ignores tint and font, so the native column carries no token at all.
enum SegmentedControlComparison: NativeComparison {
    case onCanvas
    case onSurfaceContrast

    private static let items = ["One", "Two", "Three"]

    var label: String {
        switch self {
        case .onCanvas: return "Segmented control, default style"
        case .onSurfaceContrast: return "Segmented control, surface contrast style"
        }
    }

    var difference: String {
        switch self {
        case .onCanvas:
            return "Backpack fills the selected segment with Core / Primary on a Canvas / Contrast track. "
                + "The stock segmented picker ignores tint and font, so it keeps the platform grey and white."
        case .onSurfaceContrast:
            return "Backpack uses two component-only fills with Text / On dark labels. "
                + "The stock segmented picker has no on-dark variant short of forcing dark mode."
        }
    }

    var bpkSwatches: [Swatch] {
        switch self {
        case .onCanvas:
            return [
                .token("Track", "Canvas / Contrast", .canvasContrastColor),
                .token("Text", "Text / Primary", .textPrimaryColor),
                .token("Selected", "Core / Primary", .corePrimaryColor),
                .token("Selected text", "Text / On dark", .textOnDarkColor),
                .token("Divider", "Line", .lineColor)
            ]
        case .onSurfaceContrast:
            return [
                .componentOnly("Track", .segmentedControlSurfaceContrastColor),
                .token("Text", "Text / On dark", .textOnDarkColor),
                .componentOnly("Selected", .segmentedControlSurfaceContrastOnColor),
                .token("Selected text", "Text / On dark", .textOnDarkColor),
                .token("Divider", "Line", .lineColor)
            ]
        }
    }

    var nativeSwatches: [Swatch] {
        [
            .platform("Track"),
            .platform("Text"),
            .platform("Selected"),
            .platform("Selected text"),
            .platform("Divider")
        ]
    }

    var columns: [ComparisonColumns] {
        switch self {
        case .onCanvas:
            return [
                ComparisonColumns {
                    BPKSegmentedControl(
                        items: Self.items,
                        selectedIndex: .constant(0),
                        accessibilityLabel: "segments"
                    )
                } native: {
                    Self.picker
                }
            ]
        case .onSurfaceContrast:
            return [
                ComparisonColumns {
                    BPKSegmentedControl(
                        items: Self.items,
                        selectedIndex: .constant(0),
                        accessibilityLabel: "segments",
                        style: .surfaceContrastStyle
                    )
                    .padding(.md)
                    .background(BPKColor.surfaceContrastColor)
                } native: {
                    Self.picker
                        .padding(.md)
                        .background(BPKColor.surfaceContrastColor)
                }
            ]
        }
    }

    private static var picker: some View {
        Picker("Segments", selection: .constant(0)) {
            ForEach(items.indices, id: \.self) { index in
                Text(items[index]).tag(index)
            }
        }
        .pickerStyle(.segmented)
    }
}
