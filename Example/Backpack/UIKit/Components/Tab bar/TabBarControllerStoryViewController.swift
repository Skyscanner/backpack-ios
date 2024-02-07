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

class TabBarControllerStoryViewController: BPKTabBarController {
    override func viewDidLoad() {
        // Home
        let homeTab = UIViewController()
        homeTab.view.backgroundColor = BPKColor.canvasColor
        
        let homeTabBarItem = BPKTabBarItem(
            title: "Home",
            image: UIImage(named: "tab_home"),
            selectedImage: UIImage(named: "tab_home_selected")
        )
        homeTab.tabBarItem = homeTabBarItem
        
        // Search
        let searchTab = UIViewController()
        searchTab.view.backgroundColor = BPKColor.canvasColor
        
        let searchTabBarItem = BPKTabBarItem(
            title: "Search",
            image: UIImage(named: "tab_search"),
            selectedImage: UIImage(named: "tab_search_selected")
        )
        searchTab.tabBarItem = searchTabBarItem
        
        // Profile
        let profileTab = UIViewController()
        profileTab.view.backgroundColor = BPKColor.canvasColor
        
        let profileTabBarItem = BPKTabBarItem(
            title: "Profile",
            image: UIImage(named: "tab_profile"),
            selectedImage: UIImage(named: "tab_profile_selected"),
            dotImage: .init(
                lightImage: UIImage(named: "tab_profile_dot_lm"),
                darkImage: UIImage(named: "tab_profile_dot_dm")
            ),
            selectedDotImage: UIImage(named: "tab_profile_dot_selected")
        )
        profileTab.tabBarItem = profileTabBarItem
        profileTabBarItem.addDot()
        
        self.viewControllers = [homeTab, searchTab, profileTab]
    }
}
