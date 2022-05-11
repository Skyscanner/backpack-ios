/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

import XCTest
import FBSnapshotTestCase

class BPKSnackbarSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = true
    }
    
    private func showSnackbar(
        text: String = "Descriptive text",
        title: String? = nil,
        icon: UIImage? = nil,
        button: BPKSnackbarButton? = nil
    ) -> UIView {
        let controller = UIViewController()
        let snackbar = BPKSnackbar(
            text: text,
            title: title,
            button: button,
            leftIcon: icon,
            duration: .short,
            viewController: controller,
            delegate: nil
        )
        snackbar.show()
        return controller.view
    }
    
    func testSnackbarWithText() {
        BPKSnapshotVerifyViewLight(showSnackbar())
        BPKSnapshotVerifyViewDark(showSnackbar())
    }
    
    func testSnackbarWithTextAndTitle() {
        BPKSnapshotVerifyViewLight(showSnackbar(title: "Snackbar Title"))
        BPKSnapshotVerifyViewDark(showSnackbar(title: "Snackbar Title"))
    }
    
    func testSnackbarWithTextAndRightButton() {
        let button = BPKSnackbarButton(title: "Button title")
        BPKSnapshotVerifyViewLight(showSnackbar(button: button))
        BPKSnapshotVerifyViewDark(showSnackbar(button: button))
    }
    
    func testSnackbarWithTextAndRightButtonIconOnly() {
        let icon = BPKIcon.makeSmallTemplateIcon(name: .close)
        let button = BPKSnackbarButton(icon: icon, accessibilityLabel: "close")
        BPKSnapshotVerifyViewLight(showSnackbar(button: button))
        BPKSnapshotVerifyViewDark(showSnackbar(button: button))
    }
    
    func testSnackbarWithTextAndRightButtonAndAccesoryIcon() {
        let leftIcon = BPKIcon.makeSmallTemplateIcon(name: .tickCircle)
        let buttonIcon = BPKIcon.makeSmallTemplateIcon(name: .close)
        let button = BPKSnackbarButton(icon: buttonIcon, accessibilityLabel: "close")
        BPKSnapshotVerifyViewLight(showSnackbar(icon: leftIcon, button: button))
        BPKSnapshotVerifyViewDark(showSnackbar(icon: leftIcon, button: button))
    }
    
    func testSnackbarWithLongTextAndRightButton() {
        let text = "Descriptive text Descriptive text Descriptive text Descriptive text"
        let button = BPKSnackbarButton(title: "Button title")
        BPKSnapshotVerifyViewLight(showSnackbar(text: text, button: button))
        BPKSnapshotVerifyViewDark(showSnackbar(text: text, button: button))
    }
    
    func testSnackbarWithLongTextLongTitleAndRightButton() {
        let text = "Long text long text long text"
        let title = "Snackbar Title Snackbar Title Snackbar Title Snackbar Title"
        let button = BPKSnackbarButton(title: "Button title")
        BPKSnapshotVerifyViewLight(showSnackbar(text: text, title: title, button: button))
        BPKSnapshotVerifyViewDark(showSnackbar(text: text, title: title, button: button))
    }
}
