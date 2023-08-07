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
    private let testElements: [TestElement] = (0..<12).map { index in
        TestElement(id: index)
    }

    func testCardListRail() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                layout: .rail(),
                initiallyShownCardsCount: 2,
                elements: Array(testElements[0..<4]),
                cardForElement: locationContent(element:))
            .padding()
        )
    }

    func testCardListRailWithSectionHeaderButton() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                layout: .rail(
                    sectionHeaderAction: .init(
                        icon: .addCircle,
                        accessibilityLabel: "Add item") {
                            print("Tap add button")
                    }
                ),
                initiallyShownCardsCount: 2,
                elements: Array(testElements[0..<4]),
                cardForElement: locationContent(element:))
            .padding()
        )
    }

    func testCardListStack() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                layout: .stack(),
                initiallyShownCardsCount: 2,
                elements: Array(testElements[0..<4]),
                cardForElement: locationContent(element:))
            .padding()
        )
    }

    func testCardListStackWithFooterButtonAccessory() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
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
                elements: Array(testElements[0..<4]),
                cardForElement: locationContent(element:))
            .padding()
        )
    }

    func testCardListStackWithExpandAccessory() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                layout: .stack(accessory: .expand(expandText: "Show more", collapseText: "Show less")),
                initiallyShownCardsCount: 2,
                elements: Array(testElements[0..<4]),
                cardForElement: locationContent(element:))
            .padding()
        )
    }

    func testCardListStackWithSectionHeaderButton() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
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
                elements: Array(testElements[0..<4]),
                cardForElement: locationContent(element:))
            .padding()
        )
    }

    func testCardListStackWithExpandAccessoryAndSectionHeaderButton() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
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
                elements: Array(testElements[0..<4]),
                cardForElement: locationContent(element:))
            .padding()
        )
    }

    private func locationContent(element: TestElement) -> some View {
        BPKCard(padding: .none) {
            HStack {
                Image("carousel_placeholder_\(element.id % 4 + 1)", bundle: TestsBundle.bundle)
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

    private struct TestElement: Identifiable {
        let id: Int
    }
}
