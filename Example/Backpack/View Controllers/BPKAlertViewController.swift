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
        let alertController:AlertController = AlertController(title: "Such Wow!",
                                                              message: "Mauris auctor, arcu at consequat condimentum, sem lorem mollis turpis, sit amet tristique mi eros eget tellus. Integer pretium risus in ultrices maximus. In vitae convallis leo, ut ultricies metus. Proin molestie vestibulum lobortis. Maecenas a ultricies magna, vel iaculis nulla.",
                                                              style: .alert,
                                                              shadow: Shadow.shadowLg(),
                                                              head: Color.green500,
                                                              iconImage: Backpack.Icon.makeIcon(name: "tick", color: Color.white, size: .large))
        
        let mainAction = AlertButtonAction(title: "Continue", style: .primary) {
            NSLog("Primary tapped")
        }
        let skipAction = AlertButtonAction(title: "skip", style: .link) {
            NSLog("Primary tapped")
        }
        
        let doneAction = AlertDoneButtonAction(title: "Done", isVisible: true) {
            NSLog("Done pressed")
        }

        let faderAction = AlertFaderAction(handler: { (didDismiss) in
            NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
        }, shouldDismiss: true)
        
        alertController.add(mainAction);
        alertController.add(skipAction);
        alertController.add(doneAction);
        alertController.add(faderAction);

        self.present(alertController, animated: false, completion: nil);
    }

    func showWarning(_ sender: UIButton!) {
//        let goBackButton = AlertButtonAction.init(style: .secondary, title: "Back", actionHandler: {
//            NSLog("Primary tapped")
//        })
//
//        let faderConfig = AlertFaderConfiguration.init(actionHandler: { (didDismiss) in
//            NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
//        }, shouldDismiss: true)
//
//        let alertConfig = AlertConfiguration.init(circleColor: Color.yellow500,
//                                                  icon:Backpack.Icon.makeIcon(name: "exclamation-circle", color: Color.white, size: .large),
//                                                  titleText: "Warr!?-1-0-$%",
//                                                  descriptionText: "Something is throwing a warning m8 🤔",
//                                                  buttonConfigurations: [goBackButton],
//                                                  hasShadow: true,
//                                                  doneButtonConfiguration: nil,
//                                                  faderConfiguration: faderConfig,
//                                                  isFullScreen: false)
//        self.alertController.alert(with: alertConfig, on: self.view.window!)
    }

    func showError(_ sender: UIButton!) {
//        let primaryBtnConfig = AlertButtonAction.init(style: .destructive, title: "Delete", actionHandler: {
//            NSLog("Primary tapped")
//        })
//
//        let doneConfig = AlertDoneButtonConfiguration.init(actionHandler: {
//            NSLog("Done tapped")
//        }, isVisible: true, titleText: "Cancel")
//
//        let faderConifif = AlertFaderConfiguration.init(actionHandler: { (didDismiss) in
//            NSLog(didDismiss ? "dismissed" : "tapped without dismiss")
//        }, shouldDismiss: false)
//
//        let alertConfig = AlertConfiguration.init(circleColor: Color.red500,
//                                                     icon:Backpack.Icon.makeIcon(name: "trash", color: Color.white, size: .large),
//                                                     titleText: "Delete?",
//                                                     descriptionText: "Are you sure, you would like to delete your review?",
//                                                     buttonConfigurations: [primaryBtnConfig],
//                                                     hasShadow: true,
//                                                     doneButtonConfiguration: doneConfig,
//                                                     faderConfiguration: faderConifif,
//                                                     isFullScreen: true)
//        self.alertController.alert(with: alertConfig, on: self.view.window!)
    }
}
