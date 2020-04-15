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
import Backpack

enum SnackBarType {
    case withTitle
    case withTitleAndButton
    case withTitleTextAndButton
    case withTitleAndButtonIconOnly
    case withTitleButtonAndAccessoryIcon
    case indefiniteDuration
    case longDuration
    case shortDuration
    case withKeyboard
    case withDelegate
}

class SnackBarViewController: UIViewController, BPKSnackbarDelegate {
    @IBOutlet weak var textField: UITextField!
    var snackBarType: SnackBarType = .withTitle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.isHidden = snackBarType == .withKeyboard ? false : true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        switch snackBarType {
        case .withTitle:
            showWithTitle()
        case .withTitleAndButton:
            showWithTitleAndButton()
        case .withTitleTextAndButton:
            showWithTitleTextAndButton()
        case .withTitleAndButtonIconOnly:
            showWithTitleAndButtonIconOnly()
        case .withTitleButtonAndAccessoryIcon:
            showWithTitleButtonAndAccessoryIcon()
        case .indefiniteDuration:
            showIndefiniteDuration()
        case .longDuration:
            showLongDuration()
        case .shortDuration:
            showShortDuration()
        case .withKeyboard:
            showWithKeyboard()
        case .withDelegate:
            showWithDelegate()
        }
    }

    func showWithTitle() {
        let snackbar = BPKSnackbar.init(
            title: "Snackbar Title", text: nil, duration: .long, viewController: self, delegate: nil
        )
        snackbar.show()
    }

    func showWithTitleAndButton() {
        let snackbar = BPKSnackbar.init(title: "Snackbar Title",
                                        text: nil,
                                     buttonTitle: "Button Title",
                                     buttonIcon: nil,
                                     leftIcon: nil,
                                     duration: .long,
                                     viewController: self,
                                     delegate: nil)
        snackbar.show()
    }

    func showWithTitleTextAndButton() {
        let snackbar = BPKSnackbar.init(title: "Snackbar Title",
                                        text: "Descriptive text",
                                     buttonTitle: "Button Title",
                                     buttonIcon: nil,
                                     leftIcon: nil,
                                     duration: .long,
                                     viewController: self,
                                     delegate: nil)
        snackbar.show()

    }

    func showWithTitleAndButtonIconOnly() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let snackbar = BPKSnackbar.init(title: "Snackbar Title",
                                        text: nil,
                                     buttonTitle: nil,
                                     buttonIcon: buttonIcon,
                                     leftIcon: nil,
                                     duration: .long,
                                     viewController: self,
                                     delegate: nil)
        snackbar.show()
    }

    func showWithTitleButtonAndAccessoryIcon() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let accessoryIcon = BPKIcon.makeTemplateIcon(name: .tickCircle, size: .small)
        let snackbar = BPKSnackbar.init(title: "Snackbar Title",
                                        text: nil,
                                     buttonTitle: "Button Title",
                                     buttonIcon: buttonIcon,
                                     leftIcon: accessoryIcon,
                                     duration: .long,
                                     viewController: self,
                                     delegate: nil)
        snackbar.show()
    }

    func showIndefiniteDuration() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let snackbar = BPKSnackbar.init(title: "Snackbar with indefinite duration",
                                        text: nil,
                                     buttonTitle: "Button Title",
                                     buttonIcon: buttonIcon,
                                     leftIcon: nil,
                                     duration: .indefinite,
                                     viewController: self,
                                     delegate: nil)
        snackbar.show()
    }

    func showLongDuration() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let snackbar = BPKSnackbar.init(title: "Snackbar with long duration",
                                        text: nil,
                                     buttonTitle: "Button Title",
                                     buttonIcon: buttonIcon,
                                     leftIcon: nil,
                                     duration: .long,
                                     viewController: self,
                                     delegate: nil)
        snackbar.show()
    }

    func showShortDuration() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let snackbar = BPKSnackbar.init(title: "Snackbar with long duration",
                                        text: nil,
                                     buttonTitle: "Button Title",
                                     buttonIcon: buttonIcon,
                                     leftIcon: nil,
                                     duration: .short,
                                     viewController: self,
                                     delegate: nil)
        snackbar.show()
    }

    func showWithKeyboard() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let accessoryIcon = BPKIcon.makeTemplateIcon(name: .tickCircle, size: .small)
        let snackbar = BPKSnackbar.init(title: "Snackbar Title",
                                        text: nil,
                                     buttonTitle: "Button Title",
                                     buttonIcon: buttonIcon,
                                     leftIcon: accessoryIcon,
                                     duration: .long,
                                     viewController: self,
                                     delegate: nil)
        snackbar.show()
        textField.becomeFirstResponder()
    }

    func showWithDelegate() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let accessoryIcon = BPKIcon.makeTemplateIcon(name: .tickCircle, size: .small)
        let snackbar = BPKSnackbar.init(title: "Snackbar Title",
                                        text: nil,
                                     buttonTitle: "Button Title",
                                     buttonIcon: buttonIcon,
                                     leftIcon: accessoryIcon,
                                     duration: .long,
                                     viewController: self,
                                     delegate: self)
        snackbar.show()
    }

    func snackbar(_ snackbar: BPKSnackbar!, dismissedWith cause: BPKSnackbarDismissCause) {
        if cause == .actionButton {
            let title = String(Int(arc4random_uniform(100)))
            let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
            let accessoryIcon = BPKIcon.makeTemplateIcon(name: .tickCircle, size: .small)
            let snackbar = BPKSnackbar.init(title: title,
                                            text: nil,
                                         buttonTitle: "Button Title",
                                         buttonIcon: buttonIcon,
                                         leftIcon: accessoryIcon,
                                         duration: .long,
                                         viewController: self,
                                         delegate: self)
            snackbar.show()
        }
    }
}
