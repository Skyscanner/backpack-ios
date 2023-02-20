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
import SwiftUI

struct RatingGroupsProvider {
    let showPresentable: (Presentable) -> Void

    private func presentable(
        _ title: String,
        titleType: RatingsViewController.TitleType
    ) -> CellDataSource {
        PresentableCellDataSource.customEnrichable(
            title: title,
            customController: { RatingsViewController(titleType: titleType) },
            enrich: { controller in
                controller.title = title
            },
            showPresentable: showPresentable
        )
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

    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("BPKRating: title text", titleType: .stringLabel),
                presentable("BPKRating: titleView - BPKStarRating", titleType: .starRating),
                presentable("BPKRating: titleView - ImageView", titleType: .imageView)
            ]
        ).groups()
    }

    func swiftUIGroups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("BPKRating: title text", view: RatingExampleView(titleType: .stringLabel)),
                presentable("BPKRating: titleView image", view: RatingExampleView(titleType: .image))
            ]
        ).groups()
    }
}
