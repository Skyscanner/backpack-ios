/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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

/// A linear set of mutually exclusive buttons.
///
/// You create a segmented control by providing a list of `items` that will serve as the segments' titles
/// and a `selectedIndex` binding. Bind `selectedIndex`
/// to an Int property that determines which segment is selected.
/// The colours can be customised using the`style` parameter.
public struct BPKSegmentedControl: View {
    private var items: [String]
    private var accessibilityLabel: String
    @Binding private var selectedIndex: Int
    private let style: Style

    /// Creates a Segment Control that generates its labels from a list of Strings
    ///
    /// - Parameters:
    ///   - items: An Array of Strings that describes the purpose of each segment. Limited to 4 items.
    ///   - selectedIndex: A binding to an Int that indicates which segment is selected
    ///   - accessibilityLabel: A string used to identify the component and each segment
    ///   - style: A style defining the customised colours of the component
    public init(
        items: [String],
        selectedIndex: Binding<Int>,
        accessibilityLabel: String,
        style: Style = .defaultStyle) {
        // Limit the number of items to 4
        self.items = Array(items.prefix(4))
        self.accessibilityLabel = accessibilityLabel
        _selectedIndex = selectedIndex
        self.style = style
        let appearance = UISegmentedControl.appearance()
            appearance.selectedSegmentTintColor = style.selectedBgColor.value
            appearance.backgroundColor = style.bgColor.value
            appearance.setTitleTextAttributes([.foregroundColor: style.selectedTextColor.value], for: .selected)
            appearance.setTitleTextAttributes([.foregroundColor: style.textColor.value], for: .normal)
    }

    public var body: some View {
        Picker("", selection: $selectedIndex) {
            ForEach(0..<items.count, id: \.self) { index in
                Text(self.items[index])
                    .accessibilityIdentifier("\(accessibilityLabel)_\(index)")
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, BPKSpacing.base)
        .accessibilityIdentifier(accessibilityLabel)
    }

    public struct Style {
        let bgColor: BPKColor
        let textColor: BPKColor
        let selectedBgColor: BPKColor
        let selectedTextColor: BPKColor

        public init(bgColor: BPKColor, textColor: BPKColor, selectedBgColor: BPKColor, selectedTextColor: BPKColor) {
            self.bgColor = bgColor
            self.textColor = textColor
            self.selectedBgColor = selectedBgColor
            self.selectedTextColor = selectedTextColor
        }
    }
}

// MARK: - Default component style
public extension BPKSegmentedControl.Style {
    static let defaultStyle = Self(
        bgColor: .segmentedControlCanvasDefaultColor,
        textColor: .textPrimaryColor,
        selectedBgColor: .corePrimaryColor,
        selectedTextColor: .textOnDarkColor
    )
}

#Preview {
    BPKSegmentedControl(items: ["1", "2", "3"], selectedIndex: .constant(0), accessibilityLabel: "example_label")
}
