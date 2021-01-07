/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

class BPKRootTableViewController: BPKNavigationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Backpack"

        if ThemeHelpers.isThemingSupported() {
            let largeSettingsIcon = BPKIcon.makeLargeTemplateIcon(name: .settings)
            let settingsButton: UIBarButtonItem = UIBarButtonItem()
            settingsButton.image = largeSettingsIcon
            settingsButton.accessibilityLabel = "Settings"
            settingsButton.target = self
            settingsButton.action = #selector(self.didTapSettingsButton)
            self.navigationItem.setRightBarButtonItems([settingsButton], animated: false)
        }
    }

    @objc
    func didTapSettingsButton() {
        ExampleApp.showSettingsView()
    }
}
