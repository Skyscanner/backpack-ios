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
    private let settingsScreenFactory = SettingsScreenFactory()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let isUITestRun = ProcessInfo.processInfo.arguments.contains("UITests")
        guard let window = UIWindowFactory(isUITestsRun: isUITestRun).window(forScene: scene) else { return }
        
        window.rootViewController = rootViewController(isUITestRun: isUITestRun)
        if ThemeHelpers.forceDarkMode() {
            window.overrideUserInterfaceStyle = .dark
        }
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func rootViewController(isUITestRun: Bool) -> UIViewController {
        let presentableNavigator = PresentableNavigator()
        
        let defaultController = DefaultRootViewControllerFactory(
            tokensProvider: TokenCellsProvider(navigator: presentableNavigator),
            componentsProvider: ComponentCellsProvider(
                navigator: presentableNavigator,
                toastDuration: isUITestRun ? 1 : 5
            )
        ).create()
        let navigationController = UINavigationController(rootViewController: defaultController)
        defaultController.navigationItem.title = "Backpack"
        presentableNavigator.navigationController = navigationController
        
        guard ThemeHelpers.isThemingSupported() else { return navigationController }
        
        let themed = ThemedViewControllerFactoryDecorator { navigationController }.create()
        let settingsButton = UIBarButtonItem()
        settingsButton.image = BPKIcon.makeLargeTemplateIcon(name: .settings)
        settingsButton.accessibilityLabel = "Settings"
        settingsButton.target = self
        settingsButton.action = #selector(didTapSettingsButton)
        defaultController.navigationItem.setRightBarButtonItems([settingsButton], animated: false)
        settingsScreenFactory.rootThemedController = themed as? BPKContainerController
        return themed
    }
    
    @objc
    private func didTapSettingsButton() {
        let settings = settingsScreenFactory.settingsViewController()
        self.window?.topMostController()?.present(settings, animated: true, completion: nil)
    }
}
