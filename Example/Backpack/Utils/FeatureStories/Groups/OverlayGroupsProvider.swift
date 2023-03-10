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

import Backpack

struct OverlayGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        types: [BPKOverlayType]
    ) -> CellDataSource {
        PresentableCellDataSource.customEnrichable(
            title: title,
            customController: { OverlayViewController(types: types) },
            enrich: { controller in
                controller.title = title
            },
            showPresentable: showPresentable
        )
    }
    
    private func foregroundPresentable() -> CellDataSource {
        PresentableCellDataSource.custom(
            title: "Foreground example",
            customController: { OverlayForegroundViewController() },
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Solid", types: [.solidLow, .solidMedium, .solidHigh]),
                presentable("Top", types: [.topLow, .topMedium, .topHigh]),
                presentable("Bottom", types: [.bottomLow, .bottomMedium, .bottomHigh]),
                presentable("Left", types: [.leftLow, .leftMedium, .leftHigh]),
                presentable("Right", types: [.rightLow, .rightMedium, .rightHigh]),
                presentable("Vignette", types: [.vignette]),
                foregroundPresentable()
            ]
        ).groups()
    }
}
