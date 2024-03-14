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
    
    @State private var expanded: Bool
    @State private var offset: CGFloat = -1
    
    public init(
        title: String? = nil,
        leadingItems: [BPKNavigationBarItem] = [],
        trailingItems: [BPKNavigationBarItem] = [],
        style: BPKNavigationBarStyle = .default,
        scrollable: Bool = true,
        content: @escaping () -> Content
    ) {
        self.title = title
        self.style = style
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
        _expanded = State(initialValue: style.supportsLargeTitle)
        self.scrollable = scrollable
        self.content = content
    }
    
    // swiftlint:disable closure_body_length
    public var body: some View {
        GeometryReader { reader in
            VStack {
                if scrollable {
                    ScrollViewWithOffset(
                        onScroll: { value in
                            if style.supportsLargeTitle {
                                offset = value.y
                                withAnimation(.default) {
                                    expanded = value.y > -52
                                }
                            }
                        },
                        content: {
                            content()
                                .offset(y: style.safeAreasToIgnore.contains(.top) ? 0 : style.navigationBarHeight)
                        }
                    )
                } else {
                    content()
                        .offset(y: style.safeAreasToIgnore.contains(.top) ? 0 : style.navigationBarHeight)
                }
            }
            .ignoresSafeArea(edges: style.safeAreasToIgnore)
            .overlay {
                ZStack(alignment: .top) {
                    if style.supportsLargeTitle {
                        ZStack(alignment: .leading) {
                            Color(style.backgroundColor(expanded: expanded))
                                .frame(height: 52)
                            BPKText(title ?? "", style: .heading2)
                                .foregroundColor(style.foregroundColor(expanded: expanded))
                                .padding(.top, -8)
                                .frame(height: 52)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, .base)
                        }
                        .offset(y: (offset < 0 ? offset : 0) + 44)
                    }
                    Color(style.backgroundColor(expanded: expanded))
                        .frame(height: reader.safeAreaInsets.top)
                        .offset(y: -reader.safeAreaInsets.top)
                    
                    BPKNavigationBar(
                        title: title,
                        style: style,
                        leadingItems: leadingItems,
                        trailingItems: trailingItems,
                        expanded: expanded
                    )
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

struct ScrollViewWithOffset<Content: View>: View {
    let onScroll: (_ offset: CGPoint) -> Void
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geo.frame(in: .named("scrollView")).origin
                        )
                }
                .frame(height: 0)
                content()
            }
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(
            ScrollOffsetPreferenceKey.self,
            perform: onScroll
        )
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct BPKNavigationBar: View {
    let title: String?
    let style: BPKNavigationBarStyle
    let leadingItems: [BPKNavigationBarItem]
    let trailingItems: [BPKNavigationBarItem]
    let expanded: Bool
    
    @State private var leadingItemsSize: CGSize = .zero
    @State private var trailingItemsSize: CGSize = .zero
    
    private var maxItemGroupWidth: CGFloat {
        if leadingItemsSize.width > trailingItemsSize.width {
            return leadingItemsSize.width
        }
        return trailingItemsSize.width
    }
    
    // swiftlint:disable closure_body_length
    var body: some View {
        VStack(spacing: BPKSpacing.none) {
            ZStack {
                Color(style.backgroundColor(expanded: expanded))
                    .frame(height: 44)
                HStack(spacing: .md) {
                    HStack(spacing: .base) {
                        toolbarItemView(forItems: leadingItems)
                    }
                    .modifier(ReadSizeModifier { leadingItemsSize = $0 })
                    .frame(width: maxItemGroupWidth, alignment: .leading)
                    Spacer()
                    
                    if !expanded {
                        BPKText(title ?? "", style: .heading5)
                            .foregroundColor(style.foregroundColor(expanded: expanded))
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    HStack(spacing: .base) {
                        toolbarItemView(forItems: trailingItems)
                            .padding(.trailing, .md)
                    }
                    .modifier(ReadSizeModifier { trailingItemsSize = $0 })
                    .frame(width: maxItemGroupWidth, alignment: .trailing)
                }
                .padding(.horizontal, .md)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
            }
            if !expanded, let lineColor = style.lineColor {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(lineColor)
            }
        }
    }
    
    private func iconItemView(
        withIcon icon: BPKIcon,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            BPKIconView(icon, size: .large)
        }
        .accessibilityLabel(accessibilityLabel)
        .foregroundColor(style.foregroundColor(expanded: expanded))
    }
    
    // swiftlint:disable closure_body_length
    @ViewBuilder
    private func toolbarItemView(forItems items: [BPKNavigationBarItem]) -> some View {
        ForEach(0..<items.count, id: \.self) { index in
            let item = items[index]
            switch item.type {
            case .icon(let icon, let accessibilityLabel):
                iconItemView(
                    withIcon: icon,
                    accessibilityLabel: accessibilityLabel,
                    action: item.action
                )
            case .title(let title):
                BPKButton(title, action: item.action)
                    .buttonStyle(.link)
                    .fixedSize()
            case .backButton(let accessibilityLabel):
                iconItemView(
                    withIcon: .chevronLeft,
                    accessibilityLabel: accessibilityLabel,
                    action: item.action
                )
            case .closeButton(let accessibilityLabel):
                iconItemView(
                    withIcon: .close,
                    accessibilityLabel: accessibilityLabel,
                    action: item.action
                )
            }
        }
    }
}

struct BPKNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKNavigationView(
                title: "Hotels",
                leadingItems: [.init(type: .backButton("Back"), action: {})],
                trailingItems: [
                    .init(type: .icon(.settings, "AI"), action: {}),
                    .init(type: .icon(.faceId, "Add"), action: {})
                ],
                style: .default,
                scrollable: true
            ) {
                VStack(spacing: 0) {
                    ForEach([
                        Color.red, .blue, .yellow, .orange, .green
                    ], id: \.self) { color in
                        color.frame(height: 300)
                    }
                }
            }
        }
    }
}
