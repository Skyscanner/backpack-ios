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
        let alertConfig = BPKAlertConfiguration.errorConfiguration(withTitle: "Primary title", description: "Test string Lorem", primaryButtonText: "Continue", secondaryButtonText: "Cancel", primaryActionHandler: {
            NSLog("success")
        }, secondaryActionHandler: {
            NSLog("cancel")
        })
        self.alertController.alert(with: alertConfig, on: self.view.window!)
    }

    func showWarning(_ sender: UIButton!) {
        let primaryBtn = BPKAlertButtonConfiguration.init(style: .primary, title: "Continue", actionHandler: {
            //
        })
        let skipButton = BPKAlertButtonConfiguration.init(style: .link, title: "Skip", actionHandler: {
            //
        })
        
        let alertConfig = BPKAlertConfiguration.init(circleColor: Color.blue500,
                                                     titleText: "Warning",
                                                     descriptionText: "This is a longer text for warning a longer text for warning a longer text for warning a longer text for warning a longer text for warning a longer text for warning a longer text for warning a longer text for warning a longer text for warning",
                                                     buttonConfigurations: [primaryBtn, skipButton],
                                                     hasShadow: true,
                                                     hasDoneButton: true,
                                                     doneButtonText: "Done",
                                                     faderIsDismissAction: true,
                                                     isFullScreen: false)
        self.alertController.alert(with: alertConfig, on: self.view.window!)
    }
}
