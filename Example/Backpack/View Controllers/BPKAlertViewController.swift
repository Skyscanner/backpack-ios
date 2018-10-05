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

import UIKit
import Backpack

class BPKAlertViewController: UIViewController {
    let primaryButton:Button = Button(size: .default, style: .primary)
    let dbookInfoAlert:Button = Button(size: .default, style: .primary)
    let destructiveButton:Button = Button(size: .default, style: .destructive)
    let warningButton:Button = Button(size: .default, style: .secondary)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(primaryButton)
        self.view.addSubview(destructiveButton)
        self.view.addSubview(warningButton)
        self.view.addSubview(dbookInfoAlert)
        
        primaryButton.setTitle("normal")
        destructiveButton.setTitle("error")
        warningButton.setTitle("warning")
        dbookInfoAlert.setTitle("Dbook success")

        primaryButton.addTarget(self, action:#selector(BPKAlertViewController.showNormal(_:)), for: .touchUpInside)
        destructiveButton.addTarget(self, action: #selector(BPKAlertViewController.showError(_:)), for: .touchUpInside)
        warningButton.addTarget(self, action: #selector(BPKAlertViewController.showWarning(_:)), for: .touchUpInside)
        dbookInfoAlert.addTarget(self, action: #selector(BPKAlertViewController.showSucccess(_:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        self.primaryButton.frame = CGRect(x: 20, y: 300, width: primaryButton.intrinsicContentSize.width, height: primaryButton.intrinsicContentSize.height)
        self.destructiveButton.frame = CGRect(x: 20, y: 350, width: destructiveButton.intrinsicContentSize.width, height: destructiveButton.intrinsicContentSize.height)
        self.warningButton.frame = CGRect(x: 20, y: 400, width: warningButton.intrinsicContentSize.width, height: warningButton.intrinsicContentSize.height)
        self.dbookInfoAlert.frame = CGRect(x: 20, y: 450, width: dbookInfoAlert.intrinsicContentSize.width, height: dbookInfoAlert.intrinsicContentSize.height)
    }

    func showNormal(_ sender: UIButton!) {
        let dialogController  = DialogController(title: "Such Wow!",
                                                message: "Mauris auctor, arcu at consequat condimentum, sem lorem mollis turpis, sit amet tristique mi eros eget tellus.",
                                                style: .alert,
                                                shadowStyle: .shadow,
                                                head: Color.green500,
                                                iconImage: Backpack.Icon.makeIcon(name: .tick, color: Color.white, size: .large))
        
        let mainAction = DialogButtonAction(title: "Continue", style: .primary) {
            NSLog("Primary tapped")
        }
        let skipAction = DialogButtonAction(title: "skip", style: .link) {
            NSLog("skip tapped")
        }

        let scrimAction = DialogScrimAction(handler: { (didDismiss) in
            NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
        }, shouldDismiss: true)
        
        dialogController.addButtonAction(mainAction)
        dialogController.addButtonAction(skipAction);
        dialogController.addScrimAction(scrimAction);
        
        self.present(dialogController, animated: false, completion: nil);
    }
    
    func showSucccess(_ sender: UIButton!) {
        let alertController = DialogController(title: "You're almost ready to pack your bags!",
                                               message: "Your booking is being processed with Trip.com\n\nAs soon as your booking has been completed, your confirmation email will be sent to arriaaksj@gmail.com\n\nRemember to check your junk mail folder\n\nPlease note down your reference number and contact Trip.com if you need to track, change or cancel your booking\n\nSafe travels!",
                                               style: .bottomSheet,
                                               shadowStyle: .noShadow,
                                               head: Color.green500,
                                               iconImage: Backpack.Icon.makeIcon(name: .tick, color: Color.white, size: .large))
        
        
        let scrimAction = DialogScrimAction(handler: { (didDismiss) in
            NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
        }, shouldDismiss: true)
        
        alertController.addScrimAction(scrimAction);
        
        self.present(alertController, animated: false, completion: nil);
    }

    func showWarning(_ sender: UIButton!) {
        let alertController = DialogController(title: "!#$Warning-0-1!#$#$?",
                                               message: "Engine Overload.!^R? Please do something. Throw me into the freezer or something!!",
                                               style: .alert,
                                               shadowStyle: .shadow,
                                               head: Color.yellow500,
                                               iconImage: Backpack.Icon.makeIcon(name: .lightning, color: Color.white, size: .large))
        
        let mainAction = DialogButtonAction(title: "OK", style: .link) {
            NSLog("Primary tapped")
        }
        
        let scrimAction = DialogScrimAction(handler: { (didDismiss) in
            NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
        }, shouldDismiss: true)
        
        alertController.addButtonAction(mainAction)
        alertController.addScrimAction(scrimAction);
        
        self.present(alertController, animated: false, completion: nil);
    }

    func showError(_ sender: UIButton!) {
        let alertController = DialogController(title: "Delete?",
                                               message: "Are you sure you would like to delete your avatar?",
                                               style: .bottomSheet,
                                               shadowStyle: .shadow,
                                               head: Color.red500,
                                               iconImage: Backpack.Icon.makeIcon(name: .trash, color: Color.white, size: .large))
        
        let mainAction = DialogButtonAction(title: "Delete", style: .destructive) {
            NSLog("Primary tapped")
        }

        let cancelAction = DialogButtonAction(title: "Cancel", style: .secondary) {

        }

        let faderAction = DialogScrimAction(handler: { (didDismiss) in
            NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
        }, shouldDismiss: false)
        
        alertController.addButtonAction(mainAction)
        alertController.addButtonAction(cancelAction)
        alertController.addScrimAction(faderAction);
        
        self.present(alertController, animated: false, completion: nil);
    }
}
