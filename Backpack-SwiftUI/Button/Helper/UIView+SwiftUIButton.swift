import SwiftUI

public extension UIView {
    /// Creates a SwiftUI BPKButton wrapped in a UIHostingController and returns its view
    /// - Parameters:
    ///   - title: The button title
    ///   - accessibilityIdentifier: The accessibility identifier for the button
    ///   - style: The BPKButton style (e.g., .featured, .secondary)
    ///   - action: The action to perform when the button is tapped
    /// - Returns: A UIView containing the SwiftUI button
    static func makeSwiftUIBPKButton(
        title: String,
        accessibilityIdentifier: String,
        style: Backpack_SwiftUI.BPKButton.Style,
        action: @escaping () -> Void
    ) -> UIView {
        let swiftUIButton = BPKButton(
            title,
            size: .large,
            action: action
        )
        .buttonStyle(style)
        .stretchable()

        let hostingController = UIHostingController(rootView: swiftUIButton)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.accessibilityIdentifier = accessibilityIdentifier
        
        return hostingController.view
    }
}
