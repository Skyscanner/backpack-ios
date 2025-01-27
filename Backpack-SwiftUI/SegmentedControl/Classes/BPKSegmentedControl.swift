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
    private let segmentHeight: CGFloat = 32
    @Namespace var namespace

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
        style: Style = .defaultStyle
    ) {
        // Limit the number of items to 4
        self.items = Array(items.prefix(4))
        self.accessibilityLabel = accessibilityLabel
        self.style = style
        _selectedIndex = selectedIndex
    }

    public var body: some View {
        ZStack {
            HStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    segmentButton(for: index)
                        .matchedGeometryEffect(id: index, in: namespace, isSource: true)
                }
            }
            .background {
                Rectangle()
                    .fill(Color(style.selectedBgColor))
                    .matchedGeometryEffect(id: selectedIndex, in: namespace, isSource: false)
            }
            .background(Color(style.bgColor))
            .animation(.spring(duration: 0.25), value: selectedIndex)
            .cornerRadius(8)
            .padding()
            .accessibilityIdentifier(accessibilityLabel)
            .frame(height: segmentHeight)
        }
    }

    @ViewBuilder
    private func segmentButton(for index: Int) -> some View {
        HStack(spacing: 0) {
            Button(
                action: { withAnimation { selectedIndex = index } },
                label: {
                    Text(items[index])
                        .font(style: .label2)
                        .frame(maxWidth: .infinity, minHeight: segmentHeight)
                        .foregroundColor(selectedIndex == index ? style.selectedTextColor : style.textColor)
                        .accessibilityIdentifier("\(accessibilityLabel)_\(index)")
                        .accessibilityAddTraits(selectedIndex == index ? .isSelected : [])
                }
            )
            .frame(maxHeight: .infinity)

            if index < items.count - 1 && selectedIndex != index && selectedIndex != index + 1 {
                separator
            }
        }
    }

    private var separator: some View {
        Rectangle()
            .fill(Color(.lineColor))
            .frame(width: 1, height: segmentHeight)
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
    BPKSegmentedControl(items: ["1", "2", "3", "4"], selectedIndex: .constant(3), accessibilityLabel: "example_label")
}
