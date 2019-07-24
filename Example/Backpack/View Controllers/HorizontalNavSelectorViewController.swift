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

enum HorizontalNavSegueIdentifier: String {
    case `default` = "Default"
}

class HorizontalNavSelectorViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let maybeHorizontalNavController = segue.destination as? HorizontalNavViewController

        if let identifier = segue.identifier,
            let horizontalNavSegueIdentifier = HorizontalNavSegueIdentifier(rawValue: identifier) {
            switch horizontalNavSegueIdentifier {
            case .default:
                segue.destination.title = "Default"
            }
        } else {
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
