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

/// A Group of chips that allows a single chip to be selected at a time.
public struct BPKSingleSelectChipGroup: View {
    private let chips: [ChipItem]
    private let style: BPKChipStyle
    private let type: BPKChipGroupType
    private let onItemClick: (_ index: Int) -> Void
    
    @Binding private var selectedIndex: Int?
    
    public init(
        chips: [ChipItem],
        style: BPKChipStyle = .default,
        selectedIndex: Binding<Int?>,
        type: BPKChipGroupType = .rail,
        onItemClick: @escaping (_ index: Int) -> Void
    ) {
        self.chips = chips
        self.style = style
        self._selectedIndex = selectedIndex
        self.type = type
        self.onItemClick = onItemClick
    }
    
    public var body: some View {
        switch type {
        case .rail:
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: .md) {
                    chipsListView
                }
            }
        case .wrap:
            FlowStackView(spacing: .init(width: .md, height: .md)) {
                chipsListView
            }
        }
    }
    
    private var chipsListView: some View {
        ForEach(0..<chips.count, id: \.self) { index in
            BPKChip(
                chips[index].text,
                icon: chips[index].icon,
                selected: selectedIndex == index,
                style: style) {
                    selectedIndex = index
                    onItemClick(index)
                }
        }
    }
}

public extension BPKSingleSelectChipGroup {
    struct ChipItem {
        let text: String
        let icon: BPKIcon?
        
        public init(text: String, icon: BPKIcon? = nil) {
            self.text = text
            self.icon = icon
        }
    }
}

struct BPKChipGroup_Previews: PreviewProvider {
    
    static var previews: some View {
        let chips: [BPKSingleSelectChipGroup.ChipItem] = [
            .init(text: "Shenzhen", icon: .city),
            .init(text: "London", icon: .city),
            .init(text: "Edinburgh"),
            .init(text: "Manchester"),
            .init(text: "Belfast"),
            .init(text: "Glasgow"),
            .init(text: "Gurham")
        ]
            VStack {
                BPKText("Rail", style: .heading3)
                BPKSingleSelectChipGroup(
                    chips: chips,
                    selectedIndex: .constant(2)
                ) { _ in }
                    .padding()
                BPKSingleSelectChipGroup(
                    chips: chips,
                    style: .onDark,
                    selectedIndex: .constant(2)
                ) { _ in }
                    .padding()
                    .background(.surfaceContrastColor)
                BPKSingleSelectChipGroup(
                    chips: chips,
                    style: .onImage,
                    selectedIndex: .constant(2)
                ) { _ in }
                    .padding()
                    .background(.statusSuccessSpotColor)
            }
            VStack {
                BPKText("Wrap", style: .heading3)
                BPKSingleSelectChipGroup(
                    chips: chips,
                    selectedIndex: .constant(2),
                    type: .wrap
                ) { _ in }
                    .padding()
                BPKSingleSelectChipGroup(
                    chips: chips,
                    style: .onDark,
                    selectedIndex: .constant(2),
                    type: .wrap
                ) { _ in }
                    .padding()
                    .background(.surfaceContrastColor)
                
                BPKSingleSelectChipGroup(
                    chips: chips,
                    style: .onImage,
                    selectedIndex: .constant(2),
                    type: .wrap
                ) { _ in }
                    .padding()
                    .background(.statusSuccessSpotColor)
            }
        }
}
