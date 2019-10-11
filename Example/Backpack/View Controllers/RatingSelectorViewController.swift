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

enum RatingSegueIdentifier: String {
    case `default` = "Default"
    case withSubtitle = "WithSubtitle"
    case sizes = "Sizes"
    case verticalLayout = "VerticalLayout"
}

class RatingSelectorViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let target = segue.destination as? RatingsViewController else {
            fatalError("Expected destination to be of type RatingViewController.")
        }

        if let identifier = segue.identifier,
            let ratingSegueIdentifier = RatingSegueIdentifier(rawValue: identifier) {
            switch ratingSegueIdentifier {
            case .default:
                target.title = "Default"
            case .withSubtitle:
                target.title = "Subtitles"
                target.showSubtitle = true
            case .sizes:
                target.title = "Sizes"
                target.showSubtitle = true
                target.showDifferentSizes = true
            case .verticalLayout:
                target.title = "Vertical layout"
                target.showSubtitle = true
                target.showDifferentSizes = true
                target.layout = .vertical
            }
        } else {
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
