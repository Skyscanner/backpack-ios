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
    private let initiallyShownCardsCount: Int
    private let elements: [Element]
    private let cardForElement: (_ element: Element) -> Content
    @State private var showingAllCards = false

    public init(
        title: String,
        description: String?,
        layout: BPKCardListLayout,
        initiallyShownCardsCount: Int = 3,
        elements: [Element],
        @ViewBuilder cardForElement: @escaping (_: Element) -> Content
    ) {
        self.title = title
        self.description = description
        self.layout = layout
        self.initiallyShownCardsCount = initiallyShownCardsCount
        self.elements = elements
        self.cardForElement = cardForElement
    }

    public var body: some View {
        switch layout {
        case .rail(let sectionHeaderAction):
            railLayout(with: sectionHeaderAction)
        case .stack(let accessory):
            stackLayout(with: accessory)
        }
    }

    private func railLayout(with sectionHeaderAction: BPKCardListLayout.SectionHeaderAction?) -> some View {
        cardListSkeleton(with: sectionHeaderAction) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: .base) {
                    ForEach(elements) { index in
                        cardForElement(index)
                    }
                }
                .padding(.horizontal, .base)
            }
        }
    }

    private var filteredCards: ArraySlice<Element> {
        let cardsShown = (showingAllCards) ? elements.count : min(initiallyShownCardsCount, elements.count)
        return elements[0..<cardsShown]
    }

    private func stackLayout(with accessory: BPKCardListLayout.Accessory?) -> some View {
        cardListSkeleton(with: accessory?.sectionHeaderAction) {
            ForEach(filteredCards) { element in
                cardForElement(element)
            }
            .padding(.horizontal, .base)
            accessoryView(accessory: accessory)
                .padding(.horizontal, .base)
        }
    }

    private func sectionHeader(with sectionHeaderAction: BPKCardListLayout.SectionHeaderAction?) -> some View {
        if let sectionHeaderAction {
            return BPKSectionHeader(title: title, description: description) {
                BPKButton(
                    icon: sectionHeaderAction.icon,
                    accessibilityLabel: sectionHeaderAction.accessibilityLabel,
                    action: sectionHeaderAction.action)
                .buttonStyle(.primary)
            }
            .padding(.base)
        } else {
            return BPKSectionHeader(title: title, description: description)
                .padding(.base)
        }
    }

    private func cardListSkeleton<LayoutContent: View>(
        with sectionHeaderAction: BPKCardListLayout.SectionHeaderAction?,
        @ViewBuilder andContent content: () -> LayoutContent) -> some View {
            VStack(alignment: .leading, spacing: .base) {
                sectionHeader(with: sectionHeaderAction)

                if elements.count > 0 {
                    content()
                }
            }
        }

    @ViewBuilder private func accessoryView(accessory: BPKCardListLayout.Accessory?) -> some View {
        if case .footerButton(let button) = accessory {
            BPKButton(
                button.title,
                icon: button.icon,
                action: button.action
            )
            .buttonStyle(.primary)
            .stretchable()
        }
        if case .expand(let expandingText, let collapsingText, _) = accessory {
            BPKButton(
                (showingAllCards) ? collapsingText : expandingText,
                icon: .trailing(icon: BPKIcon(name: (showingAllCards) ? "chevron-up" : "chevron-down"))
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
