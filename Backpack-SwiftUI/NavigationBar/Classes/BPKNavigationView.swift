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

public struct BPKNavigationView<Content: View>: View {
    let title: String?
    let style: BPKNavigationBarStyle
    let leadingItems: [BPKNavigationBarItem]
    let trailingItems: [BPKNavigationBarItem]
    let scrollable: Bool
    let content: () -> Content
    let safeAreasToIgnore: Edge.Set
    
    @State private var expanded: Bool
    @State private var offset: CGFloat = -1
    
    public init(
        title: String? = nil,
        leadingItems: [BPKNavigationBarItem] = [],
        trailingItems: [BPKNavigationBarItem] = [],
        style: BPKNavigationBarStyle = .default,
        scrollable: Bool = true,
        ignoresBottomSafeArea: Bool = false,
        content: @escaping () -> Content
    ) {
        self.title = title
        self.style = style
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
        _expanded = State(initialValue: style.supportsLargeTitle)
        self.scrollable = scrollable
        safeAreasToIgnore = ignoresBottomSafeArea ? .bottom : []
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { proxy in
            resolvedContent
                .overlay {
                    navBarOverlay(readerProxy: proxy)
                }
        }
        .ignoresSafeArea(edges: style.safeAreasToIgnore)
        .ignoresSafeArea(edges: safeAreasToIgnore)
    }
    
    @ViewBuilder
    private var resolvedContent: some View {
        if scrollable {
            NavBarScrollViewWithOffset(
                style: style,
                onScroll: onScroll(_:),
                content: content
            )
        } else {
            content()
                .offset(y: style.verticalOffset)
        }
    }
    
    private func navBarOverlay(readerProxy proxy: GeometryProxy) -> some View {
        ZStack(alignment: .top) {
            if style.supportsLargeTitle {
                ExpandedNavigationBar(
                    title: title,
                    style: style
                )
                    .offset(y: (offset < 0 ? offset : 0) + style.collapsedHeight)
            }
            Color(style.backgroundColor(expanded: expanded))
                .frame(height: proxy.safeAreaInsets.top)
                .offset(y: -proxy.safeAreaInsets.top)
            
            CollapsedNavigationBar(
                title: title,
                style: style,
                leadingItems: leadingItems,
                trailingItems: trailingItems,
                expanded: expanded
            )
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private func onScroll(_ newOffset: CGPoint) {
        if style.supportsLargeTitle {
            offset = newOffset.y
            withAnimation {
                expanded = newOffset.y > -style.expandedNavigationBarHeight
            }
        }
    }
}

struct BPKNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BPKNavigationView(
            title: "Hotels",
            leadingItems: [.init(type: .backButton("Back"), action: {})],
            trailingItems: [
                .init(type: .icon(.settings, "AI"), action: {}),
                .init(type: .icon(.faceId, "Add"), action: {})
            ],
            style: .default,
            scrollable: true,
            ignoresBottomSafeArea: true
        ) {
            VStack(spacing: 0) {
                Text("Start")
                ForEach([
                    Color.red, .blue, .yellow, .orange, .green
                ], id: \.self) { color in
                    color.frame(height: 300)
                }
                Text("End")
            }
        }
    }
}
