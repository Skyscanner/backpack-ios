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

enum HorizontalNavSegueIdentifier: String {
    case `default` = "Default"
    case noUnderline = "NoUnderline"
    case small = "Small"
    case icons = "Icons"
    case smallIcons = "iconsSmall"
    case wide = "Wide"
    case showExtraContent = "withScroll"
    case customItems = "customItems"
    case notificationDot = "withNotification"
    case badge = "withBadge"
    case alternate = "alternateAppearance"
}

class HorizontalNavSelectorViewController: UITableViewController {
    // swiftlint:disable:next function_body_length cyclomatic_complexity
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let maybeHorizontalNavController = segue.destination as? HorizontalNavViewController

        if let identifier = segue.identifier,
            let horizontalNavSegueIdentifier = HorizontalNavSegueIdentifier(rawValue: identifier) {
            switch horizontalNavSegueIdentifier {
            case .default:
                segue.destination.title = "Default"
            case .small:
                segue.destination.title = "Small"
                maybeHorizontalNavController?.size = .small
            case .noUnderline:
                segue.destination.title = "Without underline"
                maybeHorizontalNavController?.showBar = false
            case .icons:
                segue.destination.title = "With icons"
                maybeHorizontalNavController?.showIcons = true
            case .smallIcons:
                segue.destination.title = "Small with icons"
                maybeHorizontalNavController?.size = .small
                maybeHorizontalNavController?.showIcons = true
            case .wide:
                segue.destination.title = "Wide"
                maybeHorizontalNavController?.size = .small
                maybeHorizontalNavController?.showIcons = true
                maybeHorizontalNavController?.wide = true
            case .showExtraContent:
                segue.destination.title = "With scroll"
                maybeHorizontalNavController?.showIcons = true
                maybeHorizontalNavController?.showExtraContent = true
            case .customItems:
                segue.destination.title = "Custom Items"
                maybeHorizontalNavController?.useCustomItems = true
                maybeHorizontalNavController?.showBar = false
            case .notificationDot:
                segue.destination.title = "With Notification Dot"
                maybeHorizontalNavController?.showNotificationDot = true
                maybeHorizontalNavController?.showIcons = true
            case .badge:
                segue.destination.title = "With Badge"
                maybeHorizontalNavController?.useItemWithBadge = true
            case .alternate:
                segue.destination.title = "Alternate appearance"
                maybeHorizontalNavController?.appearance = .alternate
                maybeHorizontalNavController?.showBar = true
            }
        } else {
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
