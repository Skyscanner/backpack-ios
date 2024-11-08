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

open class BPKTabBarController: UITabBarController {
    public override var selectedIndex: Int {
        didSet {
            updateTabBarItems()
        }
    }
    
    public override var selectedViewController: UIViewController? {
        didSet {
            updateTabBarItems()
        }
    }
    
    public override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        updateTabBarItems()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            updateTabBarItems()
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = nil
    }

    private func updateTabBarItems() {
        let interfaceStyle = self.traitCollection.userInterfaceStyle
        
        tabBar.items?.forEach { item in
            if let item = item as? BPKTabBarItem {
                item.interfaceStyle = interfaceStyle
            }
        }
    }
}
