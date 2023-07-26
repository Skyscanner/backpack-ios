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

import SwiftUI
import Backpack_SwiftUI

struct BottomSheetProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable<Content: View>(
        _ title: String,
        view: Content
    ) -> CellDataSource {
        PresentableCellDataSource.customEnrichable(
            title: title,
            customController: { ContentUIHostingController(view) },
            enrich: { controller in
                controller.title = title
            },
            showPresentable: showPresentable
        )
    }
    
    func swiftUIGroups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Bottom Sheet with a scroll view", view: BottomSheetFullSizeExampleView()),
                presentable("Bottom Sheet with header", view: BottomSheetRegularExampleView()),
                presentable(
                    "Bottom Sheet with different heights",
                    view: BottomSheetFullSizeExampleView(minHeight: 300)
                )
            ]
        ).groups()
    }
}
