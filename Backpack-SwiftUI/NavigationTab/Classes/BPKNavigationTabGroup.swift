/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

/// A Group of tabs that allows a single tab to be selected at a time.
public struct BPKNavigationTabGroup: View {
    private let tabs: [Item]
    private let style: BPKNavigationTabGroup.Style
    private let onItemClick: (_ index: Int) -> Void
    
    @Binding private var selectedIndex: Int
    
    public init(
        tabs: [Item],
        style: BPKNavigationTabGroup.Style = .default,
        selectedIndex: Binding<Int>,
        onItemClick: @escaping (_ index: Int) -> Void
    ) {
        self.tabs = tabs
        self.style = style
        self._selectedIndex = selectedIndex
        self.onItemClick = onItemClick
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .md) {
                ForEach(Array(tabs.enumerated()), id: \.element) { index, item in
                    tab(for: item, index: index)
                }
            }
            .padding(1) // to account for chip outlines
        }
    }
    
    @ViewBuilder
    private func tab(for tab: Item, index: Int) -> some View {
        BPKNavigationTab(
            tab.text,
            icon: tab.icon,
            selected: selectedIndex == index,
            style: style
        ) {
            onItemClick(index)
        }
        .accessibilityIdentifier(tab.accessibilityIdentifier ?? "")
    }
}

public extension BPKNavigationTabGroup {
    struct Item: Hashable {
        let text: String
        let icon: BPKIcon?
        let accessibilityIdentifier: String?
        
        public init(text: String, icon: BPKIcon? = nil, accessibilityIdentifier: String? = nil) {
            self.text = text
            self.icon = icon
            self.accessibilityIdentifier = accessibilityIdentifier
        }
        
        // swiftlint:disable line_length
        public static func == (lhs: Item, rhs: Item) -> Bool {
            lhs.text == rhs.text && lhs.icon?.name == rhs.icon?.name && lhs.accessibilityIdentifier == rhs.accessibilityIdentifier
        }
        // swiftlint:enable line_length
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(text)
            hasher.combine(icon?.name)
            hasher.combine(accessibilityIdentifier)
        }
    }
}

struct BPKNavigationTabGroup_Previews: PreviewProvider {
    
    static let tabs: [BPKNavigationTabGroup.Item] = [
        .init(text: "Explore", icon: .explore),
        .init(text: "Flights", icon: .flight),
        .init(text: "Hotels", icon: .hotels),
        .init(text: "Car Hire", icon: .cars)
    ]
    
    static var previews: some View {
        VStack {
            BPKNavigationTabGroup(
                tabs: tabs,
                selectedIndex: .constant(0)
            ) { _ in }
                .padding()
            
            BPKNavigationTabGroup(
                tabs: tabs,
                style: .onDark,
                selectedIndex: .constant(0)
            ) { _ in }
                .padding()
                .background(.surfaceContrastColor)
        }
    }
}
