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

struct NavBarGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        enrich: @escaping (NavigationBarViewController) -> Void
    ) -> CellDataSource {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Main", on: "NavigationBarViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Interactive example") { $0.interactive = true },
                presentable("Large - no back button") { $0.showBackbutton = false },
                presentable("Large - with back button") { _ in },
                presentable("Collapsed - simple") {
                    $0.showRightButton = false
                    $0.collapsed = true
                },
                presentable("Interactive example - onImage") {
                    $0.interactive = true
                    $0.isOnImage = true
                },
                presentable("Large - onImage") { $0.isOnImage = true },
                presentable("Collapsed - onImage") {
                    $0.showRightButton = false
                    $0.collapsed = true
                    $0.isOnImage = true
                }
            ]
        ).groups()
    }
}
