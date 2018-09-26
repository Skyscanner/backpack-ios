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
    let destructiveButton:Button = Button(size: .default, style: .destructive)
    let warningButton:Button = Button(size: .default, style: .secondary)
    let alertController:BPKAlertController = BPKAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(primaryButton)
        self.view.addSubview(destructiveButton)
        self.view.addSubview(warningButton)
        
        primaryButton.setTitle("normal")
        destructiveButton.setTitle("error")
        warningButton.setTitle("warning")
        
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
        let alertConfig = BPKAlertConfiguration.normalConfiguration(withTitle: "Primary title", description: "Test string Lorem", primaryButtonText: "Continue", secondaryButtonText: "Cancel", primaryActionHandler: {
            NSLog("success")
        }, secondaryActionHandler: {
            NSLog("cancel")
        })
        self.alertController.alert(with: alertConfig, on: self.view.window!)
    }

    func showError(_ sender: UIButton!) {

    }

    func showWarning(_ sender: UIButton!) {

    }
}
