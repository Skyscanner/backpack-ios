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
        accessibilityValue: String? = nil,
        action: @escaping () -> Void,
        noTapAnimation: Bool = false,
        @ViewBuilder contentView: @escaping () -> Content,
        accessibilityIdentifier: String? = nil
    ) -> UIHostingController<BPKTappableContainer<Content>> {

        let root = BPKTappableContainer(
            accessibilityLabel: accessibilityLabel,
            accessibilityIdentifier: accessibilityIdentifier,
            accessibilityValue: accessibilityValue,
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
        accessibilityIdentifier: String? = nil,
        accessibilityValue: String? = nil,
        action: @escaping () -> Void,
        noTapAnimation: Bool = false,
        @ViewBuilder contentView: @escaping () -> Content
    ) {
        let updatedRoot = BPKTappableContainer(
            accessibilityLabel: accessibilityLabel,
            accessibilityIdentifier: accessibilityIdentifier,
            accessibilityValue: accessibilityValue,
            action: action,
            buttonStyleType: noTapAnimation ? .noTapAnimation : .plain
        ) {
            contentView()
        }

        hostingController.rootView = updatedRoot
    }
}

public final class SwiftUITappableContainerViewModel<Content: View>: ObservableObject {
    @Published public var accessibilityLabel: String
    @Published public var accessibilityValue: String?
    @Published public var noTapAnimation: Bool
    public var accessibilityIdentifier: String?
    public var action: () -> Void
    @Published public var contentView: () -> Content

    public init(
        accessibilityLabel: String,
        accessibilityValue: String? = nil,
        accessibilityIdentifier: String? = nil,
        action: @escaping () -> Void,
        noTapAnimation: Bool = false,
        @ViewBuilder contentView: @escaping () -> Content
    ) {
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityValue = accessibilityValue
        self.accessibilityIdentifier = accessibilityIdentifier
        self.action = action
        self.noTapAnimation = noTapAnimation
        self.contentView = contentView
    }
}

public struct ReactiveSwiftUITappableContainerWrapper<Content: View>: View {
    @ObservedObject var viewModel: SwiftUITappableContainerViewModel<Content>

    public var body: some View {
        BPKTappableContainer(
            accessibilityLabel: viewModel.accessibilityLabel,
            accessibilityIdentifier: viewModel.accessibilityIdentifier,
            accessibilityValue: viewModel.accessibilityValue,
            action: viewModel.action,
            buttonStyleType: viewModel.noTapAnimation ? .noTapAnimation : .plain
        ) {
            viewModel.contentView()
        }
    }
}

public extension UIView {

    /// Creates a SwiftUI BPKTappableContainer wrapped in a UIHostingController returns both the view and its ViewModel
    static func makeReactiveSwiftUITappableContainerTWO<Content: View>(
        button: UIView,
        accessibilityLabel: String,
        accessibilityValue: String? = nil,
        accessibilityIdentifier: String? = nil,
        action: @escaping () -> Void,
        noTapAnimation: Bool = false,
        @ViewBuilder contentView: @escaping () -> Content
    ) -> (UIView, SwiftUITappableContainerViewModel<Content>) {
        let viewModel = SwiftUITappableContainerViewModel(
            accessibilityLabel: accessibilityLabel,
            accessibilityValue: accessibilityValue,
            accessibilityIdentifier: accessibilityIdentifier,
            action: action,
            noTapAnimation: noTapAnimation,
            contentView: contentView
        )

        let wrapperView = ReactiveSwiftUITappableContainerWrapper(viewModel: viewModel)

        let hostingController = UIHostingController(rootView: wrapperView)

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

        return (hostingView, viewModel)
    }
}

