/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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

class HorizontalNavViewController: UIViewController, BPKTappableLinkLabelDelegate {
    @IBOutlet weak var horizontalNav: HorizontalNavigation!

    var size: BPKHorizontalNavigationSize = .default
    var showBar: Bool = true
    var showIcons: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if showIcons {
            horizontalNav.options = [
                BPKHorizontalNavigationOption(name: "Flights", iconName: .flight),
                BPKHorizontalNavigationOption(name: "Hotels", iconName: .hotels),
                BPKHorizontalNavigationOption(name: "Car hire", iconName: .cars)
            ]
        } else {
            horizontalNav.options = [
                BPKHorizontalNavigationOption(name: "Flights"),
                BPKHorizontalNavigationOption(name: "Hotels"),
                BPKHorizontalNavigationOption(name: "Car hire")
            ]
        }
        horizontalNav.showsSelectedBar = showBar
        horizontalNav.size = size
        horizontalNav.selectedItemIndex = 0
    }
}
