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

struct DialogGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        enrich: @escaping (DialogViewController) -> Void
    ) -> Components.Cell {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Main", on: "DialogViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        ).cell
    }
    
    func groups() -> [Components.Group] {
        [
            Components.Group(
                title: "Alert",
                cells: [
                    presentable("With call to action", enrich: { $0.type = .normal }),
                    presentable("Warning", enrich: { $0.type = .warning }),
                    presentable("With no title", enrich: { $0.type = .noTitle }),
                    presentable("Extreme", enrich: { $0.type = .extreme })
                ]
            ),
            Components.Group(
                title: "Bottom sheet",
                cells: [
                    presentable("Delete confirmation", enrich: { $0.type = .delete }),
                    presentable("Success", enrich: { $0.type = .confirmation }),
                    presentable("With no icon", enrich: { $0.type = .noIcon }),
                    presentable("With no icon and no title", enrich: { $0.type = .noIconNoTitle })
                ]
            ),
            Components.Group(
                title: "In-app messaging",
                cells: [
                    presentable("In-app messaging", enrich: { $0.type = .inAppMessaging })
                ]
            )
        ]
    }
}
