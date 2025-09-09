/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2025 Skyscanner Ltd. All rights reserved.
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

import SwiftUI
import Combine

public extension UIView {
    static func makeReactiveSwiftUITappableContainer<Content: View>(
        button: UIView,
        accessibilityLabel: String,
        accessbilityIdentifier: String? = nil,
        accessbilityValue: String? = nil,
        action: @escaping () -> Void,
        noTapAnimation: Bool = false,
        @ViewBuilder contentView: @escaping () -> Content,
        accessibilityIdentifier: String? = nil
    ) -> UIHostingController<BPKTappableContainer<Content>> {

        let root = BPKTappableContainer(
            accessibilityLabel: accessibilityLabel,
            accessbilityIdentifier: accessbilityIdentifier,
            accessbilityValue: accessbilityValue,
            action: action,
            buttonStyleType: noTapAnimation ? .noTapAnimation : .plain
        ) {
            contentView()
        }
        let hostingController = UIHostingController(rootView: root)

        let hostingView = hostingController.view!
        hostingView.backgroundColor = .clear
        hostingView.translatesAutoresizingMaskIntoConstraints = false

        button.addSubview(hostingView)
        NSLayoutConstraint.activate([
            hostingView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            hostingView.topAnchor.constraint(equalTo: button.topAnchor),
            hostingView.bottomAnchor.constraint(equalTo: button.bottomAnchor)
        ])

        hostingController.sizingOptions = .intrinsicContentSize

        return hostingController
    }

    static func updateReactiveSwiftUITappableContainer<Content: View>(
        _ hostingController: UIHostingController<BPKTappableContainer<Content>>,
        accessibilityLabel: String,
        accessbilityIdentifier: String? = nil,
        accessbilityValue: String? = nil,
        action: @escaping () -> Void,
        noTapAnimation: Bool = false,
        @ViewBuilder contentView: @escaping () -> Content
    ) {
        let updatedRoot = BPKTappableContainer(
            accessibilityLabel: accessibilityLabel,
            accessbilityIdentifier: accessbilityIdentifier,
            accessbilityValue: accessbilityValue,
            action: action,
            buttonStyleType: noTapAnimation ? .noTapAnimation : .plain
        ) {
            contentView()
        }

        hostingController.rootView = updatedRoot
    }
}
