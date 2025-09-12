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
    let initiallyShownCardsCount: Int
    let layout: BPKCardListLayout
    let elements: [Location]

    private let title: String
    private let description: String

    init(
        initiallyShownCardsCount: Int = 3,
        layout: BPKCardListLayout,
        totalElements: Int
    ) {
        self.initiallyShownCardsCount = initiallyShownCardsCount
        self.layout = layout
        let maxElements = min(totalElements, 9)
        self.elements = Array(Location.placeholders.prefix(upTo: maxElements))
        switch layout {
        case .rail:
            title = "Must-visit spots"
            description = "Check out these world-famous destinations perfect for visiting in spring."
        case .stack:
            title = "Popular right now"
            description = "Other travellers are loving these destinations. " +
            "Search flights, hotels and car hire and join them on the adventure."
        }
    }

    var body: some View {
        ScrollView {
            BPKCardList(
                title: title,
                description: description,
                layout: layout,
                initiallyShownCardsCount: initiallyShownCardsCount,
                elements: elements,
                cardForElement: content(element:))
        }
    }

    @ViewBuilder private func content(element: Location) -> some View {
        switch layout {
        case .rail:
            railCard(element: element)
        case .stack:
            stackCard(element: element)
        }
    }

    private func stackCard(element: Location) -> some View {
        BPKCard(padding: .none) {
            HStack {
                Image(element.imageName)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                VStack(alignment: .leading) {
                    BPKText(element.name, style: .heading5)
                    BPKText("Flights・Hotels・Car hire", style: .footnote)
                        .foregroundColor(.coreAccentColor)
                }
                .padding(.base)
                Spacer()
            }
        }
        .frame(height: 88)
    }

    private func railCard(element: Location) -> some View {
        BPKSnippet(
            image: Image(decorative: element.imageName),
            headline: element.name,
            bodyText: element.description,
            imageOrientation: .landscape)
    }

    struct Location: Identifiable {
        let id: Int
        let imageName: String
        let name: String
        let description: String?
    }
}

extension CardListExampleView.Location {
    static let placeholders: [CardListExampleView.Location] = [
        .init(
            id: 1,
            imageName: "Amsterdam",
            name: "Amsterdam",
            description: "Fall in love with this artistic metropolis by boat or foot."),
        .init(
            id: 2,
            imageName: "London-TowerBridge",
            name: "London",
            description: "Watch the city come alive in bloom as the warmer climes approach."),
        .init(
            id: 3,
            imageName: "Dublin-TempleBar",
            name: "Dublin",
            description: "Immerse yourself in the rich history and culture of the Irish capital."),
        .init(
            id: 4,
            imageName: "Paris",
            name: "Paris",
            description: nil),
        .init(
            id: 5,
            imageName: "Mallorca-Palma",
            name: "Mallorca",
            description: nil),
        .init(
            id: 6,
            imageName: "Alicante",
            name: "Alicante",
            description: nil),
        .init(
            id: 7,
            imageName: "Barcelona-CasaBatllo",
            name: "Barcelona",
            description: nil),
        .init(
            id: 8,
            imageName: "Berlin-Fernsehturm",
            name: "Berlin",
            description: nil),
        .init(
            id: 9,
            imageName: "London-SaintPancrasStation",
            name: "London",
            description: "Watch the city come alive in bloom as the warmer climes approach."),
        .init(
            id: 10,
            imageName: "Paris",
            name: "Paris",
            description: nil),
        .init(
            id: 11,
            imageName: "Mallorca-Palma",
            name: "Mallorca",
            description: nil),
        .init(
            id: 12,
            imageName: "Alicante",
            name: "Alicante",
            description: nil),
        .init(
            id: 13,
            imageName: "Barcelona-CasaBatllo",
            name: "Barcelona",
            description: nil)
    ]
}

struct CardListExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CardListExampleView(
            layout: .rail(),
            totalElements: 9
        )
    }
}
