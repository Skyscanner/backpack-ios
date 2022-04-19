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

import SwiftUI

struct TokenCellsProvider {
    let navigator: PresentableNavigator
    
    private func show(presentable: Presentable) {
        navigator.present(presentable: presentable)
    }
    
    private func showChildren(for title: String, children: [Components.Group]) {
        navigator.present(title: title, groups: children)
    }
    
    func cells() -> [Components.Cell] {
        let dataSources: [CellDataSource] = [
            PresentableCellDataSource(
                title: "Colors",
                storyboard: .named("Main", on: "ColorsViewController"),
                showPresentable: show(presentable:)
            ),
            GroupCellDataSource(
                title: "Gradients",
                groups: SingleGroupProvider(
                    cellDataSources: [
                        PresentableCellDataSource(
                            title: "Primary",
                            storyboard: .named("Gradients", on: "PrimaryGradientViewController"),
                            showPresentable: show(presentable:)
                        ),
                        PresentableCellDataSource(
                            title: "Baseline Scrim",
                            storyboard: .named("Gradients", on: "GradientViewController"),
                            showPresentable: show(presentable:)
                        )
                    ]).groups(),
                showChildren: { showChildren(for: "Gradients", children: $0) }
            ),
            PresentableCellDataSource.custom(
                title: "Spacings",
                customController: { ContentUIHostingController(SpacingsView()) },
                showPresentable: show(presentable:)
            ),
            PresentableCellDataSource.custom(
                title: "Radii",
                customController: { ContentUIHostingController(RadiusView()) },
                showPresentable: show(presentable:)
            ),
            PresentableCellDataSource(
                title: "Shadows",
                storyboard: .named("Main", on: "ShadowsViewController"),
                showPresentable: show(presentable:)
            )
        ]
        return dataSources.map(\.cell)
    }
}
