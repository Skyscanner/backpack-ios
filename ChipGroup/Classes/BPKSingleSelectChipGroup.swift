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

public struct BPKSingleSelectChipGroup: View {
    let chips: [BPKSingleChipItem]
    let style: BPKChipStyle
    let type: BPKChipGroupType
    let onItemClick: () -> Void
    
    @State var selectedIndex: Int
    
    public init(
        chips: [BPKSingleChipItem],
        style: BPKChipStyle = .default,
        selectedIndex: Int = 0,
        type: BPKChipGroupType = .rail,
        onItemClick: @escaping () -> Void
    ) {
        self.chips = chips
        self.style = style
        self.selectedIndex = selectedIndex
        self.type = type
        self.onItemClick = onItemClick
    }
    
    public var body: some View {
        switch type {
        case .rail:
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack {
                    ForEach(0..<chips.count, id: \.self) { index in
                        BPKChipItem(
                            chips[index],
                            selected: selectedIndex == index,
                            style: style
                        ) {
                            selectedIndex = index
                            self.onItemClick()
                        }
                    }
                }
                .padding(.md)
            })
        case .wrap:
            GeometryReader { geometry in
                generateContent(in: geometry)
                    .padding(.sm)
            }
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(0..<chips.count, id: \.self) { index in
                makeChipItem(offset: index)
                    .alignmentGuide(.leading) { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if index == chips.count - 1 {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { demision in
                        let result = height
                        if index == chips.count - 1 {
                            height = 0
                        }
                        return result
                    }
            }
        }
    }
    
    private func makeChipItem(offset index: Int) -> some View {
        BPKChipItem(
            chips[index],
            selected: selectedIndex == index,
            style: style
        ) {
            selectedIndex = index
            self.onItemClick()
        }
        .padding([.horizontal, .vertical], .sm)
    }
}

struct BPKChipGroup_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            BPKSingleSelectChipGroup(chips: [
                BPKSingleChipItem(text: "Shenzhen", icon: .city),
                BPKSingleChipItem(text: "London", icon: .city),
                BPKSingleChipItem(text: "Edinburgh"),
                BPKSingleChipItem(text: "Manchester"),
                BPKSingleChipItem(text: "Belfast"),
                BPKSingleChipItem(text: "Glasgow"),
                BPKSingleChipItem(text: "Gurham"),
            ], type: .wrap) {}
            
            BPKSingleSelectChipGroup(chips: [
                BPKSingleChipItem(text: "Shenzhen", icon: .city),
                BPKSingleChipItem(text: "London", icon: .city),
                BPKSingleChipItem(text: "Edinburgh"),
                BPKSingleChipItem(text: "Manchester"),
                BPKSingleChipItem(text: "Belfast"),
                BPKSingleChipItem(text: "Glasgow"),
                BPKSingleChipItem(text: "Gurham"),
            ], style: .onDark, type: .wrap) {}
                .background(.surfaceContrastColor)
            
            BPKSingleSelectChipGroup(chips: [
                BPKSingleChipItem(text: "Shenzhen", icon: .city),
                BPKSingleChipItem(text: "London", icon: .city),
                BPKSingleChipItem(text: "Edinburgh"),
                BPKSingleChipItem(text: "Manchester"),
                BPKSingleChipItem(text: "Belfast"),
                BPKSingleChipItem(text: "Glasgow"),
                BPKSingleChipItem(text: "Gurham"),
            ], style: .onImage, type: .wrap) {}
                .background(.statusSuccessSpotColor)
            
        }
    }
}
