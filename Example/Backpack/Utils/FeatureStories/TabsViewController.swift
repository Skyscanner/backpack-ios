//
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

import Foundation
import Backpack

class TabsViewController: BPKTabBarController {
    
    let tabs: [Components.Tab]
    
    init(title: String, tabs: [Components.Tab]) {
        self.tabs = tabs
        
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabItems = tabs.map { tab -> UIViewController in
            let tabBarItem = BPKTabBarItem()
            tabBarItem.title = tab.title
            tabBarItem.originalImage = tab.image
            
            tab.viewController.tabBarItem = tabBarItem
            
            return tab.viewController
        }
        
        viewControllers = tabItems
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
