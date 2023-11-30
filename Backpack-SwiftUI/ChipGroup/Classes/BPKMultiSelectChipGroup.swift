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
    
    public init(
        chips: [ChipItem],
        style: BPKChipStyle = .default,
        type: ChipGroupType = .rail(stickyChip: nil)
    ) {
        self.chips = chips
        self.style = style
        self.type = type
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
                        chipsListView
                    }
                    .if(stickyChip != nil, transform: {
                        $0.padding(.leading, .md)
                    })
                        .padding(.vertical, .sm)
                }
            }
        case .wrap:
            BPKFlowStackView {
                chipsListView
            }
        }
    }
    
    private var chipsListView: some View {
        ForEach(0..<chips.count, id: \.self) { index in
            chip(for: chips[index])
        }
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
        case wrap
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
    
    struct ChipItem {
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
    }
}

struct BPKMultiSelectChipGroup_Previews: PreviewProvider {
    
    static var previews: some View {
        let chips: [BPKMultiSelectChipGroup.ChipItem] = [
            .init(text: "Shenzhen", selected: false, onClick: {}),
            .init(text: "London", selected: false, onClick: {}),
            .init(text: "Edinburgh", selected: true, onClick: {}),
            .init(text: "Manchester", selected: false, onClick: {}),
            .init(text: "Belfast", selected: true, onClick: {}),
            .init(text: "Glasgow", selected: false, onClick: {}),
            .init(text: "Gurham", selected: false, onClick: {})
        ]
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
        VStack {
            BPKText("Wrap", style: .heading3)
            BPKMultiSelectChipGroup(
                chips: chips,
                type: .wrap
            )
            .padding()
            BPKMultiSelectChipGroup(
                chips: chips,
                style: .onDark,
                type: .wrap
            )
            .padding()
            .background(.surfaceContrastColor)
            
            BPKMultiSelectChipGroup(
                chips: chips,
                style: .onImage,
                type: .wrap
            )
            .padding()
            .background(.statusSuccessSpotColor)
        }
    }
}
