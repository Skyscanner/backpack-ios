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

private struct BadgeExample {
    let type: BPKBadgeType
    let message: String
    let showOverDarkBackground: Bool
}

class BadgesViewController: UIViewController {
    private let badges: [BadgeExample] = [
        BadgeExample(type: .normal, message: "Normal", showOverDarkBackground: false),
        BadgeExample(type: .strong, message: "Strong", showOverDarkBackground: false),
        BadgeExample(type: .success, message: "Success", showOverDarkBackground: false),
        BadgeExample(type: .warning, message: "Warning", showOverDarkBackground: false),
        BadgeExample(type: .destructive, message: "Critical", showOverDarkBackground: false),
        BadgeExample(type: .inverse, message: "Inverse", showOverDarkBackground: true),
        BadgeExample(type: .outline, message: "Outline", showOverDarkBackground: true),
        BadgeExample(type: .brand, message: "Brand", showOverDarkBackground: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        let stack = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.spacing = BPKSpacingMd
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        badges.map(makeBadge(_:)).forEach(stack.addArrangedSubview(_:))
        
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func makeBadge(_ badgeExample: BadgeExample) -> UIView {
        let stack = UIStackView(frame: .zero)
        stack.alignment = .fill
        stack.distribution = .equalCentering
        stack.spacing = BPKSpacingXl
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        stack.axis = .horizontal
        
        let badge = BPKBadge(
            type: badgeExample.type,
            message: badgeExample.message
        )
        let badgeWithIcon = BPKBadge(
            type: badgeExample.type,
            icon: .init(position: .leading, iconName: .tickCircle),
            message: badgeExample.message
        )
        
        if badgeExample.showOverDarkBackground {
            stack.backgroundColor = BPKColor.corePrimaryColor
        }
        stack.addArrangedSubview(badge)
        stack.addArrangedSubview(badgeWithIcon)
        return stack
    }
}
