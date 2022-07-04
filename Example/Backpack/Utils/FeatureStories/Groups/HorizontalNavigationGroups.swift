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

struct HorizontalNavigationGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        enrich: @escaping (HorizontalNavViewController) -> Void
    ) -> CellDataSource {
        PresentableCellDataSource.customEnrichable(
            title: title,
            customController: { HorizontalNavViewController() },
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default") { _ in },
                presentable("Small") { $0.small = true },
                presentable("Without underline") { $0.showBar = false },
                presentable("With icons") { $0.showIcons = true },
                presentable("Small with icons") {
                    $0.small = true
                    $0.showIcons = true
                },
                presentable("Wide") {
                    $0.small = true
                    $0.showIcons = true
                    $0.wide = true
                },
                presentable("With scroll") {
                    $0.showIcons = true
                    $0.showExtraContent = true
                },
                presentable("Custom items") {
                    $0.useCustomItems = true
                    $0.showBar = false
                },
                presentable("Alternate") {
                    $0.appearance = .alternate
                    $0.showBar = true
                }
            ]
        ).groups()
    }
}
