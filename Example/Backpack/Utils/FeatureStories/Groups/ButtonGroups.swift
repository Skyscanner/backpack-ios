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

// swiftlint:disable line_length
import SwiftUI
import Backpack

@MainActor
struct ButtonGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(
        _ title: String,
        style: BPKButtonStyle,
        backgroundColor: UIColor = BPKColor.canvasColor
    ) -> CellDataSource {
        func enrich(screen: BPKButtonsViewController) {
            screen.style = style
            screen.view?.backgroundColor = backgroundColor
        }
        return PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Buttons", on: "ButtonsViewController"),
            enrich: enrich,
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
                presentable("Primary", style: .primary),
                presentable("Secondary", style: .secondary),
                presentable("Secondary On Dark", style: .secondaryOnDark, backgroundColor: BPKColor.surfaceContrastColor),
                presentable("Destructive", style: .destructive),
                presentable("Featured", style: .featured),
                presentable("Link", style: .link),
                presentable("Link On Dark", style: .linkOnDark, backgroundColor: BPKColor.surfaceContrastColor),
                presentable("Primary On Dark", style: .primaryOnDark, backgroundColor: BPKColor.surfaceContrastColor),
                presentable("Primary On Light", style: .primaryOnLight)
            ]
        ).groups()
    }
    
    func swiftUIGroups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Playground", view: ButtonsPlaygroundView()),
                presentable("Primary", view: ButtonsExampleView(style: .primary)),
                presentable("Secondary", view: ButtonsExampleView(style: .secondary)),
                presentable("Secondary On Dark", view: ButtonsExampleView(style: .secondaryOnDark)),
                presentable("Destructive", view: ButtonsExampleView(style: .destructive)),
                presentable("Featured", view: ButtonsExampleView(style: .featured)),
                presentable("Link", view: ButtonsExampleView(style: .link)),
                presentable("Link On Dark", view: ButtonsExampleView(style: .linkOnDark)),
                presentable("Primary On Dark", view: ButtonsExampleView(style: .primaryOnDark)),
                presentable("Primary On Light", view: ButtonsExampleView(style: .primaryOnLight))
            ]
        ).groups()
    }
}
