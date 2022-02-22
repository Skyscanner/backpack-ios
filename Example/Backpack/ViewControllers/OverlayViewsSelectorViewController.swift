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

import Backpack.OverlayView
import Backpack.BPKColor

enum OverlayViewSegueIdentifier: String {
    case `default` = "default"
    case noOverlay = "overlay_none"
    case largeCorner = "corner_large"
    case showForeground = "foreground_content"
}

class OverlayViewsSelectorViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let target = segue.destination as? OverlayViewsViewController else {
            fatalError("Expected destination to be of type OverlayViewsViewController.")
        }

        if let identifier = segue.identifier,
        let overlayViewSegueIdentifier = OverlayViewSegueIdentifier(rawValue: identifier) {
            switch overlayViewSegueIdentifier {
            case .default:
                target.navigationItem.title = "Default"
                target.cornerStyle = BPKOverlayViewCornerStyle.small
            case .noOverlay:
                target.navigationItem.title = "Without overlay"
                target.cornerStyle = BPKOverlayViewCornerStyle.small
                target.overlayType = .none
            case .largeCorner:
                target.navigationItem.title = "Rounded"
                target.cornerStyle = BPKOverlayViewCornerStyle.large
            case .showForeground:
                target.navigationItem.title = "Foreground content"
                target.cornerStyle = BPKOverlayViewCornerStyle.small
                target.showContent = true
            }
        } else {
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
