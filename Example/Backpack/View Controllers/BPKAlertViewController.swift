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
    let primaryButton:BPKButton = BPKButton(size: .default, style: .primary)
    let destructiveButton:BPKButton = BPKButton(size: .default, style: .destructive)
    let warningButton:BPKButton = BPKButton(size: .default, style: .secondary)
    let alertController:BPKAlert = BPKAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(primaryButton)
        self.view.addSubview(destructiveButton)
        self.view.addSubview(warningButton)
        
        primaryButton.setTitle("normal", for: .normal)
        destructiveButton.setTitle("error", for: .normal)
        warningButton.setTitle("warning", for: .normal)
        
        primaryButton.addTarget(self, action:#selector(BPKAlertViewController.showNormal(_:)), for: .touchUpInside)
        destructiveButton.addTarget(self, action: #selector(BPKAlertViewController.showError(_:)), for: .touchUpInside)
        warningButton.addTarget(self, action: #selector(BPKAlertViewController.showWarning(_:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        self.primaryButton.frame = CGRect(x: 20, y: 300, width: primaryButton.intrinsicContentSize.width, height: primaryButton.intrinsicContentSize.height)
        self.destructiveButton.frame = CGRect(x: 20, y: 350, width: destructiveButton.intrinsicContentSize.width, height: destructiveButton.intrinsicContentSize.height)
        self.warningButton.frame = CGRect(x: 20, y: 400, width: warningButton.intrinsicContentSize.width, height: warningButton.intrinsicContentSize.height)
    }

    func showNormal(_ sender: UIButton!) {
        self.alertController.setPrimaryButtonStyle(.primary)
        self.alertController.setSecondaryButtonStyle(.secondary)
        self.alertController.alert(withTitle: "YAAAY", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi in nulla dignissim, porta eros vel, iaculis orci. Aliquam erat elit, consectetur vitae lectus auctor, vestibulum ullamcorper libero. Quisque pellentesque eros est, eget mattis libero mattis sed. Suspendisse vestibulum ultricies ex, et efficitur nisi gravida eget. Curabitur rhoncus nisi ut nisl ultricies, ac pellentesque nulla consectetur. Phasellus non tellus accumsan, pharetra ipsum sit amet, scelerisque diam. Phasellus mattis leo nec dolor pharetra, at pellentesque purus dictum. Vivamus placerat justo nibh, et sodales neque mattis a. Ut posuere orci eros, id tincidunt eros ornare a.", style: .normal, primaryActionHandler: {
            NSLog("success")
        }, primaryButtonTitle: "Continue", secondaryActionHandler: {
            NSLog("cancel")
        }, secondaryButtonTitle: "Cancel",  hasDropShadow: true, doneButtonText: "Done", on: self.view.window!)
    }

    func showError(_ sender: UIButton!) {
        self.alertController.setPrimaryButtonStyle(.destructive)
        self.alertController.setSecondaryButtonStyle(.secondary)
        self.alertController.alert(withTitle: "Nooo!!", description: "Don't delete me please", style: .error, primaryActionHandler: {
            NSLog("success")
        }, primaryButtonTitle: "Delete", secondaryActionHandler: {
            NSLog("cancel")
        }, secondaryButtonTitle: "Cancel",  hasDropShadow: false, doneButtonText: "", on: self.view.window!)
    }

    func showWarning(_ sender: UIButton!) {
        self.alertController.setPrimaryButtonStyle(.featured)
        self.alertController.setSecondaryButtonStyle(.secondary)
        self.alertController.alert(withTitle: "ERRi-o-i!!", description: "Warning, Engines too hot, please put device under water or snow", style: .warning, primaryActionHandler: {
            NSLog("success")
        }, primaryButtonTitle: "Understood", secondaryActionHandler: {
            NSLog("cancel")
        }, secondaryButtonTitle: "Cancel",  hasDropShadow: true, doneButtonText: "", on: self.view.window!)
    }
}
