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
    
    private let justTextButton = FloatingNotificationViewController.makeButton(with: "Just text")
    private let textWithIconButton = FloatingNotificationViewController.makeButton(with: "Text with icon")
    private let withActionButton = FloatingNotificationViewController.makeButton(with: "With action")
    private let withIconAndActionButton = FloatingNotificationViewController.makeButton(with: "With icon and action")
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = BPKSpacingLg
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        ].forEach { stackView.addArrangedSubview($0) }
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: BPKSpacingLg
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: BPKSpacingLg
            )
        ])
    }
    
    @objc
    private func justTextButtonTapped() {
        BPKFloatingNotification.show(.titleOnly(parentView: view, title: "Saved"))
    }

    @objc
    private func textWithIconButtonTapped() {
        BPKFloatingNotification.show(.titleWithIcon(parentView: view, title: "Saved", iconName: .heart))
    }

    @objc
    private func withActionButtonTapped() {
        let action = { print("Tapped button") }

        BPKFloatingNotification.show(
            .titleWithAction(
                parentView: view,
                title: "Saved",
                action: .action(title: "View", action: action)
            ))
    }
    
    @objc
    private func withIconAndActionButtonTapped() {
        let action = { print("Tapped button") }
        let didDismiss = { print("Did dismiss") }
        
        BPKFloatingNotification.show(
            .titleWithIconAndAction(
                parentView: view,
                title: "Saved",
                iconName: .heart,
                action: .action(title: "View", action: action),
                didDismiss: didDismiss
            ))
    }
    
    private static func makeButton(with title: String) -> BPKObjcUIKitButton {
        let button = BPKObjcUIKitButton(size: .default, style: .primary)
        button.title = title
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
