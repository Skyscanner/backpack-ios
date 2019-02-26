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

enum DialogType {
    case normal
    case warning
    case delete
    case confirmation
}

class DialogViewController: UIViewController {
    @IBOutlet weak var showButton: Backpack.Button!
    var type: DialogType = .normal

    @IBAction func show(_ sender: Backpack.Button) {
        switch type {
        case .normal:
            showNormal()
        case .warning:
            showWarning()
        case .delete:
            showDelete()
        case .confirmation:
            showConfirmation()
        }
    }

    func showNormal() {
        let message = "Your flight is all booked. Why not check out some hotels now?"
        let iconTemplate = Backpack.Icon.makeTemplateIcon(name: .tick, size: .large)
        let dialogController  = DialogController(title: "You are going to Tokyo!",
                                                message: message,
                                                style: .alert,
                                                iconBackgroundColor: Color.green500,
                                                iconImage: iconTemplate)

        let mainAction = DialogButtonAction(title: "Continue", style: .primary) {
            print("Primary was tapped, action: \($0)")
        }
        let skipAction = DialogButtonAction(title: "Skip", style: .link) {
            print("Skip was tapped, action: \($0)")
        }

        let scrimAction = DialogScrimAction(handler: { (didDismiss) in
            print("Scrim tap \(didDismiss ? "dimissing" : "")")
        }, shouldDismiss: true)

        dialogController.addButtonAction(mainAction)
        dialogController.addButtonAction(skipAction)
        dialogController.scrimAction = scrimAction

        self.present(dialogController, animated: true, completion: nil)
    }

    func showConfirmation() {
        let message = """
        Your booking is being processed with Trip.com

        As soon as your booking has been completed, your confirmation email will be sent to your email account.

        Remember to check your junk mail folder

        Please note down your reference number and contact Trip.com if you need to track, change or cancel your booking

        Safe travels!
        """
        let iconTemplate = Backpack.Icon.makeTemplateIcon(name: .tick, size: .large)
        let alertController = DialogController(title: "You're almost ready to pack your bags!",
                                               message: message,
                                               style: .bottomSheet,
                                               iconBackgroundColor: Color.green500,
                                               iconImage: iconTemplate)

        let scrimAction = DialogScrimAction(handler: { (didDismiss) in
            NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
        }, shouldDismiss: true)

        alertController.scrimAction = scrimAction

        self.present(alertController, animated: true, completion: nil)
    }

    func showWarning() {
        let message = "Engine Overload.!^R? Please do something. Throw me into the freezer or something!!"
        let iconTemplate = Backpack.Icon.makeTemplateIcon(name: .lightning, size: .large)
        let alertController = DialogController(title: "!#$Warning-0-1!#$#$?",
                                               message: message,
                                               style: .alert,
                                               iconBackgroundColor: Color.yellow500,
                                               iconImage: iconTemplate)

        let mainAction = DialogButtonAction(title: "OK", style: .link) { _ in
            NSLog("Primary tapped")
        }

        let scrimAction = DialogScrimAction(handler: { (didDismiss) in
            NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
        }, shouldDismiss: true)

        alertController.addButtonAction(mainAction)
        alertController.scrimAction = scrimAction

        self.present(alertController, animated: true, completion: nil)
    }

    func showDelete() {
        let iconTemplate = Backpack.Icon.makeTemplateIcon(name: .trash, size: .large)
        let alertController = DialogController(title: "Delete?",
                                               message: "Are you sure you would like to delete your avatar?",
                                               style: .bottomSheet,
                                               iconBackgroundColor: Color.red500,
                                               iconImage: iconTemplate)

        let mainAction = DialogButtonAction(title: "Delete", style: .destructive) { _ in
            NSLog("Primary tapped")
        }

        let cancelAction = DialogButtonAction(title: "Cancel", style: .secondary) { _ in

        }

        let faderAction = DialogScrimAction(handler: { (didDismiss) in
            NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
        }, shouldDismiss: false)

        alertController.addButtonAction(mainAction)
        alertController.addButtonAction(cancelAction)
        alertController.scrimAction = faderAction

        self.present(alertController, animated: true, completion: nil)
    }
}
