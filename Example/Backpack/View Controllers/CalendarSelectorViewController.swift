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

enum CalendarSegueIdentifier: String {
    case `default` = "Default"
    case withMaxEnabledDate = "WithMaxEnabledDate"
}

class CalendarSelectorViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let target = segue.destination as? CalendarViewController else {
            fatalError("Expected destination to be of type CalendarViewController.")
        }

        if let identifier = segue.identifier,
            let calendarSegueIdentifier = CalendarSegueIdentifier(rawValue: identifier) {
            switch calendarSegueIdentifier {
            case .default:
                target.title = "Default"
            case .withMaxEnabledDate:
                target.title = "Max enabled date"
                target.maxEnabledDate = true
            }
        } else {
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
