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

@MainActor
struct LabelGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        screenType: ScreenType
    ) -> CellDataSource {
        PresentableCellDataSource.customEnrichable(
            title: title,
            customController: { LabelViewController(items: screenType.items) },
            enrich: { controller in
                controller.title = title
            },
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Body", screenType: .body),
                presentable("Heading", screenType: .heading),
                presentable("Hero", screenType: .hero)
            ]
        ).groups()
    }
}

fileprivate extension LabelGroupsProvider {
    enum ScreenType {
        case body, heading, hero
        
        var items: [(BPKFontStyle, String)] {
            switch self {
            case .body:
                return [
                    (.textSubheading, "Subheading"),
                    (.textBodyLongform, "Body Longform"),
                    (.textBodyDefault, "Body default"),
                    (.textFootnote, "Footnote"),
                    (.textCaption, "Caption"),
                    (.textLabel1, "Label 1"),
                    (.textLabel2, "Label 2"),
                    (.textLabel3, "Label 3")
                ]
                
            case .heading:
                return [
                    (.textHeading1, "Heading 1"),
                    (.textHeading2, "Heading 2"),
                    (.textHeading3, "Heading 3"),
                    (.textHeading4, "Heading 4"),
                    (.textHeading5, "Heading 5")
                ]
            case .hero:
                return [
                    (.textHero1, "Hero 1"),
                    (.textHero2, "Hero 2"),
                    (.textHero3, "Hero 3"),
                    (.textHero4, "Hero 4"),
                    (.textHero5, "Hero 5")
                ]
            }
        }
    }
}
