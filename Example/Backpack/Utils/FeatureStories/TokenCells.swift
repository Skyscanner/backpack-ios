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
            PresentableCellDataSource.custom(
                title: "Colors",
                customController: { ContentUIHostingController(ColorTokensView()) },
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
            spacingGroup,
            radiiGroup,
            shadowGroup
        ]
        return dataSources.map(\.cell)
    }
    
    private var spacingGroup: GroupCellDataSource {
        GroupCellDataSource(
            title: "Spacings",
            groups: SingleGroupProvider(
                cellDataSources: [
                    PresentableCellDataSource.custom(
                        title: "SwiftUI",
                        customController: { ContentUIHostingController(SpacingTokensView()) },
                        showPresentable: show(presentable:)
                    ),
                    PresentableCellDataSource.custom(
                        title: "UIKit",
                        customController: { SpacingTokensViewController() },
                        showPresentable: show(presentable:)
                    )
                ]).groups(),
            showChildren: { showChildren(for: "Spacings", children: $0) }
        )
    }
    
    private var radiiGroup: GroupCellDataSource {
        GroupCellDataSource(
            title: "Radii",
            groups: SingleGroupProvider(
                cellDataSources: [
                    PresentableCellDataSource.custom(
                        title: "SwiftUI",
                        customController: { ContentUIHostingController(RadiusTokensView()) },
                        showPresentable: show(presentable:)
                    ),
                    PresentableCellDataSource.custom(
                        title: "UIKit",
                        customController: { RadiusTokensViewController() },
                        showPresentable: show(presentable:)
                    )
                ]).groups(),
            showChildren: { showChildren(for: "Radii", children: $0) }
        )
    }
    
    private var shadowGroup: GroupCellDataSource {
        GroupCellDataSource(
            title: "Shadows",
            groups: SingleGroupProvider(
                cellDataSources: [
                    PresentableCellDataSource.custom(
                        title: "SwiftUI",
                        customController: { ContentUIHostingController(ShadowTokensView()) },
                        showPresentable: show(presentable:)
                    ),
                    PresentableCellDataSource(
                        title: "UIKit",
                        storyboard: .named("Main", on: "ShadowsViewController"),
                        showPresentable: show(presentable:)
                    )
                ]).groups(),
            showChildren: { showChildren(for: "Gradients", children: $0) }
        )
    }
}
