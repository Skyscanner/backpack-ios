/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

class TabBarControllerStoryViewController: BPKTabBarController {
    override func viewDidLoad() {
        let tabOne = UIViewController()
        tabOne.view.backgroundColor = BPKColor.backgroundColor
        let tabOneBarItem = UITabBarItem(
            title: "Search",
            image: BPKIcon.makeTemplateIcon(name: .search, size: .large),
            tag: 1
        )
        tabOne.tabBarItem = tabOneBarItem

        let tabTwo = UIViewController()
        tabTwo.view.backgroundColor = BPKColor.backgroundColor
        let tabTwoBarItem = UITabBarItem(
            title: "Settings",
            image: BPKIcon.makeTemplateIcon(name: .settings, size: .large),
            tag: 2
        )
        tabTwo.tabBarItem = tabTwoBarItem

        self.viewControllers = [tabOne, tabTwo]
    }
}
