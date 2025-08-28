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
        action: @escaping () -> Void,
        noTapAnimation: Bool = false,
        contentView: @escaping () -> Content,
        accessibilityIdentifier: String
        // extraSetup: ((UIHostingController<AnyView>) -> Void)? = nil
    ) -> UIHostingController<BPKTappableContainer<Content>> {

        let root = BPKTappableContainer(
            accessibilityLabel: accessibilityLabel,
            action: action,
            buttonStyleType: noTapAnimation ? .noTapAnimation : .plain
        ) {
            contentView()
        }
        //let root = AnyView(contentView)
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

        hostingView.accessibilityIdentifier = accessibilityIdentifier
        // hostingView.accessibilityLabel = a11yLabel

        hostingController.sizingOptions = .intrinsicContentSize

        //extraSetup?(hostingController)
        return hostingController
    }

}
