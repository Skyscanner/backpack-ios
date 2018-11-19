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

import Backpack.Card

class CardsSelectorViewController: UITableViewController {
    func prepareDevided(for segue: UIStoryboardSegue, sender: Any?) {
        guard let target = segue.destination as? DividedCardsViewController else {
            fatalError("Expected destination to be of type DividedCardsViewController.")
        }
        switch segue.identifier {
        case "divided_horizontal":
            target.navigationItem.title = "With divider"
            target.divisionDirection = .horizontal
        case "divided_horizontal_corner_style_large":
            target.navigationItem.title = "With divider and Corner style large"
            target.divisionDirection = .horizontal
            target.cornerStyle = .large
        case "divided_vertical":
            target.navigationItem.title = "With divider arranged vertically"
            target.divisionDirection = .vertical
        case "divided_vertical_no_padding":
            target.navigationItem.title = "With divider, without padding"
            target.divisionDirection = .vertical
            target.padded = false
        default:
            fatalError("The identifier \(segue.identifier.debugDescription) does not " +
                "match an example DividedCard configuration.")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier?.contains("divided") ?? false {
            prepareDevided(for: segue, sender: sender)
            return
        }

        guard let target = segue.destination as? CardsViewController else {
            fatalError("Expected destination to be of type CardsViewController.")
        }

        switch segue.identifier {
        case "default":
            target.navigationItem.title = "Default"
        case "without_padding":
            target.navigationItem.title = "Without padding"
            target.padded = false
        case "selected":
            target.navigationItem.title = "Selected"
            target.selected = true
        case "corner_style_large":
            target.navigationItem.title = "Corner style large"
            target.cornerStyle = BPKCardCornerStyle.large
        default:
            fatalError("The identifier \(segue.identifier.debugDescription) does not " +
                "match an example Card configuration.")
        }
    }

}
