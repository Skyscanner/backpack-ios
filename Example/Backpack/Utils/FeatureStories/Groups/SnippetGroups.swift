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

struct SnippetGroupsProvider {
    let showPresentable: (Presentable) -> Void

    func swiftUIGroups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                PresentableCellDataSource.custom(
                    title: "Landscape",
                    customController: { ContentUIHostingController(SnippetExampleView()) },
                    showPresentable: showPresentable
                ),
                PresentableCellDataSource.custom(
                    title: "Square",
                    customController: { ContentUIHostingController(SnippetExampleView(imageOrientation: .square)) },
                    showPresentable: showPresentable
                ),
                PresentableCellDataSource.custom(
                    title: "Portrait",
                    customController: { ContentUIHostingController(SnippetExampleView(imageOrientation: .portrait)) },
                    showPresentable: showPresentable
                )
            ]
        ).groups()
    }
}
