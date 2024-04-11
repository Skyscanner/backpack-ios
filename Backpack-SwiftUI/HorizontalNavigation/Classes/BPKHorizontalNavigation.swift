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

public extension BPKHorizontalNavigation {
    enum Size {
        case `default`
        case small
        
        var titleStyle: BPKFontStyle {
            switch self {
            case .default: return .label1
            case .small: return .label2
            }
        }
        
        var verticalPadding: CGFloat {
            switch self {
            case .default: return 12
            case .small: return BPKSpacing.md.value
            }
        }
    }
    
    struct Tab {
        let title: String
        let icon: BPKIcon?
        
        public init(title: String, icon: BPKIcon? = nil) {
            self.title = title
            self.icon = icon
        }
    }
}

public struct BPKHorizontalNavigation: View {
    let tabs: [Tab]
    let size: Size
    @Binding var selectedTab: Int
    
    public init(tabs: [Tab], size: Size = .default, selectedTab: Binding<Int>) {
        self.tabs = tabs
        self.size = size
        _selectedTab = selectedTab
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: BPKSpacing.none) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Button {
                        withAnimation {
                            selectedTab = index
                        }
                    } label: {
                        TabCellView(
                            tab: tabs[index],
                            isSelected: selectedTab == index,
                            size: size
                        )
                    }
                }
            }
            .padding(.vertical, size.verticalPadding)
            
            GeometryReader { proxy in
                Color(.coreAccentColor)
                    .frame(width: proxy.size.width / CGFloat(tabs.count))
                    .offset(x: proxy.size.width / CGFloat(tabs.count) * CGFloat(selectedTab))
            }
            .frame(height: 2)
        }
        .background(.surfaceDefaultColor)
    }
    
    struct TabCellView: View {
        let tab: Tab
        let isSelected: Bool
        let size: Size
        
        var body: some View {
            HStack(spacing: .md) {
                if let icon = tab.icon {
                    BPKIconView(icon)
                        .foregroundColor(foregroundColor)
                }
                BPKText(tab.title, style: size.titleStyle)
                    .foregroundColor(foregroundColor)
            }
            .frame(maxWidth: .infinity)
        }
        
        private var foregroundColor: BPKColor {
            isSelected ? .coreAccentColor : .textPrimaryColor
        }
    }
}
    
struct BPKHorizontalNavigation_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKHorizontalNavigation(
                tabs: [.init(title: "One"), .init(title: "Two"), .init(title: "Three")],
                selectedTab: .constant(1)
            )
            BPKHorizontalNavigation(
                tabs: [
                    .init(title: "One", icon: .flight),
                    .init(title: "Two", icon: .flight),
                    .init(title: "Three", icon: .flight)
                ],
                selectedTab: .constant(1)
            )
            BPKHorizontalNavigation(
                tabs: [.init(title: "One"), .init(title: "Two"), .init(title: "Three")],
                size: .small,
                selectedTab: .constant(2)
            )
            BPKHorizontalNavigation(
                tabs: [
                    .init(title: "One", icon: .flight),
                    .init(title: "Two", icon: .flight),
                    .init(title: "Three", icon: .flight)
                ],
                size: .small,
                selectedTab: .constant(0)
            )
        }
    }
}
