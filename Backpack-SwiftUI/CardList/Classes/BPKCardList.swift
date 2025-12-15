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
    private let headerPadding: (Edge.Set, BPKSpacing)
    @Binding private var showingAllCards: Bool

    public init(
        title: String,
        description: String?,
        layout: BPKCardListLayout,
        initiallyShownCardsCount: Int = 3,
        elements: [Element],
        headerPadding: (Edge.Set, BPKSpacing) = (.all, .base),
        showingAllCards: Binding<Bool> = .constant(false),
        @ViewBuilder cardForElement: @escaping (_: Element) -> Content
    ) {
        self.title = title
        self.description = description
        self.layout = layout
        self.initiallyShownCardsCount = initiallyShownCardsCount
        self.elements = elements
        self.headerPadding = headerPadding
        self._showingAllCards = showingAllCards
        self.cardForElement = cardForElement
    }

    public var body: some View {
        switch layout {
        case .rail(let sectionHeaderAction, let cardWidth):
            railLayout(with: sectionHeaderAction, cardWidth: cardWidth)
        case .stack(let accessory):
            stackLayout(with: accessory)
        }
    }

    private func railLayout(
        with sectionHeaderAction: BPKCardListLayout.SectionHeaderAction?,
        cardWidth: CGFloat?
    ) -> some View {
        cardListSkeleton(with: sectionHeaderAction) {
            if elements.count == 1, let only = elements.first {
                VStack {
                    cardForElement(only)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, .base)
                .padding(.vertical, .sm)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: .base) {
                        ForEach(elements) { element in
                            cardForElement(element)
                                .applyCardWidth(cardWidth)
                        }
                    }
                    .padding(.horizontal, .base)
                    .padding(.vertical, .sm)
                }
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
            .padding(headerPadding.0, headerPadding.1)
        } else {
            return BPKSectionHeader(title: title, description: description)
                .padding(headerPadding.0, headerPadding.1)
        }
    }
    
    private func cardListSkeleton<LayoutContent: View>(
        with sectionHeaderAction: BPKCardListLayout.SectionHeaderAction?,
        @ViewBuilder andContent content: () -> LayoutContent) -> some View {
            VStack(alignment: .leading, spacing: 0) {
                sectionHeader(with: sectionHeaderAction)
                VStack(alignment: .leading, spacing: .base) {
                    if elements.count > 0 {
                        content()
                    }
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
        // swiftlint:disable:next line_length
        if case .expand(let expandingText, let collapsingText, _, let action) = accessory, initiallyShownCardsCount < elements.count {
            BPKButton(
                (showingAllCards) ? collapsingText : expandingText,
                icon: .trailing(icon: BPKIcon(name: (showingAllCards) ? "chevron-up" : "chevron-down"))
            ) {
                withAnimation {
                    showingAllCards.toggle()
                    action?(showingAllCards)
                }
            }
            .buttonStyle(.link)
            .stretchable()
            .accessibilityIdentifier("BPKCardListExpandButton")
        }
    }
}

private extension View {
    @ViewBuilder
    func applyCardWidth(_ width: CGFloat?) -> some View {
        if let width {
            self.frame(width: width)
        } else {
            self
        }
    }
}
