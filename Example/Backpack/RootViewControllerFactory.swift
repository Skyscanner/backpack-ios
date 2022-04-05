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

import UIKit

protocol RootViewControllerFactory {
    func create() -> UIViewController
}

struct DefaultRootViewControllerFactory: RootViewControllerFactory {
    let tokensProvider: TokenCellsProvider
    let componentsProvider: ComponentCellsProvider
    
    func create() -> UIViewController {
        GroupsViewController(
            groups: HomeGroupsProvider(
                tokens: tokensProvider.cells(),
                components: componentsProvider.cells()
            ).groups()
        )
    }
}

struct ThemedViewControllerFactoryDecorator: RootViewControllerFactory {
    let decoratee: () -> UIViewController
    
    func create() -> UIViewController {
        ThemeHelpers.applyAllThemes()
        let activeTheme = ThemeHelpers.themeDefinition(forTheme: Settings.sharedSettings.activeTheme)
        return BPKThemeContainerController(themeDefinition: activeTheme, rootViewController: decoratee())
    }
}
