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

// swiftlint:disable indentation_width
import SwiftUI
import Combine

public final class SwiftUIButtonViewModel: ObservableObject {
    @Published public var isEnabled: Bool
    @Published public var isLoading: Bool
    @Published public var title: String?
    public var style: BPKButton.Style
    public var size: BPKButton.Size
    public var action: () -> Void
    
    public init(isEnabled: Bool,
                isLoading: Bool,
                title: String? = nil,
                style: BPKButton.Style,
                size: BPKButton.Size = .default,
                action: @escaping () -> Void) {
        
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.title = title
        self.style = style
        self.size = size
        self.action = action
    }
}

public struct ReactiveSwiftUIBPKButtonWrapper: View {
    @ObservedObject var viewModel: SwiftUIButtonViewModel

    public var body: some View {
        BPKButton(viewModel.title ?? "",
            loading: $viewModel.isLoading,
            enabled: $viewModel.isEnabled,
            size: viewModel.size,
            action: viewModel.action)
        .buttonStyle(viewModel.style)
        .stretchable()
    }
}

public extension UIView {
    /// Creates a SwiftUI BPKButton wrapped in a UIHostingController and returns its view
    /// - Parameters:
    ///   - title: The button title
    ///   - accessibilityIdentifier: The accessibility identifier for the button
    ///   - accessibilityLabel: The accessibility label for the button
    ///   - style: The BPKButton style (e.g., .featured, .secondary)
    ///   - size: The BPKButton size (e.g, .large, default)
    ///   - action: The action to perform when the button is tapped
    /// - Returns: A UIView containing the SwiftUI button
    static func makeSwiftUIBPKButton(
        title: String,
        accessibilityIdentifier: String? = nil,
        accessibilityLabel: String? = nil,
        style: Backpack_SwiftUI.BPKButton.Style,
        size: BPKButton.Size = .default,
        action: @escaping () -> Void
    ) -> UIView {
        let swiftUIButton = BPKButton(
            title,
            size: size,
            action: action
        )
        .buttonStyle(style)
        .stretchable()

        let hostingController = UIHostingController(rootView: swiftUIButton)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.accessibilityIdentifier = accessibilityIdentifier
        hostingController.view.accessibilityLabel = accessibilityLabel
        
        return hostingController.view
    }
    
    /// Creates a SwiftUI BPKButton wrapped in a UIHostingController and returns both the view and its ViewModel
    static func makeReactiveSwiftUIBPKButton(
        title: String? = "",
        accessibilityIdentifier: String? = nil,
        accessibilityLabel: String? = nil,
        style: BPKButton.Style,
        size: BPKButton.Size = .default,
        isEnabled: Bool = true,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> (UIView, SwiftUIButtonViewModel) {
        let viewModel = SwiftUIButtonViewModel(isEnabled: isEnabled,
                                               isLoading: isLoading,
                                               title: title,
                                               style: style,
                                               size: size,
                                               action: action)
        
        let wrapperView = ReactiveSwiftUIBPKButtonWrapper(
            viewModel: viewModel
        )

        let hostingController = UIHostingController(rootView: wrapperView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.accessibilityIdentifier = accessibilityIdentifier
        hostingController.view.accessibilityLabel = accessibilityLabel

        return (hostingController.view, viewModel)
    }
}

