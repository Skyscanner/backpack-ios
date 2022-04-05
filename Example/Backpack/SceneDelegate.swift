//
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
import Backpack

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let isUITestRun = ProcessInfo.processInfo.arguments.contains("UITests")
        guard let window = UIWindowFactory(isUITestsRun: isUITestRun).window(forScene: scene) else { return }
        
        let groupsScreenFactory = GroupsViewControllerFactory(settingsButton: settingsButton)
        let presentableNavigator = PresentableNavigator(groupsScreenFactory: groupsScreenFactory)
        let groups = HomeGroupsProvider(
            tokens: TokenCellsProvider(navigator: presentableNavigator).cells(),
            components: ComponentCellsProvider(
                navigator: presentableNavigator,
                isUITest: isUITestRun
            ).cells()
        ).groups()
        let rootTableViewController = groupsScreenFactory
            .groupsScreen(title: "Backpack", withGroups: groups)
        let navigationController = UINavigationController(rootViewController: rootTableViewController)
        presentableNavigator.navigationController = navigationController
        window.rootViewController = navigationController
        
        if let rootVc = window.rootViewController, ThemeHelpers.isThemingSupported() {
            ThemeHelpers.applyAllThemes()
            let activeTheme = ThemeHelpers.themeDefinition(forTheme: Settings.sharedSettings.activeTheme)
            let themeController = BPKThemeContainerController(themeDefinition: activeTheme, rootViewController: rootVc)
            window.rootViewController = themeController
        }
        
        self.window = window
        window.makeKeyAndVisible()
        
        if ThemeHelpers.forceDarkMode() {
            self.window?.overrideUserInterfaceStyle = .dark
        }
    }
    
    private var settingsButton: UIBarButtonItem? {
        if !ThemeHelpers.isThemingSupported() { return nil }
        let settingsButton = UIBarButtonItem()
        settingsButton.image = BPKIcon.makeLargeTemplateIcon(name: .settings)
        settingsButton.accessibilityLabel = "Settings"
        settingsButton.target = self
        settingsButton.action = #selector(didTapSettingsButton)
        return settingsButton
    }
    
    @objc
    private func didTapSettingsButton() {
        ExampleApp(getKeyWindow: {
            UIApplication.shared.windows.first(where: \.isKeyWindow)
        }).showSettingsView()
    }
}
