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

struct CardListGroupsProvider {
    let showPresentable: (Presentable) -> Void

    func swiftUIGroups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable(
                    "Rail - 5 total elements",
                    view: CardListExampleView(layout: .rail, totalElements: 5)
                ),
                presentable(
                    "Rail - 12 total elements",
                    view: CardListExampleView(layout: .rail, totalElements: 12)
                ),
                presentable(
                    "Rail - 12 total elements & Section Header Button",
                    view: CardListExampleView(layout: .rail, showSectionHeaderButton: true, totalElements: 12)
                ),
                presentable(
                    "Stack - 3 initial, 12 total elements",
                    view: CardListExampleView(layout: .stack(nil), totalElements: 12)
                ),
                presentable(
                    "Stack - Accessory Expand",
                    view: CardListExampleView(layout: .stack(.expand("Show more", "Show less")), totalElements: 12)
                ),
                presentable(
                    "Stack - Accessory Button",
                    view: CardListExampleView(layout: .stack(.button(.example)), totalElements: 12)
                ),
                presentable(
                    "Stack - Accessory Expand & Section Header Button",
                    view: CardListExampleView(
                        layout: .stack(.expand("Show more", "Show less")),
                        showSectionHeaderButton: true,
                        totalElements: 12
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

fileprivate extension BPKCardListAction {
    static let example = BPKCardListAction(title: "Action button") {
        print("Action button pressed")
    }
}
