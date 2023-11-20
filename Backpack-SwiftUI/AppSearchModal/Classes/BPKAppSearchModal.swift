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

public struct BPKAppSearchModal: View {
    let title: String
    @Binding var inputText: String
    let inputHint: String
    let results: BPKAppSearchModalResults
    let closeAccessibilityLabel: String
    let onClose: () -> Void
    
    public init(
        title: String,
        inputText: Binding<String>,
        inputHint: String,
        results: BPKAppSearchModalResults,
        closeAccessibilityLabel: String,
        onClose: @escaping () -> Void
    ) {
        self.title = title
        self._inputText = inputText
        self.inputHint = inputHint
        self.results = results
        self.closeAccessibilityLabel = closeAccessibilityLabel
        self.onClose = onClose
    }
    
    public var body: some View {
        VStack(spacing: .base) {
            
            makeNavigationBar(title: title, closeAccessibilityLabel: closeAccessibilityLabel, onClose: onClose)
            
            switch results {
            case .loading(let loading):
                BPKTextField(placeholder: inputHint, $inputText)
                AppSearchModalLoadingView(state: loading)
            case .content(let content):
                BPKTextField(placeholder: inputHint, $inputText)
                AppSearchModalContentView(state: content)
                    .padding(.top, .md)
            case .error(let error):
                AppSearchModalErrorView(state: error)
                    .padding(.horizontal, .md)
            }
        }
        .padding(.horizontal, .base)
        .padding(.top, .base)
        .padding(.bottom, BPKSpacing.none)
        .background(.surfaceDefaultColor)
    }
    
    func makeNavigationBar(
        title: String,
        closeAccessibilityLabel: String,
        onClose: @escaping () -> Void
    ) -> some View {
        ZStack {
            HStack {
                BPKIconView(.close, size: .large)
                    .onTapGesture(perform: onClose)
                    .accessibilityHidden(false)
                    .accessibilityRemoveTraits(.isImage)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel(closeAccessibilityLabel)
                Spacer()
            }
            BPKText(title, style: .heading5)
                .padding(.vertical, .sm)
                .accessibilityAddTraits(.isHeader)
        }
        .padding(.vertical, .md)
    }
}

struct BPKAppSearchModal_Previews: PreviewProvider {
    static var previews: some View {
        BPKAppSearchModal(
            title: "Search Modal",
            inputText: .constant(""),
            inputHint: "Search",
            results: .content(.init(
                sections: (0..<3).map(buildSection),
                shortcuts: (0..<4).map(buildShortcut)
            )),
            closeAccessibilityLabel: "Close",
            onClose: { }
        )
        .previewDisplayName("Content")
        
        BPKAppSearchModal(
            title: "Search Modal",
            inputText: .constant("Text"),
            inputHint: "Search",
            results: .loading(.init(accessibilityLabel: "Loading")),
            closeAccessibilityLabel: "Close",
            onClose: { }
        )
        .previewDisplayName("Loading")
        
        BPKAppSearchModal(
            title: "Search Modal",
            inputText: .constant(""),
            inputHint: "Search",
            results: .error( .init(
                title: "Title",
                description: "This is the subtitle",
                action: .init( text: "Title for button", onActionSelected: { }),
                image: Image(systemName: "photo")

            )),
            closeAccessibilityLabel: "Close",
            onClose: { }
        )
        .previewDisplayName("Error")
    }
    
    static func buildSection(with index: Int) -> BPKAppSearchModalContent.Section {
        return .init(
            heading: .init(title: "Section \(index + 1)", action: .init(text: "Action", onActionSelected: { })),
            items: (0..<1).map(buildItem)
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
