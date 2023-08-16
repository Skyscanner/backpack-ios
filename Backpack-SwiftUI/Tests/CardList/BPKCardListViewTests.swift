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

import XCTest
import SnapshotTesting
import SwiftUI
import Backpack_SwiftUI

class BPKCardListViewTests: XCTestCase {
    func testCardListRail() {
        assertSnapshot(
            BPKCardList(
                title: "Must-visit spots",
                description: "Check out these world-famous destinations perfect for visiting in spring.",
                layout: .rail(),
                initiallyShownCardsCount: 2,
                elements: Array(TestLocation.placeholders[0..<4]),
                cardForElement: locationRailCard(element:))
            .padding()
            .frame(width: 375)
        )
    }

    func testCardListRailWithSectionHeaderButton() {
        assertSnapshot(
            BPKCardList(
                title: "Must-visit spots",
                description: "Check out these world-famous destinations perfect for visiting in spring.",
                layout: .rail(
                    sectionHeaderAction: .init(
                        icon: .addCircle,
                        accessibilityLabel: "Add item") {
                            print("Tap add button")
                    }
                ),
                initiallyShownCardsCount: 2,
                elements: Array(TestLocation.placeholders[0..<4]),
                cardForElement: locationRailCard(element:))
            .padding()
            .frame(width: 375)
        )
    }

    func testCardListStack() {
        assertSnapshot(
            BPKCardList(
                title: "Popular right now",
                description: "Other travellers are loving these destinations. " +
                "Search flights, hotels and car hire and join them on the adventure.",
                layout: .stack(),
                initiallyShownCardsCount: 2,
                elements: Array(TestLocation.placeholders[0..<4]),
                cardForElement: locationStackCard(element:))
            .padding()
            .frame(width: 375)
        )
    }

    func testCardListStackWithFooterButtonAccessory() {
        assertSnapshot(
            BPKCardList(
                title: "Popular right now",
                description: "Other travellers are loving these destinations. " +
                "Search flights, hotels and car hire and join them on the adventure.",
                layout: .stack(
                    accessory: .footerButton(
                        .init(
                            title: "Add item",
                            icon: .init(icon: .addCircle, position: .trailing),
                            accessibilityLabel: "Add item") {
                                print("Tap add button")
                        }
                    )
                ),
                initiallyShownCardsCount: 2,
                elements: Array(TestLocation.placeholders[0..<4]),
                cardForElement: locationStackCard(element:))
            .padding()
            .frame(width: 375)
        )
    }

    func testCardListStackWithExpandAccessory() {
        assertSnapshot(
            BPKCardList(
                title: "Popular right now",
                description: "Other travellers are loving these destinations. " +
                "Search flights, hotels and car hire and join them on the adventure.",
                layout: .stack(accessory: .expand(expandText: "Show more", collapseText: "Show less")),
                initiallyShownCardsCount: 2,
                elements: Array(TestLocation.placeholders[0..<4]),
                cardForElement: locationStackCard(element:))
            .padding()
            .frame(width: 375)
        )
    }

    func testCardListStackWithSectionHeaderButton() {
        assertSnapshot(
            BPKCardList(
                title: "Popular right now",
                description: "Other travellers are loving these destinations. " +
                "Search flights, hotels and car hire and join them on the adventure.",
                layout: .stack(
                    accessory: .sectionHeaderButton(
                        .init(
                            icon: .addCircle,
                            accessibilityLabel: "Add item") {
                                print("Tap add button")
                        }
                    )
                ),
                initiallyShownCardsCount: 2,
                elements: Array(TestLocation.placeholders[0..<4]),
                cardForElement: locationStackCard(element:))
            .padding()
            .frame(width: 375)
        )
    }

    func testCardListStackWithExpandAccessoryAndSectionHeaderButton() {
        assertSnapshot(
            BPKCardList(
                title: "Popular right now",
                description: "Other travellers are loving these destinations. " +
                "Search flights, hotels and car hire and join them on the adventure.",
                layout: .stack(
                    accessory: .expand(
                        expandText: "Show more",
                        collapseText: "Show less",
                        sectionHeaderButton: .init(
                            icon: .addCircle,
                            accessibilityLabel: "Add item") {
                                print("Tap add button")
                        }
                    )
                ),
                initiallyShownCardsCount: 2,
                elements: Array(TestLocation.placeholders[0..<4]),
                cardForElement: locationStackCard(element:))
            .padding()
            .frame(width: 375)
        )
    }

    func testCardListStackWithExpandAccessoryAndSectionHeaderButtonAndLongTitleAndDescription() {
        assertSnapshot(
            BPKCardList(
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
                + " sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
                + "ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris"
                + "nisi ut aliquip ex ea commodo consequat.",
                layout: .stack(),
                initiallyShownCardsCount: 2,
                elements: Array(TestLocation.placeholders[0..<4]),
                cardForElement: locationStackCard(element:))
            .padding()
            .frame(width: 375)
        )
    }

    private func locationRailCard(element: TestLocation) -> some View {
        BPKSnippet(
            image: Image(element.imageName, bundle: TestsBundle.bundle),
            headline: element.name,
            description: element.description,
            imageOrientation: .landscape)
        .frame(width: 281)
    }

    private func locationStackCard(element: TestLocation) -> some View {
        BPKCard(padding: .none) {
            HStack {
                Image(element.imageName, bundle: TestsBundle.bundle)
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
}

private struct TestLocation: Identifiable {
    let id: Int
    let imageName: String
    let name: String
    let description: String?

    static let placeholders: [TestLocation] = [
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
