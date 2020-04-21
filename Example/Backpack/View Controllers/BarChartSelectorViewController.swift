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

enum BarChartSegueIdentifier: String {
    case `default` = "Default"
    case withValue = "WithValue"
}

class BarChartSelectorViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let target = segue.destination as? BarChartsViewController else {
            fatalError("Expected destination to be of type BarChartViewController.")
        }

        if let identifier = segue.identifier,
            let barChartSegueIdentifier = BarChartSegueIdentifier(rawValue: identifier) {
            switch barChartSegueIdentifier {
            case .default:
                target.title = "Default"
            case .withValue:
                target.title = "With value"
                target.fillValue = 0.65
                target.valueDescription = "£200"
            }
        } else {
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
