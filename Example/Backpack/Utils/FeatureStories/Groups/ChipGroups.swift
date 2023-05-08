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

struct ChipsGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        style: BPKChipStyle,
        titleColor: UIColor = BPKColor.textPrimaryColor
    ) -> CellDataSource {
        PresentableCellDataSource.customEnrichable(
            title: title,
            customController: { ChipsViewController(style: style, titleColor: titleColor) },
            enrich: { controller in
                if style == .onDark {
                    controller.view.backgroundColor = BPKColor.black
                }
                
                if style == .onImage {
                    controller.view.backgroundColor = BPKColor.surfaceDefaultColor
                }
                
                controller.title = title
            },
            showPresentable: showPresentable
        )
    }
    
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
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default", style: .default),
                presentable("On Dark", style: .onDark, titleColor: BPKColor.textOnDarkColor),
                presentable("On Image", style: .onImage)
            ]
        ).groups()
    }
    
    func swiftUIGroups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default", view: ChipExampleView(style: .default)),
                presentable(
                    "On Dark",
                    view: ChipExampleView(style: .onDark)
                        .background(.black)
                ),
                presentable(
                    "On Image",
                    view: ZStack {
                        Image("canadian_rockies_canada")
                            .resizable()
                            .scaledToFit()
                            .clipped()
                        ChipExampleView(style: .onImage)
                    }
                )
            ]
        ).groups()
    }
}
