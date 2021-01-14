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
    @IBOutlet var scrollViewBottomSheet: UITableViewCell!
    @IBOutlet var bottomSectionBottomSheet: UITableViewCell!
    @IBOutlet var sheetPresentingSheet: UITableViewCell!
    @IBOutlet var nonScrollableContentBottomSheet: UITableViewCell!
    @IBOutlet var resizableContentBottomSheet: UITableViewCell!
    @IBOutlet var persistentBottomSheet: UITableViewCell!
}

// MARK: - UITableViewDelegate
extension BottomSheetViewController {

    // swiftlint:disable:next function_body_length cyclomatic_complexity
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rootViewController =  UIApplication.shared.keyWindow?.rootViewController as?
            BPKThemeContainerController else {
                return
        }

        tableView.deselectRow(at: indexPath, animated: true)

        let cell = tableView.cellForRow(at: indexPath)
        switch cell {
        case scrollViewBottomSheet:
            guard let content = BottomSheetScrollableContentViewController.make() else { return }

            let wrappedContent = rootViewController.createIdenticalContainerController(forRootController: content)

            let sheet = BPKBottomSheet(contentViewController: wrappedContent,
                                    scrollViewToTrack: content.tableView)
            sheet.present(in: self, animated: true, completion: nil)
        case bottomSectionBottomSheet:
            guard let content = BottomSheetScrollableContentViewController.make(),
                let bottomSection = BottomSheetBottomSectionViewController.make() else { return }

            let wrappedContent = rootViewController.createIdenticalContainerController(forRootController: content)
            let wrappedBottomSection = rootViewController.createIdenticalContainerController(
                forRootController: bottomSection
            )

            bottomSection.view.backgroundColor = BPKColor.backgroundTertiaryColor
            wrappedBottomSection.view.backgroundColor = bottomSection.view.backgroundColor

            let sheet = BPKBottomSheet(contentViewController: wrappedContent,
                                    scrollViewToTrack: content.tableView,
                                    bottomSectionViewController: wrappedBottomSection)

            bottomSection.buttonText = "Dismiss"

            bottomSection.buttonClickedClosure = {
                sheet.viewControllerToPresent.dismiss(animated: true, completion: nil)
            }

            sheet.present(in: self, animated: true, completion: nil)
        case sheetPresentingSheet:
            guard let content = BottomSheetScrollableContentViewController.make(),
                let bottomSection = BottomSheetBottomSectionViewController.make() else { return }

            let wrappedContent = rootViewController.createIdenticalContainerController(forRootController: content)
            let wrappedBottomSection = rootViewController.createIdenticalContainerController(
                forRootController: bottomSection
            )

            bottomSection.view.backgroundColor = BPKColor.backgroundTertiaryColor
            wrappedBottomSection.view.backgroundColor = bottomSection.view.backgroundColor

            let sheet = BPKBottomSheet(contentViewController: wrappedContent,
                                    scrollViewToTrack: content.tableView,
                                    bottomSectionViewController: wrappedBottomSection)

            bottomSection.buttonText = "Next step"

            bottomSection.buttonClickedClosure = {
                guard let content = BottomSheetContentViewController.make() else { return }
                content.view.accessibilityIdentifier = "SheetPresentingSheet.SecondSheet.view"

                let wrappedContent = rootViewController.createIdenticalContainerController(forRootController: content)
                let nextSheet = BPKBottomSheet(contentViewController: wrappedContent)
                sheet.present(nextSheet, animated: true)
            }

            sheet.present(in: self, animated: true, completion: nil)
        case nonScrollableContentBottomSheet:
            guard let content = BottomSheetContentViewController.make() else { return }
            let wrappedContent = rootViewController.createIdenticalContainerController(forRootController: content)

            let sheet = BPKBottomSheet(contentViewController: wrappedContent)
            sheet.present(in: self, animated: true)
        case resizableContentBottomSheet:
            guard let content = BottomSheetResizableContentViewController.make() else { return }
            let wrappedContent = rootViewController.createIdenticalContainerController(forRootController: content)

            let sheet = BPKBottomSheet(contentViewController: wrappedContent)

            content.contentDidUpdateConstraints = {
                UIView.animate(withDuration: 0.3) {
                    sheet.updateLayout()
                }
            }

            sheet.present(in: self, animated: true)
        case persistentBottomSheet:
            let viewController = BottomSheetPersistentViewController()
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        default: break
        }
    }

}
