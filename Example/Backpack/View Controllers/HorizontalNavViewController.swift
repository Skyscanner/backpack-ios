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

class HorizontalNavViewController: UIViewController, BPKTappableLinkLabelDelegate {
    @IBOutlet weak var horizontalNav: BPKHorizontalNavigation!

    var size: BPKHorizontalNavigationSize = .default
    var appearance: BPKHorizontalNavigationAppearance = .normal
    var showBar: Bool = true
    var showIcons: Bool = false
    var wide: Bool = false
    var showExtraContent = false
    var useCustomItems = false
    var showNotificationDot = false
    var useItemWithBadge = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if showIcons {
            horizontalNav.options = [
                BPKHorizontalNavigationOption(name: "Flights", iconName: .flight, tag: 0),
                BPKHorizontalNavigationOption(name: "Hotels", tag: 1,
                                              iconName: .hotels,
                                              showNotificationDot: showNotificationDot),
                BPKHorizontalNavigationOption(name: "Car hire", iconName: .cars, tag: 2)
            ]
        } else {
            horizontalNav.options = [
                BPKHorizontalNavigationOption(name: "Flights", tag: 0),
                BPKHorizontalNavigationOption(name: "Hotels", tag: 1),
                BPKHorizontalNavigationOption(name: "Car hire", tag: 2)
            ]
        }

        if showExtraContent {
            horizontalNav.options += [
                BPKHorizontalNavigationOption(name: "Flights", tag: 0),
                BPKHorizontalNavigationOption(name: "Hotels", tag: 1),
                BPKHorizontalNavigationOption(name: "Car hire", tag: 2)
            ]
        }

        if useCustomItems {
            horizontalNav.options = [
                BPKHorizontalNavigationOptionWithBackground(title: "Flights", tag: 0),
                BPKHorizontalNavigationOptionWithBackground(title: "Hotels", tag: 1),
                BPKHorizontalNavigationOptionWithBackground(title: "Car hire", tag: 2)
            ]
        }

        if useItemWithBadge {
            horizontalNav.options = [
                BPKHorizontalNavigationOption(name: "Flights", iconName: .flight, tag: 0),
                BPKHorizontalNavigationOptionWithBadge(title: "Hotels", badgeMessage: "NEW", tag: 1),
                BPKHorizontalNavigationOption(name: "Car hire", tag: 2)
            ]
        }

        horizontalNav.showsSelectedBar = showBar
        horizontalNav.size = size
        horizontalNav.selectedItemIndex = 0

        if wide {
            horizontalNav.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }

        horizontalNav.appearance = appearance
        if case .alternate = appearance {
            horizontalNav.backgroundColor = BPKColor.skyGray
        }
    }
}
