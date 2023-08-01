//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

import Foundation
import SwiftUI
import Backpack_SwiftUI

struct CardListExampleView: View {
    let initiallyShownCards: Int
    let layout: BPKCardListLayout
    let showSectionHeaderButton: Bool
    let totalElements: Int

    init(
        initiallyShownCards: Int = 3,
        layout: BPKCardListLayout,
        showSectionHeaderButton: Bool = false,
        totalElements: Int
    ) {
        self.initiallyShownCards = initiallyShownCards
        self.layout = layout
        self.showSectionHeaderButton = showSectionHeaderButton
        self.totalElements = totalElements
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .base) {
                if let sectionHeaderButton {
                    BPKCardList(
                        title: "Section title",
                        description: "Description about this section (optional)",
                        sectionHeaderButton: sectionHeaderButton,
                        layout: BPKCardListLayoutWithSectionHeaderButton(layout: layout),
                        initiallyShownCards: initiallyShownCards,
                        totalElements: 9,
                        cardForIndex: content(index:))
                } else {
                    BPKCardList(
                        title: "Section title",
                        description: "Description about this section (optional)",
                        layout: layout,
                        initiallyShownCards: initiallyShownCards,
                        totalElements: 9,
                        cardForIndex: content(index:))
                }
            }
            .padding()
        }
    }

    private var sectionHeaderButton: BPKCardListAction? {
        guard showSectionHeaderButton else {
            return nil
        }
        if case .stack(let accessory) = layout, case .button = accessory {
            return nil
        }
        return .init(title: "Test button") {
            print("Section header button tapped")
        }
    }

    private func content(index: Int) -> some View {
        BPKSnippet(
            image: Image("dialog_image"),
            accessibilityLabel: "London at dawn",
            headline: "Headline Text \(index)",
            description: "Subheading \(index)",
            bodyText: "Body Text \(index)",
            imageOrientation: .square)
        .frame(width: 281)
    }
}

struct CardListExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CardListExampleView(
            layout: .rail,
            showSectionHeaderButton: false,
            totalElements: 9
        )
    }
}

fileprivate extension BPKCardListLayoutWithSectionHeaderButton {
    init(layout: BPKCardListLayout) {
        switch layout {
        case .rail:
            self = .rail
        case .stack(let accessory):
            if case .expand(let expandingText, let collapsingText) = accessory {
                self = .stack(.expand(expandingText, collapsingText))
            } else {
                self = .stack(nil)
            }
        }
    }
}
