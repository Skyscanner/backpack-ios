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
import Backpack_SwiftUI

@MainActor
struct TextGroupsProvider {
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
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Body", view: TextExampleView(items: ScreenType.body.items)),
                presentable("Heading", view: TextExampleView(items: ScreenType.heading.items)),
                presentable("Hero", view: TextExampleView(items: ScreenType.hero.items))
            ]
        ).groups()
    }
}

fileprivate extension TextGroupsProvider {
    enum ScreenType {
        case body, heading, hero
        
        var items: [(Backpack_SwiftUI.BPKFontStyle, String)] {
            switch self {
            case .body:
                return [
                    (.subheading, "Subheading"),
                    (.bodyLongform, "Body Longform"),
                    (.bodyDefault, "Body default"),
                    (.footnote, "Footnote"),
                    (.caption, "Caption"),
                    (.label1, "Label 1"),
                    (.label2, "Label 2"),
                    (.label3, "Label 3")
                ]
                
            case .heading:
                return [
                    (.heading1, "Heading 1"),
                    (.heading2, "Heading 2"),
                    (.heading3, "Heading 3"),
                    (.heading4, "Heading 4"),
                    (.heading5, "Heading 5")
                ]
            case .hero:
                return [
                    (.hero1, "Hero 1"),
                    (.hero2, "Hero 2"),
                    (.hero3, "Hero 3"),
                    (.hero4, "Hero 4"),
                    (.hero5, "Hero 5")
                ]
            }
        }
    }
}
