//
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

import Backpack

final class BottomSheetViewController: UITableViewController {

    @IBOutlet weak var scrollViewBottomSheet: UITableViewCell!
    @IBOutlet weak var bottomSectionBottomSheet: UITableViewCell!

}

// MARK: - UITableViewDelegate
extension BottomSheetViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let cell = tableView.cellForRow(at: indexPath)
        switch cell {
        case scrollViewBottomSheet:
            guard let content = BottomSheetContentViewController.make() else { return }

            let sheet = BottomSheet(contentViewController: content,
                                    scrollViewToTrack: content.tableView)
            sheet.present(in: self, animated: true, completion: nil)
        case bottomSectionBottomSheet:
            guard let content = BottomSheetContentViewController.make(),
                let bottomSection = BottomSheetBottomSectionViewController.make() else { return }

            let sheet = BottomSheet(contentViewController: content,
                                    scrollViewToTrack: content.tableView,
                                    bottomSectionViewController: bottomSection)

            bottomSection.dismissClosure = {
                sheet.viewControllerToPresent.dismiss(animated: true, completion: nil)
            }

            sheet.present(in: self, animated: true, completion: nil)
        default: break
        }
    }

}
