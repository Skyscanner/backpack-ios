/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

class UIWindowFactory {
    private func isUITestsRun() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("UITests")
    }
    
    func window(forScene scene: UIScene) -> UIWindow? {
        guard let windowScene = (scene as? UIWindowScene) else { return nil }
        let window = UIWindow(windowScene: windowScene)
        if isUITestsRun() {
            let uiTestWindow = UITestsUIWindowSceneDecorator(windowScene: windowScene)
            uiTestWindow.decoratee = window
            return uiTestWindow
        }
        return window
    }
}

class UITestsUIWindowSceneDecorator: UIWindow {
    var decoratee: UIWindow!
    
    override func makeKeyAndVisible() {
        super.makeKeyAndVisible()
        decoratee.layer.speed = 100
        UIView.setAnimationsEnabled(false)
    }
}
