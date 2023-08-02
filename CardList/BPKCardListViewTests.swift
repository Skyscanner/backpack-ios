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
                title: "Section title",
                description: "Description about this section (optional)",
                layout: .rail,
                initiallyShownCards: 2,
                totalElements: 4,
                cardForIndex: locationContent(index:))
            .padding()
        )
    }

    func testCardListRailWithSectionHeaderButton() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                sectionHeaderButton: .init(title: "Action", action: {
                    print("Section header action pressed")
                }),
                layout: .rail,
                initiallyShownCards: 2,
                totalElements: 4,
                cardForIndex: locationContent(index:))
            .padding()
        )
    }

    func testCardListStack() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                layout: .stack(nil),
                initiallyShownCards: 2,
                totalElements: 4,
                cardForIndex: locationContent(index:))
            .padding()
        )
    }

    func testCardListStackWithButtonAccessory() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                layout: .stack(
                    .button(
                        .init(
                            title: "Action",
                            action: {
                                print("Section header action pressed")
                            }
                        )
                    )
                ),
                initiallyShownCards: 2,
                totalElements: 4,
                cardForIndex: locationContent(index:))
            .padding()
        )
    }

    func testCardListStackWithExpandAccessory() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                layout: .stack(.expand("Show more", "Show less")),
                initiallyShownCards: 2,
                totalElements: 4,
                cardForIndex: locationContent(index:))
            .padding()
        )
    }

    func testCardListStackWithSectionHeaderButton() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                sectionHeaderButton: .init(title: "Action", action: {
                    print("Section header action pressed")
                }),
                layout: .stack(nil),
                initiallyShownCards: 2,
                totalElements: 4,
                cardForIndex: locationContent(index:))
            .padding()
        )
    }

    func testCardListStackWithExpandAccessoryAndSectionHeaderButton() {
        assertSnapshot(
            BPKCardList(
                title: "Section title",
                description: "Description about this section (optional)",
                layout: .stack(.expand("Show more", "Show less")),
                initiallyShownCards: 2,
                totalElements: 4,
                cardForIndex: locationContent(index:))
            .padding()
        )
    }

    private func locationContent(index: Int) -> some View {
        BPKCard(padding: .none) {
            HStack {
                Image("carousel_placeholder_\(index % 4 + 1)", bundle: TestsBundle.bundle)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                VStack {
                    Text("Location \(index)")
                }
                Spacer()
            }
        }
        .frame(height: 90)
    }
}
