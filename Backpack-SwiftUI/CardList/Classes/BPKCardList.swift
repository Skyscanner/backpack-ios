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

public struct BPKCardList<Content: View>: View {
    private let title: String
    private let description: String?
    private let sectionHeaderButton: BPKCardListAction?
    private let layout: BPKCardListLayout
    private let initiallyShownCards: Int
    private let totalElements: Int
    private let cardForIndex: (_ index: Int) -> Content
    @State private var showingAllCards = false

    public init(
        title: String,
        description: String?,
        sectionHeaderButton: BPKCardListAction,
        layout: BPKCardListLayoutWithSectionHeaderButton,
        initiallyShownCards: Int = 3,
        totalElements: Int,
        @ViewBuilder cardForIndex: @escaping (_: Int) -> Content
    ) {
        self.title = title
        self.description = description
        self.sectionHeaderButton = sectionHeaderButton
        self.layout = layout.layout
        self.initiallyShownCards = initiallyShownCards
        self.totalElements = totalElements
        self.cardForIndex = cardForIndex
    }

    public init(
        title: String,
        description: String?,
        layout: BPKCardListLayout,
        initiallyShownCards: Int = 3,
        totalElements: Int,
        @ViewBuilder cardForIndex: @escaping (_: Int) -> Content
    ) {
        self.title = title
        self.description = description
        self.sectionHeaderButton = nil
        self.layout = layout
        self.initiallyShownCards = initiallyShownCards
        self.totalElements = totalElements
        self.cardForIndex = cardForIndex
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: .base) {
            sectionHeader
                .padding()
            if totalElements > 0 {
                cardsLayout {
                    ForEach(0 ..< cardsShown, id: \.self, content: cardForIndex)
                }
            }
        }
    }

    private var cardsShown: Int {
        switch layout {
        case .rail:
            return totalElements
        case .stack:
            return (showingAllCards) ? totalElements : min(initiallyShownCards, totalElements)
        }
    }

    private var sectionHeader: BPKSectionHeader {
        if let sectionHeaderButton {
            BPKSectionHeader(title: title, description: description) {
                BPKButton(sectionHeaderButton.title, action: sectionHeaderButton.action)
                    .buttonStyle((sectionHeaderButton.style == .default) ? .primary : .primaryOnDark)
            }
        } else {
            BPKSectionHeader(title: title, description: description)
        }
    }

    @ViewBuilder private var accessoryView: some View {
        if case .stack(let accessory) = layout, let accessory {
            switch accessory {
            case .button(let button):
                BPKButton(button.title, action: button.action)
                    .buttonStyle((button.style == .default) ? .primary : .primaryOnDark)
                    .stretchable()
            case .expand(let expandingText, let collapsingText):
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

    @ViewBuilder private func cardsLayout(cardsContent: () -> some View) -> some View {
        switch layout {
        case .rail:
            ScrollView(.horizontal) {
                HStack(spacing: .base) {
                    cardsContent()
                }
                .padding(.horizontal)
            }
        case .stack:
            cardsContent()
                .padding(.horizontal)
            accessoryView
                .padding(.horizontal)
        }
    }
}
