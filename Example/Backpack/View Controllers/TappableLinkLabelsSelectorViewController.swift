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

enum TappableLinkLabelsSegueIdentifier: String {
    case singleLink = "SingleLink"
    case multipleLinks = "MultipleLinks"
    case alternateStyle = "AlternateStyle"
    case nonURLLinks = "NonURLLinks"
}

class TappableLinkLabelsSelectorViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let maybeTappableLinkLabelsController = segue.destination as? TappableLinkLabelsViewController

        if let identifier = segue.identifier,
            let tappableLinkLabelsSegueIdentifier = TappableLinkLabelsSegueIdentifier(rawValue: identifier) {
            switch tappableLinkLabelsSegueIdentifier {
            case .singleLink:
                segue.destination.title = "Single link"
            case .multipleLinks:
                segue.destination.title = "Multiple links"
                maybeTappableLinkLabelsController?.linkCount = .double
            case .alternateStyle:
                segue.destination.title = "Alternate style links"
                maybeTappableLinkLabelsController?.linkCount = .double
                maybeTappableLinkLabelsController?.style = .alternate
            case .nonURLLinks:
                segue.destination.title = "Non-URL links"
                maybeTappableLinkLabelsController?.linkCount = .double
                maybeTappableLinkLabelsController?.linkType = .print
            }
        } else {
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
