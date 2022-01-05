//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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
    var isUITestingEnabled = false

    // swiftlint:disable line_length
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.isUITestingEnabled = ProcessInfo.processInfo.arguments.contains("UITests")
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let rootTableViewController = BPKRootTableViewController()
        let navigationController = UINavigationController(rootViewController: rootTableViewController)
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
        
        if self.isUITestingEnabled {
            self.window?.layer.speed = 100
            UIView.setAnimationsEnabled(false)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded
        // (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
