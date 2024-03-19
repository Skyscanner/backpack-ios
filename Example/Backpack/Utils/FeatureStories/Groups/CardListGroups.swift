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
import Backpack
import Backpack_SwiftUI

@MainActor
struct CardListGroupsProvider {
    let showPresentable: (Presentable) -> Void

    func swiftUIGroups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable(
                    "Rail - 3 total elements",
                    view: CardListExampleView(layout: .rail(), totalElements: 3)
                ),
                presentable(
                    "Rail - 9 total elements",
                    view: CardListExampleView(layout: .rail(), totalElements: 9)
                ),
                presentable(
                    "Rail - 12 total elements & Section Header Button",
                    view: CardListExampleView(layout: .rail(sectionHeaderAction: .example), totalElements: 12)
                ),
                presentable(
                    "Stack - 3 initial, 12 total elements",
                    view: CardListExampleView(layout: .stack(), totalElements: 12)
                ),
                presentable(
                    "Stack - Accessory Expand",
                    view: CardListExampleView(layout: .stack(
                        accessory: .expand(
                            expandText: "Show more",
                            collapseText: "Show less")
                    ), totalElements: 9)
                ),
                presentable(
                    "Stack - Accessory Button",
                    view: CardListExampleView(layout: .stack(accessory: .footerButton(.example)), totalElements: 9)
                ),
                presentable(
                    "Stack - Accessory Expand & Section Header Button",
                    view: CardListExampleView(
                        layout: .stack(
                            accessory: .expand(
                                expandText: "Show more",
                                collapseText: "Show less",
                                sectionHeaderButton: .example
                            )
                        ),
                        totalElements: 9
                    )
                )

            ]
        ).groups()
    }

    private func presentable<Content: View>(
        _ title: String,
        view: Content
    ) -> CellDataSource {
        PresentableCellDataSource.custom(
            title: title,
            customController: { ContentUIHostingController(view) },
            showPresentable: showPresentable
        )
    }
}

fileprivate extension BPKCardListLayout.SectionHeaderAction {
    static let example = BPKCardListLayout.SectionHeaderAction(
        icon: .longArrowRight,
        accessibilityLabel: "Add item") {
            print("Tap add button")
    }
}

fileprivate extension BPKCardListLayout.AccessoryAction {
    static let example = BPKCardListLayout.AccessoryAction(
        title: "Add item",
        icon: .init(icon: .addCircle, position: .trailing),
        accessibilityLabel: "Add item") {
            print("Tap add button")
    }
}
