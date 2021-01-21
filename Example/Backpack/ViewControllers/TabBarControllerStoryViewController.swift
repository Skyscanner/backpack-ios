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

class TabBarControllerStoryViewController: BPKTabBarController {
    override func viewDidLoad() {
        let tabOne = UIViewController()
        tabOne.view.backgroundColor = BPKColor.backgroundColor
        let tabOneBarItem = UITabBarItem(
            title: "Search",
            image: BPKIcon.makeLargeTemplateIcon(name: .search),
            tag: 1
        )
        tabOne.tabBarItem = tabOneBarItem

        let tabTwo = UIViewController()
        tabTwo.view.backgroundColor = BPKColor.backgroundColor
        let tabTwoBarItem = BPKTabBarItem(
            title: "Explore",
            image: BPKIcon.makeLargeTemplateIcon(name: .explore),
            tag: 2,
            dotImageDefinition: BPKTabBarDotImageDefinition(
                lightImage: UIImage(named: "tab_explore_with_dot_lm")!,
                darkImage: UIImage(named: "tab_explore_with_dot_dm")!
            )
        )
        tabTwo.tabBarItem = tabTwoBarItem

        let tabThree = UIViewController()
        tabThree.view.backgroundColor = BPKColor.backgroundColor
        let tabThreeBarItem = UITabBarItem(
            title: "Trips",
            image: BPKIcon.makeLargeTemplateIcon(name: .trips),
            tag: 3
        )
        tabThreeBarItem.badgeColor = BPKColor.panjin
        tabThreeBarItem.badgeValue = "42"
        tabThree.tabBarItem = tabThreeBarItem

        let tabFour = UIViewController()
        tabFour.view.backgroundColor = BPKColor.backgroundColor
        let tabFourBarItem = BPKTabBarItem(
            title: "Profile",
            image: BPKIcon.makeLargeTemplateIcon(name: .accountCircle),
            tag: 4,
            dotImageDefinition: BPKTabBarDotImageDefinition(
                lightImage: UIImage(named: "tab_profile_with_dot_lm")!,
                darkImage: UIImage(named: "tab_profile_with_dot_dm")!
            )
        )
        tabFour.tabBarItem = tabFourBarItem
        tabFourBarItem.addDot()

        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour]
    }
}
