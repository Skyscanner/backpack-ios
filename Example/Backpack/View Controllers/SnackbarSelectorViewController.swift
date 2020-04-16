/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019 Skyscanner Ltd. All rights reserved.
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

import Foundation

class SnackBarSelectorViewController: UITableViewController {
    override func viewDidLoad() {
          super.viewDidLoad()
          navigationController?.navigationBar.prefersLargeTitles = false
      }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let destinationController = segue.destination as? SnackBarViewController  else {
               fatalError("""
                   The destination of all segues in `SnackbarSelectorViewController`
                   should be `SnackBarViewController`
               """)
           }

        setupDestinationController(destinationController: destinationController, segue: segue)
    }

    // Cyclomatic complexity might be high in this function but it's actually really
    // really straightforward. There's probably some opportunity to improve it.
    // swiftlint:disable cyclomatic_complexity
    func setupDestinationController(destinationController: SnackBarViewController, segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "showWithTitle":
            destinationController.snackBarType = .withTitle
            destinationController.title = "With Title"
        case "showWithTitleAndButton":
            destinationController.snackBarType = .withTitleAndButton
            destinationController.title = "With title and button"
        case "showWithTitleTextAndButton":
            destinationController.snackBarType = .withTitleTextAndButton
            destinationController.title = "With title, text and button"
        case "showWithTitleAndButtonIconOnly":
            destinationController.snackBarType = .withTitleAndButtonIconOnly
            destinationController.title = "With title and button icon only"
        case "showWithTitleButtonAndAccessoryIcon":
            destinationController.snackBarType = .withTitleButtonAndAccessoryIcon
            destinationController.title = "With title, button and accessory icon"
        case "showWithIndefiniteDuration":
            destinationController.snackBarType = .indefiniteDuration
            destinationController.title = "Indefinite duration"
        case "showWithLongDuration":
            destinationController.snackBarType = .longDuration
            destinationController.title = "Long duration"
        case "showWithShortDuration":
            destinationController.snackBarType = .shortDuration
            destinationController.title = "Short duration"
        case "showWithKeyboard":
            destinationController.snackBarType = .withKeyboard
            destinationController.title = "With Keyboard"
        case "showWithDelegate":
            destinationController.snackBarType = .withDelegate
            destinationController.title = "With delegate"
        default:
            fatalError("Unrecognized segue \(segue.identifier.debugDescription)")
        }
    }
    // swiftlint:enable cyclomatic_complexity
}
