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
    let style: Style
    let leadingItems: [Self.ToolbarItem]
    let trailingItems: [Self.ToolbarItem]
    let content: () -> Content
    
    public init(
        title: String? = nil,
        leadingItems: [Self.ToolbarItem] = [],
        trailingItems: [Self.ToolbarItem] = [],
        style: Style = .default(.automatic),
        content: @escaping () -> Content
    ) {
        self.title = title
        self.style = style
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
        self.content = content
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: BPKColor.statusSuccessFillColor.value]
        appearance.largeTitleTextAttributes = [.foregroundColor: BPKColor.statusSuccessFillColor.value]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    public var body: some View {
        NavigationView {
            content()
                .if(title != nil, transform: { view in
                    view
                        .navigationTitle(title!)
                })
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        toolbarItemView(forItems: leadingItems)
                    }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        toolbarItemView(forItems: trailingItems)
                    }
                }
                .navigationBarTitleDisplayMode(style.displayMode)
            
        }.onAppear {
            let appearance = style.navBarAppearance
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    @ViewBuilder
    private func toolbarItemView(forItems items: [Self.ToolbarItem]) -> some View {
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
}

struct BPKNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BPKNavigationView(
            title: "Title Here",
            leadingItems: [
                .init(type: .backButton("Back"), action: {}),
                .init(type: .icon(.accountFemale, "try"), action: {})
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
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}
