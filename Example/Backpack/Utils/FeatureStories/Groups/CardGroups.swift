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

struct CardGroupsProvider {
    let showPresentable: (Presentable) -> Void
    
    private func presentableCard(_ title: String, enrich: @escaping (CardsViewController) -> Void) -> CellDataSource {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Cards", on: "CardsViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    private func presentableDevidedCard(
        _ title: String,
        enrich: @escaping (DividedCardsViewController) -> Void
    ) -> CellDataSource {
        PresentableCellDataSource.enrichable(
            title: title,
            storyboard: .named("Cards", on: "DividedCardsViewController"),
            enrich: enrich,
            showPresentable: showPresentable
        )
    }
    
    func groups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentableCard("Default") { _ in },
                presentableCard("Button") { $0.configuration = .button },
                presentableCard("Not elevated") { $0.isElevated = false },
                presentableCard("Link") { $0.configuration = .link },
                presentableCard("Without padding") { $0.padded = false },
                presentableCard("Selected") { $0.selected = true },
                presentableCard("Corner style large") { $0.cornerStyle = .large },
                presentableCard("Background color") { $0.backgroundColor = BPKColor.skyBlueTint01 },
                presentableDevidedCard("With divider") { $0.divisionDirection = .horizontal },
                presentableDevidedCard("With divider and corner style large") { cardVC in
                    cardVC.divisionDirection = .horizontal
                    cardVC.cornerStyle = .large
                },
                presentableDevidedCard("With divider arranged vertically") { $0.divisionDirection = .vertical },
                presentableDevidedCard("With divider without padding") { cardVC in
                    cardVC.divisionDirection = .vertical
                    cardVC.padded = false
                }
            ]
        ).groups()
    }
}

private extension BPKCardConfiguration {
    static var link: BPKCardConfigurationLink {
        BPKCardConfigurationLink(accessibilityLabel: "Test accessibility label")
    }
    
    static var button: BPKCardConfigurationButton {
        BPKCardConfigurationButton(accessibilityLabel: "Test accessibility label")
    }
}
