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

import SwiftUI
import Combine

public final class SwiftUILinkViewModel: ObservableObject {
    @Published public var markdown: String
    public var style: BPKLinkStyle
    public var fontStyle: BPKFontStyle
    public var onCustomLink: (URL) -> Void
    public var accessibilityIdentifier: String?
    public var accessibilityLabel: String?
    
    public init(
        markdown: String,
        style: BPKLinkStyle = .default,
        fontStyle: BPKFontStyle = .bodyDefault,
        onCustomLink: @escaping (URL) -> Void = { _ in },
        accessibilityIdentifier: String? = nil,
        accessibilityLabel: String? = nil) {
        
        self.markdown = markdown
        self.style = style
        self.fontStyle = fontStyle
        self.onCustomLink = onCustomLink
        self.accessibilityIdentifier = accessibilityIdentifier
        self.accessibilityLabel = accessibilityLabel
    }
}

public struct ReactiveSwiftUIBPKLinkWrapper: View {
    @ObservedObject var viewModel: SwiftUILinkViewModel
    
    public var body: some View {
        BPKLink(
            markdown: viewModel.markdown,
            style: viewModel.style,
            fontStyle: viewModel.fontStyle,
            onCustomLink: viewModel.onCustomLink)
        .if((viewModel.accessibilityLabel?.isEmpty == false)) { link in
            link.accessibilityLabel(viewModel.accessibilityLabel!)
        }
        .if((viewModel.accessibilityIdentifier?.isEmpty == false)) { link in
            link.accessibilityIdentifier(viewModel.accessibilityIdentifier!)
        }
    }
}

public extension UIView {
    
    /// Creates a SwiftUI BPKLink wrapped in a UIHostingController and returns both the view and its ViewModel
    static func makeReactiveSwiftUIBPKLink(
        markdown: String,
        style: BPKLinkStyle = .default,
        fontStyle: BPKFontStyle = .bodyDefault,
        onCustomLink: @escaping (URL) -> Void = { _ in },
        accessibilityIdentifier: String? = nil,
        accessibilityLabel: String? = nil
    ) -> (UIView, SwiftUILinkViewModel) {
        let viewModel = SwiftUILinkViewModel(
            markdown: markdown,
            style: style,
            fontStyle: fontStyle,
            onCustomLink: onCustomLink,
            accessibilityIdentifier: accessibilityIdentifier,
            accessibilityLabel: accessibilityLabel)
        
        let wrapperView = ReactiveSwiftUIBPKLinkWrapper(
            viewModel: viewModel
        )
        
        let hostingController = UIHostingController(rootView: wrapperView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return (hostingController.view, viewModel)
    }
}
