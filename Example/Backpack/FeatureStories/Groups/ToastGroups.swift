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

import Foundation

struct ToastGroupsProvider {
    let showPresentable: (Presentable) -> Void
    let toastDuration: TimeInterval
    
    private func presentable(
        _ title: String,
        enrich: @escaping (ToastViewController) -> Void
    ) -> CellDataSource {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Main", on: "ToastViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Docs") {
                    $0.type = .docs
                    $0.toastHideTime = toastDuration
                },
                presentable("Default") {
                    $0.type = .defaultToast
                    $0.toastHideTime = toastDuration
                },
                presentable("With labels only") {
                    $0.type = .onlyLabels
                    $0.toastHideTime = toastDuration
                }
            ]
        ).groups()
    }
}
