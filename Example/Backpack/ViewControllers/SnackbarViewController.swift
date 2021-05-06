/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

// The string value is the segue identifier
// that should use this style
enum SnackBarType: String {
    case withText = "showWithText"
    case withTextAndButton = "showWithTextAndButton"
    case withTextTitleAndButton = "showWithTextTitleAndButton"
    case withTextAndIconOnlyButton = "showWithTextAndIconOnlyButton"
    case withTextButtonAndAccessoryIcon = "showWithTextButtonAndAccessoryIcon"
    case indefiniteDuration = "showWithIndefiniteDuration"
    case longDuration = "showWithLongDuration"
    case shortDuration = "showWithShortDuration"
    case withKeyboard = "showWithKeyboard"
    case withDelegate = "showWithDelegate"
}

class SnackBarViewController: UIViewController, BPKSnackbarDelegate {
    @IBOutlet weak var textField: UITextField!
    var snackBarType: SnackBarType = .withText

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.isHidden = snackBarType == .withKeyboard ? false : true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        switch snackBarType {
        case .withText:
            showWithText()
        case .withTextAndButton:
            showWithTextAndButton()
        case .withTextTitleAndButton:
            showWithTextTitleAndButton()
        case .withTextAndIconOnlyButton:
            showWithTextAndIconOnlyButton()
        case .withTextButtonAndAccessoryIcon:
            showWithTextButtonAndAccessoryIcon()
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

    func showWithText() {
        let snackbar = BPKSnackbar(
            text: "Descriptive text", title: nil, duration: .long, viewController: self, delegate: nil
        )
        snackbar.show()
    }

    func showWithTextAndButton() {
        let snackbar = BPKSnackbar(
            text: "Descriptive text",
            title: nil,
            button: BPKSnackbarButton(title: "Button Title"),
            leftIcon: nil,
            duration: .long,
            viewController: self,
            delegate: nil
        )
        snackbar.show()
    }

    func showWithTextTitleAndButton() {
        let snackbar = BPKSnackbar(
            text: "Descriptive text",
            title: "Snackbar Title",
            button: BPKSnackbarButton(title: "Button Title"),
            leftIcon: nil,
            duration: .long,
            viewController: self,
            delegate: nil
        )
        snackbar.show()

    }

    func showWithTextAndIconOnlyButton() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let snackbar = BPKSnackbar(
            text: "Descriptive text",
            title: nil,
            button: BPKSnackbarButton(icon: buttonIcon, accessibilityLabel: "Close"),
            leftIcon: nil,
            duration: .long,
            viewController: self,
            delegate: nil
        )

        snackbar.show()
    }

    func showWithTextButtonAndAccessoryIcon() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let accessoryIcon = BPKIcon.makeTemplateIcon(name: .tickCircle, size: .small)
        let snackbar = BPKSnackbar(
            text: "Descriptive text",
            title: nil,
            button: BPKSnackbarButton(icon: buttonIcon, accessibilityLabel: "Close"),
            leftIcon: accessoryIcon,
            duration: .long,
            viewController: self,
            delegate: nil
        )
        snackbar.show()
    }

    func showIndefiniteDuration() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let snackbar = BPKSnackbar(
            text: "Snackbar with indefinite duration",
            title: nil,
            button: BPKSnackbarButton(icon: buttonIcon, accessibilityLabel: "Icon"),
            leftIcon: nil,
            duration: .indefinite,
            viewController: self,
            delegate: nil
        )

        snackbar.show()
    }

    func showLongDuration() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let snackbar = BPKSnackbar(
            text: "Snackbar with long duration",
            title: nil,
            button: BPKSnackbarButton(icon: buttonIcon, accessibilityLabel: "Icon"),
            leftIcon: nil,
            duration: .long,
            viewController: self,
            delegate: nil
        )

        snackbar.show()
    }

    func showShortDuration() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let snackbar = BPKSnackbar(
            text: "Snackbar with long duration",
            title: nil,
            button: BPKSnackbarButton(icon: buttonIcon, accessibilityLabel: "Icon"),
            leftIcon: nil,
            duration: .short,
            viewController: self,
            delegate: nil
        )

        snackbar.show()
    }

    func showWithKeyboard() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let accessoryIcon = BPKIcon.makeTemplateIcon(name: .tickCircle, size: .small)
        let snackbar = BPKSnackbar(
            text: "Descriptive text",
            title: nil,
            button: BPKSnackbarButton(icon: buttonIcon, accessibilityLabel: "Icon"),
            leftIcon: accessoryIcon,
            duration: .long,
            viewController: self,
            delegate: nil
        )

        snackbar.show()
        textField.becomeFirstResponder()
    }

    func showWithDelegate() {
        let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
        let accessoryIcon = BPKIcon.makeTemplateIcon(name: .tickCircle, size: .small)
        let snackbar = BPKSnackbar(
            text: "Descriptive text",
            title: nil,
            button: BPKSnackbarButton(icon: buttonIcon, accessibilityLabel: "Icon"),
            leftIcon: accessoryIcon,
            duration: .long,
            viewController: self,
            delegate: self
        )

        snackbar.show()
    }

    func snackbar(_ snackbar: BPKSnackbar!, dismissedWith cause: BPKSnackbarDismissCause) {
        if cause == .actionButton {
            let title = String(Int(arc4random_uniform(100)))
            let buttonIcon = BPKIcon.makeTemplateIcon(name: .close, size: .small)
            let accessoryIcon = BPKIcon.makeTemplateIcon(name: .tickCircle, size: .small)
            let snackbar = BPKSnackbar(
                text: "Descriptive text",
                title: title,
                button: BPKSnackbarButton(icon: buttonIcon, accessibilityLabel: "Icon"),
                leftIcon: accessoryIcon,
                duration: .long,
                viewController: self,
                delegate: self
            )

            snackbar.show()
        }
    }
}
