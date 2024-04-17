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
    let inputPrefix: BPKSearchInputSummary.InputPrefix
    let inputHint: String
    let results: BPKAppSearchModalResults
    let closeAccessibilityLabel: String
    let onClose: () -> Void
    private var textFieldState: TextFieldState = .default
    @FocusState private var inputFieldIsFocussed: Bool
    
    public init(
        title: String,
        inputText: Binding<String>,
        inputHint: String,
        results: BPKAppSearchModalResults,
        closeAccessibilityLabel: String,
        inputPrefix: BPKSearchInputSummary.InputPrefix = .icon(.search),
        onClose: @escaping () -> Void
    ) {
        self.title = title
        self._inputText = inputText
        self.inputHint = inputHint
        self.results = results
        self.closeAccessibilityLabel = closeAccessibilityLabel
        self.inputPrefix = inputPrefix
        self.onClose = onClose
    }
    
    public var body: some View {
        VStack(spacing: .base) {
            makeNavigationBar(title: title, closeAccessibilityLabel: closeAccessibilityLabel, onClose: onClose)
                .padding(.horizontal, .base)
            if results.showTextField {
                BPKSearchInputSummary(placeholder: inputHint, inputPrefix: inputPrefix, $inputText)
                    .inputState(textFieldState.inputState)
                    .focused($inputFieldIsFocussed)
                    .autocorrectionDisabled(true)
                    .padding(.horizontal, .base)
            }
            switch results {
            case .loading(let loading):
                AppSearchModalLoadingView(state: loading)
                    .padding(.horizontal, .base)
            case .content(let content):
                AppSearchModalContentView(state: content, onScroll: onScroll(_:))
                    .padding(.top, .md)
            case .error(let error):
                AppSearchModalErrorView(state: error)
                    .padding(.horizontal, .md)
                    .padding(.horizontal, .base)
            }
        }
        .padding(.top, .base)
        .padding(.bottom, BPKSpacing.none)
        .background(.surfaceDefaultColor)
        .accessibilityAddTraits(.isModal)
    }
    
    func makeNavigationBar(
        title: String,
        closeAccessibilityLabel: String,
        onClose: @escaping () -> Void
    ) -> some View {
        ZStack {
            HStack {
                BPKCloseButton(accessibilityLabel: closeAccessibilityLabel, action: onClose)
                    .accessibilityLabel(closeAccessibilityLabel.lowercased())
                Spacer()
            }
            BPKText(title, style: .heading5)
                .padding(.vertical, .sm)
                .accessibilityAddTraits(.isHeader)
                .accessibilityLabel(title)
        }
        .padding(.vertical, .md)
    }
    
    public func inputState(_ state: TextFieldState) -> BPKAppSearchModal {
        var result = self
        result.textFieldState = state
        return result
    }
    
    private func onScroll(_ offset: CGPoint) {
        inputFieldIsFocussed = false
    }
}

extension BPKAppSearchModalResults {
    var showTextField: Bool {
        switch self {
        case .loading, .content: return true
        case .error: return false
        }
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
            inputPrefix: .icon(.search),
            onClose: { }
        )
        .previewDisplayName("Content")
        
        BPKAppSearchModal(
            title: "Search Modal",
            inputText: .constant("Text"),
            inputHint: "Search",
            results: .loading(.init(accessibilityLabel: "Loading")),
            closeAccessibilityLabel: "Close",
            inputPrefix: .text("From"),
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
            tertiaryLabel: "City",
            icon: .recentSearches,
            onItemSelected: {}
        )
    }
    
    static func buildShortcut(with index: Int) -> BPKAppSearchModalContent.Shortcut {
        return .init(text: "Shortcut \(index + 1)", icon: .landmark, onShortcutSelected: { })
    }
}
