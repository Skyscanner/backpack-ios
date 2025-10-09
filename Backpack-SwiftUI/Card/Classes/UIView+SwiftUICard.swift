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

public final class BPKCardSwiftUIViewModel<Content: View>: ObservableObject {

    public let elevation: BPKCardElevation
    public let padding: BPKCard<Content>.Padding
    public let cornerStyle: BPKCard<Content>.CornerStyle
    public var tapAction: () -> Void = {}

    public init(padding: BPKCard<Content>.Padding = .small,
                cornerStyle: BPKCard<Content>.CornerStyle = .small,
                elevation: BPKCardElevation = .default,
                tapAction: @escaping () -> Void = {}) {

        self.cornerStyle = cornerStyle
        self.elevation = elevation
        self.padding = padding
        self.tapAction = tapAction
    }
}

public struct BPKCardSwiftUIWrapper<Content: View>: View {
    @ObservedObject var viewModel: BPKCardSwiftUIViewModel<Content>
    @ViewBuilder var contentView: () -> Content

    public var body: some View {
        BPKCard(
            padding: viewModel.padding,
            cornerStyle: viewModel.cornerStyle,
            elevation: viewModel.elevation
        ) {
            contentView()
        }
        .onTapGesture(perform: viewModel.tapAction)
    }
}

public extension UIView {

    /// Creates a SwiftUI BPKCard wrapped in a UIHostingController and returns both the view and its ViewModel
    /// This method is valid to use however be cautious with some usage in UIKit
    /// Current known issue in StackViews with a horizontal setting, more issues could occur.
    static func bpkCardSwiftUIWrapperBaker<Content: View>(
        padding: BPKCard<Content>.Padding = .small,
        cornerStyle: BPKCard<Content>.CornerStyle = .small,
        elevation: BPKCardElevation = .default,
        @ViewBuilder content: @escaping () -> Content,
        tapAction: @escaping () -> Void = {}
    ) -> (UIView, BPKCardSwiftUIViewModel<Content>) {
        let viewModel = BPKCardSwiftUIViewModel<Content>(
            padding: padding,
            cornerStyle: cornerStyle,
            elevation: elevation,
            tapAction: tapAction
        )

        let wrapperView = BPKCardSwiftUIWrapper(
            viewModel: viewModel,
            contentView: content
        )

        let hostingController = UIHostingController(rootView: wrapperView)
        hostingController.view.backgroundColor = UIColor.clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        return (hostingController.view, viewModel)
    }
}
