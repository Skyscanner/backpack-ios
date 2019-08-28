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

enum PanelSegueIdentifier: String {
    case `default` = "Default"
    case withoutPadding = "WithoutPadding"
    case elevated = "Elevated"
}

class PanelSelectorViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let target = segue.destination as? PanelViewController else {
            fatalError("Expected destination to be of type PanelViewController.")
        }

        if let identifier = segue.identifier,
            let panelSegueIdentifier = PanelSegueIdentifier(rawValue: identifier) {
            switch panelSegueIdentifier {
            case .default:
                target.title = "Default"
            case .withoutPadding:
                target.title = "Without padding"
                target.padded = false
            case .elevated:
                target.title = "Elevated style"
                target.style = .elevated
            }
        } else {
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
