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

struct AppSearchModalContentView: View {
    let state: BPKAppSearchModalContent
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: .base) {
                if let shortcuts = state.shortcuts {
                    makeShortcuts(shortcuts)
                }
                ForEach(state.sections, id: \.self) {
                    makeSections($0)
                }
            }
        }
    }
    
    private func makeShortcuts(
        _ shortcuts: [BPKAppSearchModalContent.Shortcut]
    ) -> some View {
        BPKSingleSelectChipGroup(
            chips: shortcuts.map({ BPKSingleSelectChipGroup.ChipItem( text: $0.text, icon: $0.icon) }),
            selectedIndex: .constant(nil),
            onItemClick: { shortcuts[$0].onShortcutSelected() }
        )
    }
    
    private func makeSections(_ section: BPKAppSearchModalContent.Section) -> some View {
        VStack(spacing: 0) {
            if let heading = section.heading {
                HStack {
                    BPKText(heading.title, style: .label1)
                        .accessibilityAddTraits(.isHeader)
                    Spacer()
                    if let action = heading.action {
                        BPKButton(action.text, action: action.onActionSelected)
                            .buttonStyle(.link)
                    }
                }
            }
            ForEach(section.items, id: \.self) { item in
                HStack(spacing: .base) {
                    BPKIconView(item.icon, size: .large)
                    VStack(alignment: .leading) {
                        BPKText(item.title, style: .bodyDefault)
                        BPKText(item.subtitle, style: .footnote)
                    }
                    .padding(.vertical, .base)
                    Spacer()
                }
                .onTapGesture(perform: item.onItemSelected)
                .accessibilityElement(children: .combine)
            }
        }
    }
}

struct AppSearchModalContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppSearchModalContentView(state: .init(
            sections: (0..<3).map(buildSection),
            shortcuts: (0..<4).map(buildShortcut)
        ))
    }
    
    static func buildSection(with index: Int) -> BPKAppSearchModalContent.Section {
        return .init(
            heading: .init(title: "Section \(index + 1)", action: .init(text: "Action", onActionSelected: { })),
            items: (0..<3).map(buildItem)
        )
    }
    
    static func buildItem(with index: Int) -> BPKAppSearchModalContent.Item {
        return .init(
            title: "Item No.\(index + 1)",
            subtitle: "This is item No.\(index + 1)",
            icon: .recentSearches,
            onItemSelected: {}
        )
    }
    
    static func buildShortcut(with index: Int) -> BPKAppSearchModalContent.Shortcut {
        return .init(text: "Shortcut \(index + 1)", icon: .landmark, onShortcutSelected: { })
    }
}
