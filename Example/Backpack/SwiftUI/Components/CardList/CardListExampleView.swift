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
    let elements: [TestElement]
    let contentType: ContentType

    init(
        initiallyShownCards: Int = 3,
        layout: BPKCardListLayout,
        totalElements: Int,
        contentType: ContentType = .snippet
    ) {
        self.initiallyShownCards = initiallyShownCards
        self.layout = layout
        self.elements = (0..<totalElements).map { index in
            TestElement(id: index)
        }
        self.contentType = contentType
    }

    var body: some View {
        ScrollView {
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                layout: layout,
                initiallyShownCards: initiallyShownCards,
                elements: elements,
                cardForElement: content(element:))
        }
    }

    @ViewBuilder private func content(element: TestElement) -> some View {
        if contentType == .location {
            locationContent(element: element)
        } else {
            switch layout {
            case .rail:
                railSnippet(element: element)
            case .stack:
                stackSnippet(element: element)
            }
        }
    }

    private func railSnippet(element: TestElement) -> some View {
        BPKSnippet(
            image: Image("dialog_image"),
            accessibilityLabel: "London at dawn",
            headline: "Headline Text \(element.id)",
            description: "Subheading \(element.id)",
            bodyText: "Body Text \(element.id)",
            imageOrientation: .square)
        .frame(width: 281)
    }

    private func stackSnippet(element: TestElement) -> some View {
        BPKSnippet(
            image: Image("dialog_image"),
            accessibilityLabel: "London at dawn",
            headline: "Headline Text \(element.id)",
            description: "Subheading \(element.id)",
            bodyText: "Body Text \(element.id)",
            imageOrientation: .square)
    }

    private func locationContent(element: TestElement) -> some View {
        BPKCard(padding: .none) {
            HStack {
                Image("carousel_placeholder_\(element.id % 4 + 1)")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                VStack {
                    Text("Location \(element.id)")
                }
                Spacer()
            }
        }
        .frame(height: 90)
    }

    enum ContentType {
        case snippet
        case location
    }

    struct TestElement: Identifiable {
        let id: Int
    }
}

struct CardListExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CardListExampleView(
            layout: .rail(),
            totalElements: 9
        )
    }
}
