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

import XCTest
import SwiftUI
@testable import Backpack_SwiftUI

class BPKAppSearchModalTests: XCTestCase {
    func test_withLoading() {
        assertSnapshot(
            givenSut(with: .loading(givenLoadingState()))
        )
    }
    
    func test_withError() {
        assertSnapshot(
            givenSut(with: .error(givenErrorState()))
        )
    }
    
    func test_withContent() {
        assertSnapshot(
            givenSut(with: .content(givenContentState()))
        )
    }
    
    func test_withContentWhenPrefixIsIcon() {
        assertSnapshot(
            givenSut(with: .content(givenContentState()), prefixState: .searchIcon)
        )
    }

    func test_withContentWhenPrefixIsCustomText() {
        assertSnapshot(
            givenSut(with: .content(givenContentState()), prefixState: .text("Prefix"))
        )
    }
    
    func test_withContentInputStateClear() {
        assertSnapshot(
            givenSut(
                with: .content(givenContentState()),
                inputState: .clear(
                    accessibilityLabel: "clear",
                    action: { }
                )
            )
        )
    }
  
    // MARK: - Helpers
    private func givenSut(
        with results: BPKAppSearchModalResults,
        inputState: BPKAppSearchModal.TextFieldState = .default,
        prefixState: BPKTextField.PrefixState? = nil
    ) -> some View {
        BPKAppSearchModal(
            title: "Search Modal",
            inputText: .constant(""),
            inputHint: "Search",
            results: results,
            closeAccessibilityLabel: "Close",
            prefixState: prefixState,
            onClose: { }
        )
        .inputState(inputState)
        .frame(width: 375, height: 667)
    }
    
    private func givenErrorState() -> BPKAppSearchModalError {
        return .init(
            title: "Title",
            description: "This is the subtitle",
            action: .init( text: "Title for button", onActionSelected: { }),
            image: Image(systemName: "photo")
        )
    }
    
    private func givenLoadingState() -> BPKAppSearchModalLoading {
        return .init(accessibilityLabel: "Close")
    }
    
    private func givenContentState() -> BPKAppSearchModalContent {
        return .init(
            sections: [
                .init(heading: nil, items: [buildItem(with: 0)]),
                .init(heading: .init(title: "Section 2", action: nil), items: (0..<3).map(buildItem)),
                .init(
                    heading: .init(
                        title: "Section 3",
                        action: .init(text: "Action", onActionSelected: { })
                    ),
                    items: (0..<3).map(buildItem)
                )
            ],
            shortcuts: (0..<4).map(buildShortcut)
        )
    }
    
    private func buildItem(with index: Int) -> BPKAppSearchModalContent.Item {
        return .init(
            title: "Item No.\(index + 1)",
            subtitle: "This is item No.\(index + 1)",
            tertiaryLabel: "city",
            icon: .recentSearches,
            onItemSelected: {}
        )
    }
    
    private func buildShortcut(with index: Int) -> BPKAppSearchModalContent.Shortcut {
        return .init(text: "Shortcut \(index + 1)", icon: .landmark, onShortcutSelected: { })
    }
}
