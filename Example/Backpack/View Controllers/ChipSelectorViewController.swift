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

enum ChipSegueIdentifier: String {
    case `default` = "Default"
    case withoutShadow = "WithoutShadow"
    case withBackgroundColor = "WithBackgroundColor"
    case backgroundColorNoShadow = "BackgroundColorNoShadow"
    case backgroundColorUnselectedNoShadow = "BackgroundColorUnselectedNoShadow"
}

class ChipSelectorViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let target = segue.destination as? ChipsViewController else {
            fatalError("Expected destination to be of type ChipViewController.")
        }

        if let identifier = segue.identifier,
            let chipSegueIdentifier = ChipSegueIdentifier(rawValue: identifier) {
            switch chipSegueIdentifier {
            case .default:
                target.title = "Default"
            case .withoutShadow:
                target.title = "Without shadow"
                target.shadow = false
            case .withBackgroundColor:
                target.title = "Background color"
                target.backgroundTint = BPKColor.panjin
            case .backgroundColorNoShadow:
                target.title = "Background color"
                target.shadow = false
                target.backgroundTint = BPKColor.panjin
            case .backgroundColorUnselectedNoShadow:
                target.title = "Background color"
                target.shadow = false
                target.colorUnselectedState = true
                target.backgroundTint = BPKColor.panjin
            }
        } else {
            fatalError("Unknown segue identifer \(segue.identifier.debugDescription)")
        }
    }
}
