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

/// A Group of chips that allows multiple chips to be selected at a time.
public struct BPKMultiSelectChipGroup: View {
    private let chips: [ChipItem]
    private let style: BPKChipStyle
    private let type: ChipGroupType
    private var insetSpacing: (Edge.Set, BPKSpacing)
    
    public init(
        chips: [ChipItem],
        style: BPKChipStyle = .default,
        type: ChipGroupType = .rail(stickyChip: nil)
    ) {
        self.chips = chips
        self.style = style
        self.type = type
        self.insetSpacing = (.all, .none)
    }
    
    public var body: some View {
        switch type {
        case let .rail(stickyChip):
            HStack(spacing: BPKSpacing.none) {
                if let stickyChip {
                    BPKStickyChip(stickyChip: stickyChip, style: style)
                    Color(BPKColor.lineColor)
                        .frame(width: 1)
                        .frame(height: .xl)
                        .padding(.leading, .md)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: .md) {
                        ForEach(chips, id: \.self, content: chip(for:))
                    }
                    .padding(1) // to account for chip outlines
                    .if(stickyChip != nil, transform: {
                        $0.padding(.leading, .md)
                    })
                        .padding(.vertical, .sm)
                        .padding(insetSpacing.0, insetSpacing.1)
                }
            }
        case .wrap(let alignment):
            BPKFlowStackView(
                data: chips,
                alignment: alignment
            ) { element, _ in
                chip(for: element)
            }
        }
    }
    
    func insetPadding(_ edges: Edge.Set = .all, _ spacing: BPKSpacing) -> BPKMultiSelectChipGroup {
        var result = self
        result.insetSpacing = (edges, spacing)
        return result
    }
    
    @ViewBuilder
    private func chip(for chip: ChipItem) -> some View {
        switch chip.type {
        case .option, .dropdown:
            BPKChip(
                chip.text,
                icon: chip.icon,
                selected: chip.selected,
                style: style,
                onClick: chip.onClick
            )
        case .dismiss:
            BPKDismissableChip(
                chip.text,
                icon: chip.icon,
                style: style,
                onClick: chip.onClick
            )
        }
    }
}

public extension BPKMultiSelectChipGroup.ChipItem {
    enum ChipType {
        case option, dropdown, dismiss
    }
}

public extension BPKMultiSelectChipGroup {
    enum ChipGroupType {
        case rail(stickyChip: StickyChipItem?)
        case wrap(alignment: HorizontalAlignment)
    }
    
    struct StickyChipItem {
        let accessibilityLabel: String
        let icon: BPKIcon
        let selected: Bool
        let onClick: () -> Void
        
        public init(
            accessibilityLabel: String,
            icon: BPKIcon,
            selected: Bool,
            onClick: @escaping () -> Void
        ) {
            self.accessibilityLabel = accessibilityLabel
            self.icon = icon
            self.selected = selected
            self.onClick = onClick
        }
    }
    
    struct ChipItem: Hashable {
        let text: String
        let icon: BPKIcon?
        var type: ChipType
        var selected: Bool
        let onClick: () -> Void
        
        public init(
            text: String,
            icon: BPKIcon? = nil,
            type: ChipType = .option,
            selected: Bool,
            onClick: @escaping () -> Void
        ) {
            self.text = text
            self.icon = icon
            self.type = type
            self.selected = selected
            self.onClick = onClick
        }
        
        public static func == (lhs: ChipItem, rhs: ChipItem) -> Bool {
            lhs.text == rhs.text &&
            lhs.icon?.name == rhs.icon?.name &&
            lhs.type == rhs.type &&
            lhs.selected == rhs.selected
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(text)
            hasher.combine(icon?.name)
            hasher.combine(type)
            hasher.combine(selected)
        }
    }
}

struct BPKMultiSelectChipGroup_Previews: PreviewProvider {
    
    static let chips: [BPKMultiSelectChipGroup.ChipItem] = [
        .init(text: "Shenzhen", selected: false, onClick: {}),
        .init(text: "London", selected: false, onClick: {}),
        .init(text: "Edinburgh", selected: true, onClick: {}),
        .init(text: "Manchester", selected: false, onClick: {}),
        .init(text: "Belfast", selected: true, onClick: {}),
        .init(text: "Glasgow", selected: false, onClick: {}),
        .init(text: "Gurham", selected: false, onClick: {})
    ]
    
    static var previews: some View {
        VStack {
            BPKText("Rail", style: .heading3)
            BPKMultiSelectChipGroup(
                chips: chips,
                type: .rail(stickyChip: BPKMultiSelectChipGroup.StickyChipItem(
                    accessibilityLabel: "Filters",
                    icon: .filter,
                    selected: false,
                    onClick: {}
                ))
            )
            .padding()
            BPKMultiSelectChipGroup(
                chips: chips,
                style: .onDark
            )
            .padding()
            .background(.surfaceContrastColor)
            BPKMultiSelectChipGroup(
                chips: chips,
                style: .onImage
            )
            .padding()
            .background(.statusSuccessSpotColor)
        }
        .previewDisplayName("Rail")
        
        wrapExampleGroup(alignment: .leading)
            .previewDisplayName("Wrap")
        
        wrapExampleGroup(alignment: .center)
            .previewDisplayName("Wrap-Center")
    }
    
    static func wrapExampleGroup(alignment: HorizontalAlignment) -> some View {
        VStack {
            BPKText("Wrap", style: .heading3)
            BPKMultiSelectChipGroup(chips: chips, type: .wrap(alignment: alignment))
            .padding()
            
            BPKMultiSelectChipGroup(chips: chips, style: .onDark, type: .wrap(alignment: alignment))
            .padding()
            .background(.surfaceContrastColor)
            
            BPKMultiSelectChipGroup(chips: chips, style: .onImage, type: .wrap(alignment: alignment))
            .padding()
            .background(.statusSuccessSpotColor)
        }
    }
}
