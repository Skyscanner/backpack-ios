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
public struct BPKSegmentedControl: View {
    private var items: [String]
    private var accessibilityLabel: String
    @Binding private var selectedIndex: Int

    /// Creates a Segment Control that generates its labels from a list of Strings
    ///
    /// - Parameters:
    ///   - items: An Array of Strings that describes the purpose of each segment. Limited to 4 items.
    ///   - selectedIndex: A binding to an Int that indicates which segment is selected
    ///   - accessibilityLabel: A string used to identify the component and each segment
    public init(items: [String], selectedIndex: Binding<Int>, accessibilityLabel: String) {
        // Limit the number of items to 4
        self.items = Array(items.prefix(4))
        self.accessibilityLabel = accessibilityLabel
        _selectedIndex = selectedIndex
        let appearance = UISegmentedControl.appearance()
        appearance.selectedSegmentTintColor = BPKColor.corePrimaryColor.value
        appearance.backgroundColor = BPKColor.segmentedControlCanvasDefaultColor.value
        appearance.setTitleTextAttributes([.foregroundColor: BPKColor.textOnDarkColor.value], for: .selected)
        appearance.setTitleTextAttributes([.foregroundColor: BPKColor.textPrimaryColor.value], for: .normal)
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
}

#Preview {
    BPKSegmentedControl(items: ["1", "2", "3"], selectedIndex: .constant(0), accessibilityLabel: "example_label")
}
