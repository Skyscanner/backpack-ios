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

public struct BPKCardList<Element: Identifiable, Content: View>: View {
    private let title: String
    private let description: String?
    private let layout: BPKCardListLayout
    private let initiallyShownCards: Int
    private let elements: [Element]
    private let cardForElement: (_ element: Element) -> Content
    @State private var showingAllCards = false

    public init(
        title: String,
        description: String?,
        layout: BPKCardListLayout,
        initiallyShownCards: Int = 3,
        elements: [Element],
        @ViewBuilder cardForElement: @escaping (_: Element) -> Content
    ) {
        self.title = title
        self.description = description
        self.layout = layout
        self.initiallyShownCards = initiallyShownCards
        self.elements = elements
        self.cardForElement = cardForElement
    }

    public var body: some View {
        switch layout {
        case .rail(let sectionHeaderButton):
            railLayout(with: sectionHeaderButton)
        case .stack(let accessory):
            stackLayout(with: accessory)
        }
    }

    private func railLayout(with sectionHeaderButton: BPKCardListLayout.SectionHeaderAction?) -> some View {
        VStack(alignment: .leading, spacing: .base) {
            sectionHeader(with: sectionHeaderButton)

            if elements.count > 0 {
                ScrollView(.horizontal) {
                    HStack(spacing: .base) {
                        ForEach(elements) { index in
                            cardForElement(index)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }

    private func stackLayout(with accessory: BPKCardListLayout.Accessory?) -> some View {
        VStack(alignment: .leading, spacing: .base) {
            sectionHeader(with: accessory?.sectionHeaderButton)

            if elements.count > 0 {
                let cardsShown = (showingAllCards) ? elements.count : min(initiallyShownCards, elements.count)
                let filteredCards = elements[0..<cardsShown]
                ForEach(filteredCards) { element in
                    cardForElement(element)
                }
                    .padding(.horizontal)
                accessoryView(accessory: accessory)
                    .padding(.horizontal)
            }
        }
    }

    private func sectionHeader(with sectionHeaderButton: BPKCardListLayout.SectionHeaderAction?) -> some View {
        if let sectionHeaderButton {
            return BPKSectionHeader(title: title, description: description) {
                BPKButton(
                    icon: sectionHeaderButton.icon,
                    accessibilityLabel: sectionHeaderButton.accessibilityLabel,
                    action: sectionHeaderButton.action)
                .buttonStyle((sectionHeaderButton.style == .default) ? .primary : .primaryOnDark)
            }
            .padding()
        } else {
            return BPKSectionHeader(title: title, description: description)
                .padding()
        }
    }

    @ViewBuilder private func accessoryView(accessory: BPKCardListLayout.Accessory?) -> some View {
        if case .footerButton(let button) = accessory {
            BPKButton(
                button.title,
                icon: button.icon,
                action: button.action
            )
            .buttonStyle((button.style == .default) ? .primary : .primaryOnDark)
            .stretchable()
        }
        if case .expand(let expandingText, let collapsingText, _) = accessory {
            BPKButton(
                (showingAllCards) ? collapsingText : expandingText
            ) {
                withAnimation {
                    showingAllCards.toggle()
                }
            }
            .buttonStyle(.link)
            .stretchable()
        }
    }
}
