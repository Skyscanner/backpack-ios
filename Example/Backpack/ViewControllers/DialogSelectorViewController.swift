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

// swiftlint:disable cyclomatic_complexity
class DialogSelectorViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationController = segue.destination as? DialogViewController  else {
            fatalError("""
                The destination of all seguesf in `DialogSelectorViewController`
                should be `DialogViewController`
            """)
        }

        switch segue.identifier {
        case "ShowCTA":
            destinationController.type = .normal
            destinationController.title = "With call to action"
        case "ShowWarning":
            destinationController.type = .warning
            destinationController.title = "Warning"
        case "ShowDelete":
            destinationController.type = .delete
            destinationController.title = "Delete confirmation"
        case "ShowSuccess":
            destinationController.type = .confirmation
            destinationController.title = "Success"
        case "ShowNoIcon":
            destinationController.type = .noIcon
            destinationController.title = "No icon"
        case "ShowNoTitle":
            destinationController.type = .noTitle
            destinationController.title = "No title"
        case "ShowNoIconNoTitle":
            destinationController.type = .noIconNoTitle
            destinationController.title = "No icon and no title"
        case "Extreme":
            destinationController.type = .extreme
            destinationController.title = "Extreme"
        case "InAppMessaging":
            destinationController.type = .inAppMessaging
            destinationController.title = "In-app messaging"
        default:
            fatalError("Unrecognized segue \(segue.identifier.debugDescription)")
        }
    }
}
