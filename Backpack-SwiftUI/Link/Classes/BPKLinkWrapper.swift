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
final class BPKLinkWrapper: UIView {

    // MARK: - Public Properties

    /// The markdown text to display. Links should use custom URL schemes (e.g., `[text](custom://action)`)
    /// to ensure the `onTap` closure is called instead of BPKLink automatically opening URLs.
    var markdown: String {
        get { viewModel.markdown }
        set { viewModel.markdown = newValue }
    }

    override var accessibilityIdentifier: String? {
        get { viewModel.accessibilityIdentifier }
        set { viewModel.accessibilityIdentifier = newValue }
    }

    var accessibilityLabelText: String? {
        get { viewModel.accessibilityLabel }
        set { viewModel.accessibilityLabel = newValue }
    }

    var linkAccessibilityTraits: AccessibilityTraits? {
        get { viewModel.accessibilityTraits }
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
    init(
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
