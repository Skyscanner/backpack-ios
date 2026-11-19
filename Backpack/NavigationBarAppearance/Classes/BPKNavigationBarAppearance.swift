/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

/// Styles UIKit's own navigation bar with Backpack colours and type.
///
/// Prefer the native bar over a custom header view: it respects every safe area, keeps its buttons at
/// the right size, and adapts to the device by itself. On iPhone Duo, for example, its buttons move into
/// the side rail with the status bar, which a custom header cannot do.
///
/// ```swift
/// BPKNavigationBarAppearance.apply(to: navigationController.navigationBar)
/// viewController.navigationItem.rightBarButtonItem = .bpkIconButton(
///     .heart,
///     accessibilityLabel: "Save",
///     action: UIAction { _ in save() }
/// )
/// ```
public enum BPKNavigationBarAppearance {
    /// The same styles as the SwiftUI `BPKNavigationView`.
    public enum Style {
        case `default`
        case transparent
        case surfaceContrast
        case canvasContrast
    }

    /// Applies Backpack styling to every appearance of a navigation bar and tints its buttons.
    public static func apply(to navigationBar: UINavigationBar, style: Style = .default) {
        let appearance = makeAppearance(style: style)
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactScrollEdgeAppearance = appearance
        navigationBar.tintColor = foregroundColor(for: style)
    }

    /// A navigation bar appearance with Backpack colours and type, for use with `UINavigationItem` too.
    public static func makeAppearance(style: Style = .default) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        if style == .transparent {
            appearance.configureWithTransparentBackground()
        } else {
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor(for: style)
            appearance.shadowColor = lineColor(for: style)
        }

        let textColor = foregroundColor(for: style)
        appearance.titleTextAttributes = BPKFont.makeAttributes(
            fontStyle: .textHeading5,
            customAttributes: [.foregroundColor: textColor]
        )
        appearance.largeTitleTextAttributes = BPKFont.makeAttributes(
            fontStyle: .textHeading2,
            customAttributes: [.foregroundColor: textColor]
        )

        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        buttonAppearance.normal.titleTextAttributes = BPKFont.makeAttributes(
            fontStyle: .textLabel1,
            customAttributes: [.foregroundColor: textColor]
        )
        appearance.buttonAppearance = buttonAppearance
        appearance.backButtonAppearance = buttonAppearance
        return appearance
    }

    private static func backgroundColor(for style: Style) -> UIColor {
        switch style {
        case .default, .transparent: return BPKColor.canvasColor
        case .surfaceContrast: return BPKColor.surfaceContrastColor
        case .canvasContrast: return BPKColor.canvasContrastColor
        }
    }

    private static func foregroundColor(for style: Style) -> UIColor {
        switch style {
        case .default, .transparent, .canvasContrast: return BPKColor.textPrimaryColor
        case .surfaceContrast: return BPKColor.textOnDarkColor
        }
    }

    private static func lineColor(for style: Style) -> UIColor? {
        switch style {
        case .default, .canvasContrast: return BPKColor.lineColor
        case .surfaceContrast: return BPKColor.lineOnDarkColor
        case .transparent: return nil
        }
    }
}

public extension UIBarButtonItem {
    /// A bar button that shows a Backpack icon. Native bar buttons keep a 44 pt touch target and, on
    /// iPhone Duo, move into the side rail with the rest of the bar.
    ///
    /// - Parameters:
    ///   - icon: The Backpack icon to show.
    ///   - accessibilityLabel: What the button does, read by VoiceOver.
    ///   - action: What happens when the button is tapped.
    static func bpkIconButton(
        _ icon: BPKLargeIconName,
        accessibilityLabel: String,
        action: UIAction
    ) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: BPKObjcUIKitIcon.makeLargeTemplateIcon(name: icon), primaryAction: action)
        item.accessibilityLabel = accessibilityLabel
        return item
    }
}
