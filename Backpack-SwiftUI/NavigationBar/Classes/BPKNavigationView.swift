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
    let content: () -> Content
    
    public init(
        title: String? = nil,
        leadingItems: [BPKNavigationBarItem] = [],
        trailingItems: [BPKNavigationBarItem] = [],
        style: BPKNavigationBarStyle = .default(.automatic),
        content: @escaping () -> Content
    ) {
        self.title = title
        self.style = style
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
        self.content = content
    }
    
    public var body: some View {
        if case .transparent = style {
            ZStack(alignment: .top) {
                content()
                BPKNavigationBar(
                    title: title,
                    style: style,
                    leadingItems: leadingItems,
                    trailingItems: trailingItems
                )
            }
        } else {
            ZStack(alignment: .top) {
                GeometryReader { reader in
                    Color(style.backgroundColor)
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .ignoresSafeArea()
                }
                BPKNavigationBar(
                    title: title,
                    style: style,
                    leadingItems: leadingItems,
                    trailingItems: trailingItems
                )
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                content()
            }
        }
    }
}

struct BPKNavigationBar: View {
    let title: String?
    let style: BPKNavigationBarStyle
    let leadingItems: [BPKNavigationBarItem]
    let trailingItems: [BPKNavigationBarItem]
    
    @State private var leadingItemsSize: CGSize = .zero
    @State private var trailingItemsSize: CGSize = .zero
    
    init(
        title: String?,
        style: BPKNavigationBarStyle,
        leadingItems: [BPKNavigationBarItem] = [],
        trailingItems: [BPKNavigationBarItem] = []
    ) {
        self.title = title
        self.style = style
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
    }
    
    private var maxItemGroupWidth: CGFloat {
        if leadingItemsSize.width > trailingItemsSize.width {
            return leadingItemsSize.width
        }
        return trailingItemsSize.width
    }
    
    // swiftlint:disable closure_body_length
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: BPKSpacing.none) {
                HStack(spacing: .md) {
                    HStack(spacing: .base) {
                        toolbarItemView(forItems: leadingItems)
                    }
                    .modifier(ReadSizeModifier { leadingItemsSize = $0 })
                    .frame(width: maxItemGroupWidth, alignment: .leading)
                    Spacer()
                    
                    BPKText(title ?? "", style: .heading5)
                        .foregroundColor(style.foregroundColor)
                        .lineLimit(1)
                    
                    Spacer()
                    HStack(spacing: .base) {
                        toolbarItemView(forItems: trailingItems)
                    }
                    .modifier(ReadSizeModifier { trailingItemsSize = $0 })
                    .frame(width: maxItemGroupWidth, alignment: .trailing)
                }
                .padding(.horizontal, .md)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                
                if let lineColor = style.lineColor {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(lineColor)
                }
            }
        }
        .background(style.backgroundColor)
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
        .foregroundColor(style.foregroundColor)
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

// swiftlint:disable all
struct BPKNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BPKNavigationView(
            title: "Title Example",
            leadingItems: [
                .init(type: .backButton("Back"), action: {})
            ],
            trailingItems: [
                .init(type: .icon(.ai, "AI"), action: {}),
                .init(type: .title("Add"), action: {})
            ],
            style: .transparent(.automatic)
        ) {
            ScrollView {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: .infinity, height: 250)
                    .bpkOverlay(.linear(.low, .top))
                BPKText("Start")
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}
