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

import Foundation

enum HorizontalNavigationStory: String, StoryGroup {
    case `default` = "Default"
    case small = "Small"
    case withoutUnderline = "Without underline"
    case withIcons = "With icons"
    case smallWithIcons = "Small with icons"
    case wide = "Wide"
    case withScroll = "With scroll"
    case customItems = "Custom items"
    case withNotifications = "With notification"
    case withBadge = "With badge"
    case alternate = "Alternate"

    var title: String {
        self.rawValue
    }

    var presentableStory: Presentable {
        let presentable = CustomPresentable {
            return HorizontalNavViewController()
        }

        return presentable.enrich(self.configureStory)
    }

    // This isn't actually complex, it's just a large switch
    // swiftlint:disable:next cyclomatic_complexity
    fileprivate func configureStory(viewController: UIViewController) {
        let navVc = viewController as? HorizontalNavViewController

        switch self {
        case .default:
            break
        case .small:
            navVc?.small = true
        case .withoutUnderline:
            navVc?.showBar = false
        case .withIcons:
            navVc?.showIcons = true
        case .smallWithIcons:
            navVc?.small = true
            navVc?.showIcons = true
        case .wide:
            navVc?.small = true
            navVc?.showIcons = true
            navVc?.wide = true
        case .withScroll:
            navVc?.showIcons = true
            navVc?.showExtraContent = true
        case .customItems:
            navVc?.useCustomItems = true
            navVc?.showBar = false
        case .withNotifications:
            navVc?.showNotificationDot = true
            navVc?.showIcons = true
        case .withBadge:
            navVc?.useItemWithBadge = true
        case .alternate:
            navVc?.appearance = .alternate
            navVc?.showBar = true
        }
    }
}
