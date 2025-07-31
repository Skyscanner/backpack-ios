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
import Backpack_Common

/// A container view that wraps any SwiftUI content to make it tappable with proper accessibility support.
///
/// You create a tappable container by providing an `accessibilityLabel` that describes the tap action,
/// an `action` closure that will be executed when tapped, and the content to wrap using a ViewBuilder.
/// The container can use different button styles:
/// `.plain` (default) preserves visual appearance with standard tap feedback,
/// or `.noTapAnimation` which removes visual tap feedback for cases where content has its own interaction styling.
public struct BPKTappableContainer<Content: View>: View {
    /// The button style options available for the tappable container
    public enum ButtonStyleType {
        /// Plain button style that preserves content appearance with standard tap feedback
        case plain
        /// Button style with no tap animation or visual feedback
        case noTapAnimation
    }
    
    private let action: () -> Void
    private let accessibilityLabel: String
    private let content: () -> Content
    private let buttonStyleType: ButtonStyleType

    /// Creates a tappable container that wraps content with tap functionality
    ///
    /// - Parameters:
    ///   - accessibilityLabel: A string describing what happens when the container is tapped
    ///   - action: A closure that will be executed when the container is tapped
    ///   - buttonStyleType: The button style to use (defaults to .plain)
    ///   - content: A ViewBuilder closure containing the content to make tappable
    public init(
        accessibilityLabel: String,
        action: @escaping () -> Void,
        buttonStyleType: ButtonStyleType = .plain,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.accessibilityLabel = accessibilityLabel
        self.action = action
        self.buttonStyleType = buttonStyleType
        self.content = content
    }

    public var body: some View {
        switch buttonStyleType {
        case .plain:
            Button(action: action) {
                content()
            }
            .buttonStyle(.plain)
            .accessibilityLabel(accessibilityLabel)
            
        case .noTapAnimation:
            Button(action: action) {
                content()
            }
            .buttonStyle(NoTapAnimationStyle())
            .accessibilityLabel(accessibilityLabel)
        }
    }
}

/// A button style that removes tap animations and visual feedback
struct NoTapAnimationStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        // Make the whole button surface tappable.
        // Without this only content in the label is tappable and not whitespace.
        // Order is important so add it before the tap gesture
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}
