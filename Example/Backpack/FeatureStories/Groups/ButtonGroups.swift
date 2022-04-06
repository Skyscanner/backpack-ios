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

struct ButtonGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentable(_ title: String, style: BPKButtonStyle) -> CellDataSource {
        func enrich(screen: BPKButtonsViewController) {
            screen.style = style
        }
        return PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Buttons", on: "ButtonsViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Primary", style: .primary),
                presentable("Secondary", style: .secondary),
                presentable("Destructive", style: .destructive),
                presentable("Featured", style: .featured),
                presentable("Link", style: .link),
                presentable("Primary On Dark", style: .primaryOnDark),
                presentable("Primary On Light", style: .primaryOnLight)
            ]
        ).groups()
    }
}
