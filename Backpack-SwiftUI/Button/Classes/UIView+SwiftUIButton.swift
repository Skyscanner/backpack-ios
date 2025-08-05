/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2025 Skyscanner Ltd
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
    public var icon: BPKButton.Icon?
    public var style: BPKButton.Style
    public var size: BPKButton.Size
    public var action: () -> Void
    public var accessibilityIdentifier: String?
    public var accessibilityLabel: String?
    
    public init(isEnabled: Bool,
                isLoading: Bool,
                title: String? = nil,
                icon: BPKButton.Icon? = nil,
                style: BPKButton.Style,
                size: BPKButton.Size = .default,
                action: @escaping () -> Void,
                accessibilityIdentifier: String? = nil,
                accessibilityLabel: String? = nil) {
        
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.title = title
        self.icon = icon
        self.style = style
        self.size = size
        self.action = action
        self.accessibilityIdentifier = accessibilityIdentifier
        self.accessibilityLabel = accessibilityLabel
    }
}

public struct ReactiveSwiftUIBPKButtonWrapper: View {
    @ObservedObject var viewModel: SwiftUIButtonViewModel
    
    public var body: some View {
        BPKButton(viewModel.title ?? "",
                  icon: viewModel.icon,
            loading: $viewModel.isLoading,
            enabled: $viewModel.isEnabled,
            size: viewModel.size,
            action: viewModel.action)
        .buttonStyle(viewModel.style)
        .stretchable()
        .if(!(viewModel.accessibilityLabel?.isEmpty ?? false)) { button in
            button.accessibilityLabel(viewModel.accessibilityLabel!)
        }
        .if(!(viewModel.accessibilityIdentifier?.isEmpty ?? false)) { button in
            button.accessibilityIdentifier(viewModel.accessibilityIdentifier!)
        }
    }
}

public extension UIView {
    
    /// Creates a SwiftUI BPKButton wrapped in a UIHostingController and returns both the view and its ViewModel
    static func makeReactiveSwiftUIBPKButton(
        title: String? = "",
        icon: BPKButton.Icon? = nil,
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
                                               icon: icon,
                                               style: style,
                                               size: size,
                                               action: action,
                                               accessibilityIdentifier: accessibilityIdentifier,
                                               accessibilityLabel: accessibilityLabel)
        
        let wrapperView = ReactiveSwiftUIBPKButtonWrapper(
            viewModel: viewModel
        )
        
        let hostingController = UIHostingController(rootView: wrapperView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return (hostingController.view, viewModel)
    }
}
