/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd
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
import SwiftUI

/// A UIKit wrapper for BPKLink that provides a cleaner API without exposing SwiftUI implementation details.
///
/// This class encapsulates the SwiftUI BPKLink component and its view model, providing a simple
/// interface that looks like a standard UIKit label component.
///
/// Example usage:
/// ```
/// let linkLabel = BPKLinkWrapper(
///     style: .default,
///     fontStyle: .label2,
///     onTap: { print("Link tapped") }
/// )
/// linkLabel.markdown = "[View details](view-details)"
/// linkLabel.accessibilityIdentifier = "my_link_label"
/// ```
@MainActor
public final class BPKLinkWrapper: UIView {

    // MARK: - Public Properties

    /// The markdown text to display. Links should use custom URL schemes (e.g., `[text](custom://action)`)
    /// to ensure the `onTap` closure is called instead of BPKLink automatically opening URLs.
    public var markdown: String {
        get { viewModel.markdown }
        set { viewModel.markdown = newValue }
    }

    public override var accessibilityIdentifier: String? {
        get { viewModel.accessibilityIdentifier }
        set { viewModel.accessibilityIdentifier = newValue }
    }

    public override var accessibilityLabel: String? {
        get { viewModel.accessibilityLabel }
        set { viewModel.accessibilityLabel = newValue }
    }

    public override var accessibilityTraits: UIAccessibilityTraits {
        get { viewModel.accessibilityTraits ?? super.accessibilityTraits }
        set { viewModel.accessibilityTraits = newValue }
    }

    // MARK: - Private Properties

    private let viewModel: SwiftUILinkViewModel
    private let hostingView: UIView

    // MARK: - Initialization

    /// Creates a new BPKLinkWrapper.
    ///
    /// - Parameters:
    ///   - markdown: Initial markdown text (default: empty string)
    ///   - style: The link style (default: `.default`)
    ///   - fontStyle: The font style (default: `.bodyDefault`)
    ///   - onTap: Closure called when the link is tapped
    public init(
        markdown: String = "",
        style: Backpack_SwiftUI.BPKLinkStyle = .default,
        fontStyle: Backpack_SwiftUI.BPKFontStyle = .bodyDefault,
        onTap: @escaping () -> Void = {}
    ) {
        let components = UIView.makeReactiveSwiftUIBPKLink(
            markdown: markdown,
            style: style,
            fontStyle: fontStyle,
            onCustomLink: { _ in onTap() }
        )

        self.hostingView = components.0
        self.viewModel = components.1

        super.init(frame: .zero)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupView() {
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hostingView)

        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: topAnchor),
            hostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
