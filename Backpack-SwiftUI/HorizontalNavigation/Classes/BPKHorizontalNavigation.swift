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
        let onClick: () -> Void

        public init(
            title: String,
            icon: BPKIcon? = nil,
            onClick: @escaping () -> Void
        ) {
            self.title = title
            self.icon = icon
            self.onClick = onClick
        }
    }
}

public struct BPKHorizontalNavigation: View {
    let tabs: [Tab]
    let size: Size
    let selectedTab: Int
    
    public init(
        tabs: [Tab],
        size: Size = .default,
        selectedTab: Int
    ) {
        self.tabs = tabs
        self.size = size
        self.selectedTab = selectedTab
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: BPKSpacing.none) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    let tab = tabs[index]
                    Button(action: tab.onClick) {
                        TabCellView(
                            tab: tab,
                            isSelected: selectedTab == index,
                            size: size
                        )
                    }
                }
            }
            .padding(.vertical, size.verticalPadding)
            
            GeometryReader { proxy in
                let width = tabsWidth(for: proxy)
                Color(.coreAccentColor)
                    .frame(width: width)
                    .animation(.default, value: selectedTab)
                    .offset(x: width * CGFloat(selectedTab))
            }
            .frame(height: 2)
        }
        .background(.surfaceDefaultColor)
    }

    private func tabsWidth(for proxy: GeometryProxy) -> CGFloat {
        proxy.size.width / CGFloat(tabs.count)
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
        let titleTabs: [BPKHorizontalNavigation.Tab] = [
            .init(title: "One", onClick: {}),
            .init(title: "Two", onClick: {}),
            .init(title: "Three", onClick: {})
        ]
        let titleAndIconTabs: [BPKHorizontalNavigation.Tab] = [
            .init(title: "One", icon: .flight, onClick: {}),
            .init(title: "Two", icon: .flight, onClick: {}),
            .init(title: "Three", icon: .flight, onClick: {})
        ]
        VStack {
            BPKHorizontalNavigation(
                tabs: titleTabs,
                selectedTab: 1
            )
            BPKHorizontalNavigation(
                tabs: titleAndIconTabs,
                selectedTab: 1
            )
            BPKHorizontalNavigation(
                tabs: titleTabs,
                size: .small,
                selectedTab: 2
            )
            BPKHorizontalNavigation(
                tabs: titleAndIconTabs,
                size: .small,
                selectedTab: 0
            )
        }
    }
}
