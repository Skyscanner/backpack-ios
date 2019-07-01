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

class TappableLinkLabelsSelectorViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let maybeTappableLinkLabelsController = segue.destination as? TappableLinkLabelsViewController

        switch segue.identifier {
        case "SingleLink":
            segue.destination.title = "Single link"
        case "MultipleLinks":
            segue.destination.title = "Multiple links"
            maybeTappableLinkLabelsController?.linkCount = .double
        case "AlternateStyle":
            segue.destination.title = "Alternate style links"
            maybeTappableLinkLabelsController?.linkCount = .double
            maybeTappableLinkLabelsController?.style = .alternate
        case "NonURLLinks":
            segue.destination.title = "Non-URL links"
            maybeTappableLinkLabelsController?.linkCount = .double
            maybeTappableLinkLabelsController?.linkType = .print
        default:
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
