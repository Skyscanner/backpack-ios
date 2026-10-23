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

/// BPKHorizontalNavigation against the stock SwiftUI Picker in its segmented style with text tabs.
/// SwiftUI has no underline tab bar outside TabView, so the segmented picker is the closest stock control.
enum HorizontalNavigationComparison: NativeComparison {
    case defaultSize
    case small
    case secondary

    private static let titles = ["One", "Two", "Three"]

    var label: String {
        switch self {
        case .defaultSize: return "Horizontal navigation, default"
        case .small: return "Horizontal navigation, small"
        case .secondary: return "Horizontal navigation, secondary style"
        }
    }

    var difference: String {
        switch self {
        case .defaultSize, .small:
            return "Backpack shows the selected tab as Core / Accent text with a 2pt Core / Accent underline "
                + "on Surface / Default. The stock segmented picker ignores tint and font and has no underline."
        case .secondary:
            return "Same as default but on Canvas / Contrast. The stock segmented picker ignores tint and "
                + "font and has no underline."
        }
    }

    private var bpkStyle: BPKHorizontalNavigation.Style {
        self == .secondary ? .secondary : .default
    }

    private var bpkSize: BPKHorizontalNavigation.Size {
        self == .small ? .small : .default
    }

    private var fillFigmaName: String {
        bpkStyle == .secondary ? "Canvas / Contrast" : "Surface / Default"
    }

    var bpkSwatches: [Swatch] {
        [
            .token("Fill", fillFigmaName, bpkStyle.backgroundColour),
            .token("Text", "Text / Primary", .textPrimaryColor),
            .token("Selected text", "Core / Accent", .coreAccentColor),
            .token("Indicator", "Core / Accent", .coreAccentColor)
        ]
    }

    var nativeSwatches: [Swatch] {
        [
            .platform("Fill"),
            .platform("Text"),
            .platform("Selected text"),
            .platform("Indicator", note: "none")
        ]
    }

    var columns: [ComparisonColumns] {
        [
            ComparisonColumns {
                BPKHorizontalNavigation(
                    tabs: Self.titles.map { .init(title: $0, onClick: {}) },
                    size: bpkSize,
                    style: bpkStyle,
                    selectedTab: 1
                )
            } native: {
                Picker("Tabs", selection: .constant(1)) {
                    ForEach(Self.titles.indices, id: \.self) { index in
                        Text(Self.titles[index]).tag(index)
                    }
                }
                .pickerStyle(.segmented)
            }
        ]
    }
}
