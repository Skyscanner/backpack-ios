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

import UIKit

class LabelsSelectorTableViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let maybeLabelsController = segue.destination as? LabelsViewController

        switch segue.identifier {
        case "ShowNormal":
            segue.destination.title = "Default"
            maybeLabelsController?.type = .normal
        case "ShowEmphasized":
            segue.destination.title = "Emphasized"
            maybeLabelsController?.type = .emphasized
        case "ShowHeavy":
            segue.destination.title = "Heavy"
            maybeLabelsController?.type = .heavy
        case "ShowPerformance":
            segue.destination.title = "Performance"
        case "MultipleFontStyles":
            segue.destination.title = "Multiple font styles"
        default:
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
