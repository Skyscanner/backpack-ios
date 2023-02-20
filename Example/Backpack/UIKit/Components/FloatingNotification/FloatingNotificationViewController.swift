//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

final class FloatingNotificationViewController: UIViewController {
    
    private let floatingNotification: BPKFloatingNotification = {
        let notification = BPKFloatingNotification()
        notification.translatesAutoresizingMaskIntoConstraints = false
        return notification
    }()
    
    private let justTextButton = FloatingNotificationViewController.makeButton(with: "Just text")
    private let textWithIconButton = FloatingNotificationViewController.makeButton(with: "Text with icon")
    private let withActionButton = FloatingNotificationViewController.makeButton(with: "With action")
    private let withIconAndActionButton = FloatingNotificationViewController.makeButton(with: "With icon and action")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.canvasColor
        setupConstraints()
        
        justTextButton.addTarget(self, action: #selector(justTextButtonTapped), for: .touchUpInside)
        textWithIconButton.addTarget(self, action: #selector(textWithIconButtonTapped), for: .touchUpInside)
        withActionButton.addTarget(self, action: #selector(withActionButtonTapped), for: .touchUpInside)
        withIconAndActionButton.addTarget(self, action: #selector(withIconAndActionButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        [
            justTextButton,
            textWithIconButton,
            withActionButton,
            withIconAndActionButton
        ].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            justTextButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: BPKSpacingLg
            ),
            justTextButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: BPKSpacingLg
            ),
            
            textWithIconButton.topAnchor.constraint(
                equalTo: justTextButton.bottomAnchor,
                constant: BPKSpacingLg
            ),
            textWithIconButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: BPKSpacingLg
            ),
            
            withActionButton.topAnchor.constraint(
                equalTo: textWithIconButton.bottomAnchor,
                constant: BPKSpacingLg
            ),
            withActionButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: BPKSpacingLg
            ),
            
            withIconAndActionButton.topAnchor.constraint(
                equalTo: withActionButton.bottomAnchor,
                constant: BPKSpacingLg
            ),
            withIconAndActionButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: BPKSpacingLg
            )
        ])
    }
    
    @objc
    private func justTextButtonTapped() {
        floatingNotification.show(presentOn: view, text: "Saved")
    }
    
    @objc
    private func textWithIconButtonTapped() {
        floatingNotification.show(presentOn: view, text: "Saved", iconName: .heart)
    }
    
    @objc
    private func withActionButtonTapped() {
        floatingNotification.show(presentOn: view, text: "Saved", buttonTitle: "View") {
            print("Tapped button")
        } didDismiss: {
            print("Did dismiss")
        }
    }
    
    @objc
    private func withIconAndActionButtonTapped() {
        floatingNotification.show(
            presentOn: view,
            text: "Saved",
            buttonTitle: "View",
            iconName: .heart
        ) { }
    }
    
    private static func makeButton(with title: String) -> BPKButton {
        let button = BPKButton(size: .default, style: .primary)
        button.title = title
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
