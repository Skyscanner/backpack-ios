/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2025 Skyscanner Ltd
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

/// A ViewModifier that applies a progressive blur effect to a view
/// The blur gradually increases from no blur at the top to full blur at the bottom
public struct BPKProgressiveBlurFallback: ViewModifier {
    /// The maximum blur radius to apply at the bottom of the view
    let radius: CGFloat
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { _ in
                    // Create a linear gradient mask that goes from transparent at top to opaque at bottom
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0.0),      // Fully transparent at top
                            .init(color: .clear, location: 0.5),      // Still transparent at 50%
                            .init(color: .black, location: 1.0)       // Fully opaque at bottom
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    // Apply blur to the entire overlay
                    .blur(radius: radius)
                    // Use the gradient as a mask - only the bottom 50% will show the blur
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .clear, location: 0.0),
                                .init(color: .clear, location: 0.5),
                                .init(color: .clear, location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    // Blend the blurred overlay with the original content
                    .blendMode(.multiply)
                }
            )
            // Apply a more sophisticated approach using a custom blur overlay
            .overlay(
                GeometryReader { _ in
                    // Create the original content again
                    content
                        // Apply variable blur using a custom implementation
                        .blur(radius: radius)
                        // Mask it to only show the bottom 50%
                        .mask(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: .clear, location: 0.0),
                                    .init(color: .clear, location: 0.25),
                                    .init(color: .white.opacity(0.5), location: 0.5),
                                    .init(color: .white.opacity(1), location: 0.75),
                                    .init(color: .white.opacity(1), location: 1.0)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
            )
    }
    
}

/// Extension to make the progressive blur modifier easy to apply to any View
/// Provides a convenient method with a default blur radius
public extension View {
    /// Applies a progressive blur effect with a default radius of 10 points
    /// The blur effect starts from no blur at the top and gradually increases to full blur at the bottom
    /// - Returns: A view with the progressive blur modifier applied
    func bpkProgressiveBlurFallback() -> some View {
        self.modifier(BPKProgressiveBlurFallback(radius: 10))
    }
}


