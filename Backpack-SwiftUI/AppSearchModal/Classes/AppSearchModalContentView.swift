/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2023 Skyscanner Ltd
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

struct AppSearchModalContentView: View {
    let state: BPKAppSearchModalContent
    let onScroll: (_ offset: CGPoint) -> Void
    var body: some View {
        
        ObservableScrollView { point in
            if !CGPoint.compare(point, .zero, decimalPlaces: 5) {
                onScroll(point)
            }
        } content: {
            VStack(spacing: .base) {
                if let shortcuts = state.shortcuts, !shortcuts.isEmpty {
                    makeShortcuts(shortcuts)
                }
                ForEach(state.sections, id: \.self) {
                    makeSections($0)
                }
            }
        }
    }
    
    private func makeShortcuts(
        _ shortcuts: [BPKAppSearchModalContent.Shortcut]
    ) -> some View {
        BPKSingleSelectChipGroup(
            chips: shortcuts.map({ BPKSingleSelectChipGroup.ChipItem( text: $0.text, icon: $0.icon) }),
            selectedIndex: .constant(nil),
            onItemClick: { shortcuts[$0].onShortcutSelected() }
        )
        .insetPadding(.horizontal, .base)
    }
    
    private func makeSections(_ section: BPKAppSearchModalContent.Section) -> some View {
        VStack(spacing: BPKSpacing.none) {
            if let heading = section.heading {
                HStack {
                    BPKText(heading.title, style: .label1)
                        .accessibilityAddTraits(.isHeader)
                    Spacer()
                    if let action = heading.action {
                        BPKButton(action.text, action: action.onActionSelected)
                            .buttonStyle(.link)
                    }
                }
                .padding(.horizontal, .base)
            }
            ForEach(section.items, id: \.self) { item in
                ItemCell(item: item)
            }
        }
    }
    
    struct ItemCell: View {
        @Environment(\.sizeCategory) var sizeCategory

        let item: BPKAppSearchModalContent.Item
        
        var body: some View {
            Button(action: item.onItemSelected) {
                HStack(spacing: .base) {
                    BPKIconView(item.icon, size: .large)
                    VStack(alignment: .leading) {
                        BPKText(item.title, style: .bodyDefault)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                        if let subtitle = item.subtitle {
                            BPKText(subtitle, style: .footnote)
                                .lineLimit(subtitleLineLimit())
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.vertical, .base)
                    Spacer()
                    if let tertiary = item.tertiaryLabel {
                        BPKText(tertiary, style: .footnote)
                            .foregroundColor(.textSecondaryColor)
                    }
                }
                .padding(.horizontal, .base)
                .contentShape(Rectangle())
            }
            .buttonStyle(ItemCellButtonStyle())
        }
        
        private func subtitleLineLimit() -> Int? {
            let isDefaultSizeOrSmaller = sizeCategory <= .large
            return isDefaultSizeOrSmaller ? 2 : nil
        }
    }
    
    // We use a color with 0 alpha to avoid a 'flicker' issue
    // when tapping ends. Using BPKColor.clear will show a darker
    // gray color when tap ends
    struct ItemCellButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .background(configuration.isPressed ? .canvasContrastColor : .canvasContrastColor.withAlphaComponent(0))
        }
    }
}

struct AppSearchModalContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppSearchModalContentView(state: .init(
            sections: (0..<3).map(buildSection),
            shortcuts: (0..<4).map(buildShortcut)
        ), onScroll: { _ in })
    }
    
    static func buildSection(with index: Int) -> BPKAppSearchModalContent.Section {
        return .init(
            heading: .init(title: "Section \(index + 1)", action: .init(text: "Action", onActionSelected: { })),
            items: (0..<3).map(buildItem)
        )
    }
    
    static func buildItem(with index: Int) -> BPKAppSearchModalContent.Item {
        return .init(
            title: "Item No.\(index + 1)",
            subtitle: nil,
            tertiaryLabel: "City",
            icon: .recentSearches,
            onItemSelected: {}
        )
    }
    
    static func buildShortcut(with index: Int) -> BPKAppSearchModalContent.Shortcut {
        return .init(text: "Shortcut \(index + 1)", icon: .landmark, onShortcutSelected: { })
    }
}

private extension CGFloat {
    // Function to round a CGFloat to a specified number of decimal places
    func roundToDecimal(places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}

private extension CGPoint {
    // Function to round a CGPoint to a certain number of decimal places
    func roundToDecimal(_ point: CGPoint, decimalPlaces: Int) -> CGPoint {
        let roundedX = point.x.roundToDecimal(places: decimalPlaces)
        let roundedY = point.y.roundToDecimal(places: decimalPlaces)
        return CGPoint(x: roundedX, y: roundedY)
    }
    
    // Function to compare two CGPoint values with precision
    static func compare(_ lhs: CGPoint, _ rhs: CGPoint, decimalPlaces: Int) -> Bool {
        let roundedPoint1 = lhs.roundToDecimal(lhs, decimalPlaces: decimalPlaces)
        let roundedPoint2 = rhs.roundToDecimal(rhs, decimalPlaces: decimalPlaces)
        return roundedPoint1 == roundedPoint2
    }
}
