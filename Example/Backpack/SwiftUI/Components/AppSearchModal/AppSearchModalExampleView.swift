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
import Backpack_SwiftUI

struct AppSearchModalExampleView: View {
    
    @ObservedObject var viewModel: AppSearchModalExampleViewModel
    @State private var inputText = ""
    
    var body: some View {
        ZStack {
            Color(BPKColor.canvasContrastColor)
            
            BPKAppSearchModal(
                title: "Search Modal",
                inputText: $inputText,
                inputHint: "Search",
                results: results(),
                closeAccessibilityLabel: "Close",
                prefixState: .text("From"),
                onClose: {
                    print("Tapped close button")
                }
            )
            .inputState(.clear(accessibilityLabel: "clear text", action: {
                inputText = ""
            }))
            .onChange(of: inputText, perform: { _ in
                self.viewModel.loadContentFrom(inputText)
            })
            .padding()
        }
    }
    
    private func results() -> BPKAppSearchModalResults {
        switch viewModel.resultsType {
        case .error:
            return .error(errorState)
        case .loading:
            return .loading(loadingState)
        case .content:
            return .content(contentState)
        }
    }
    
    private var loadingState: BPKAppSearchModalLoading {
        return BPKAppSearchModalLoading(accessibilityLabel: "Close")
    }
    
    private var errorState: BPKAppSearchModalError {
        BPKAppSearchModalError(
            title: "Title",
            description: "This is the subtitle",
            action: .init( text: "Try again", onActionSelected: { }),
            image: Image(systemName: "photo")
        )
    }
    
    private var contentState: BPKAppSearchModalContent {
        BPKAppSearchModalContent(
            sections: (0..<3).map(buildSection),
            shortcuts: (0..<4).map(buildShortcut)
        )
    }
    
    private func buildSection(with index: Int) -> BPKAppSearchModalContent.Section {
        return .init(
            heading: .init(
                title: "Section \(index + 1)",
                action: .init(
                    text: "Action",
                    onActionSelected: {
                        print("Tapped action button in section \(index + 1)")
                    }
                )
            ),
            items: (0..<3).map { buildItem(with: $0, section: index) }
        )
    }
    
    private func buildItem(with index: Int, section: Int) -> BPKAppSearchModalContent.Item {
        return .init(
            title: "Item No.\(index + 1)",
            subtitle: "This is item No.\(index + 1)",
            tertiaryLabel: "City",
            icon: .recentSearches,
            onItemSelected: {
                print("Selected item \(index + 1) in section \(section + 1)")
            }
        )
    }
    
    private func buildShortcut(with index: Int) -> BPKAppSearchModalContent.Shortcut {
        return .init(
            text: "Shortcut \(index + 1)",
            icon: .landmark,
            onShortcutSelected: {
                print("Selected shortcut \(index + 1) ")
            }
        )
    }
}
