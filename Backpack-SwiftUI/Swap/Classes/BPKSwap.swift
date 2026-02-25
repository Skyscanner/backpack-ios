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

import SwiftUI

/// A circular button with a swap icon that rotates 180 degrees when tapped.
///
/// Use `BPKSwap` to provide a swap action, typically used to swap origin and destination
/// in search controls or similar use cases.
///
/// The button animates the icon with a 180-degree rotation on each tap to provide
/// visual feedback to the user.
///
/// Example usage:
/// ```swift
/// BPKSwap(accessibilityLabel: "Swap origin and destination") {
///     // Perform swap action
/// }
/// ```
public struct BPKSwap: View {
    private let style: Style
    private let accessibilityLabel: String
    private let action: () -> Void

    @State private var rotationAngle: Double = 0
    @State private var rotateClockwise: Bool = false

    /// Creates a new swap button.
    ///
    /// - Parameters:
    ///   - style: The visual style of the button. Defaults to `.canvasContrast`.
    ///   - accessibilityLabel: A localized string that describes the button's action.
    ///   - action: The closure to execute when the user taps the button.
    public init(
        style: Style = .canvasContrast,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) {
        self.style = style
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }

    public var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                rotationAngle += rotateClockwise ? 180 : -180
            }
            rotateClockwise.toggle()
            action()
        } label: {
            BPKIconView(.swapVertical, size: .small)
                .foregroundColor(style.iconColor)
                .rotationEffect(.degrees(rotationAngle))
        }
        .frame(width: Constants.containerSize, height: Constants.containerSize)
        .background(Color(style.backgroundColor))
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color(style.borderColor), lineWidth: Constants.borderWidth)
        )
        .accessibilityLabel(accessibilityLabel)
        .buttonStyle(NoOpacityButtonStyle())
    }

    private enum Constants {
        static let containerSize: CGFloat = 36
        static let borderWidth: CGFloat = 2
    }
}

// MARK: - Button Style

private struct NoOpacityButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

// MARK: - Style

public extension BPKSwap {
    /// The visual style for `BPKSwap`.
    enum Style {
        /// Use on canvas default backgrounds.
        /// Gray background with white border.
        case canvasDefault

        /// Use on canvas contrast backgrounds.
        /// White background with gray border.
        case canvasContrast

        /// Use on surface contrast (dark) backgrounds.
        /// White background with dark primary border.
        case surfaceContrast

        var backgroundColor: BPKColor {
            switch self {
            case .canvasDefault:
                return .canvasContrastColor
            case .canvasContrast, .surfaceContrast:
                return .surfaceDefaultColor
            }
        }

        var borderColor: BPKColor {
            switch self {
            case .canvasDefault:
                return .canvasColor
            case .canvasContrast:
                return .canvasContrastColor
            case .surfaceContrast:
                return .corePrimaryColor
            }
        }

        var iconColor: BPKColor {
            switch self {
            case .canvasDefault, .canvasContrast:
                return .textPrimaryColor
            case .surfaceContrast:
                return .corePrimaryColor
            }
        }
    }
}

// MARK: - Previews

struct BPKSwap_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .xl) {
            // Canvas Default
            VStack(alignment: .leading, spacing: .md) {
                BPKText("Canvas Default", style: .caption)
                BPKSwap(style: .canvasDefault, accessibilityLabel: "Swap") { }
            }
            .padding()
            .background(.canvasColor)

            // Canvas Contrast
            VStack(alignment: .leading, spacing: .md) {
                BPKText("Canvas Contrast", style: .caption)
                BPKSwap(style: .canvasContrast, accessibilityLabel: "Swap") { }
            }
            .padding()
            .background(.canvasContrastColor)

            // Surface Contrast
            VStack(alignment: .leading, spacing: .md) {
                BPKText("Surface Contrast", style: .caption)
                    .foregroundColor(.textOnDarkColor)
                BPKSwap(style: .surfaceContrast, accessibilityLabel: "Swap") { }
            }
            .padding()
            .background(.surfaceContrastColor)
        }
        .padding()
    }
}
