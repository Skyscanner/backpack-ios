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
public struct BPKProgressiveBlur: ViewModifier {
    /// The maximum blur radius to apply at the bottom of the view
    let radius: CGFloat
    
    public func body(content: Content) -> some View {
        content
            // First overlay: Creates a basic progressive blur foundation
            .overlay(
                GeometryReader { _ in
                    // Create a linear gradient that defines the blur intensity
                    // This gradient goes from transparent (no blur) to opaque (full blur)
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0.0),      // No blur at top (0%)
                            .init(color: .clear, location: 0.5),      // Still no blur at middle (50%)
                            .init(color: .black, location: 1.0)       // Full blur intensity at bottom (100%)
                        ]),
                        startPoint: .top,    // Start gradient from top
                        endPoint: .bottom    // End gradient at bottom
                    )
                    // Apply uniform blur to the entire gradient overlay
                    .blur(radius: radius)
                    // Mask the blurred gradient to control where the blur effect appears
                    // This mask is currently all clear, so this overlay won't be visible
                    // (This appears to be leftover from development/experimentation)
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .clear, location: 0.0),    // Transparent at top
                                .init(color: .clear, location: 0.5),    // Transparent at middle
                                .init(color: .clear, location: 1.0)     // Transparent at bottom
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    // Blend mode to combine this overlay with the original content
                    .blendMode(.multiply)
                }
            )
            // Second overlay: The main progressive blur implementation
            .overlay(
                GeometryReader { _ in
                    // Duplicate the original content to create the blurred version
                    content
                        // Apply uniform blur to the duplicated content
                        .blur(radius: radius)
                        // Use a gradient mask to control which parts of the blur are visible
                        // This creates the progressive effect from no blur to full blur
                        .mask(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    // Top 25%: Completely transparent (no blur visible)
                                    .init(color: .clear, location: 0.0),
                                    .init(color: .clear, location: 0.25),
                                    
                                    // 25-50%: Gradual transition starts (50% blur opacity)
                                    .init(color: .white.opacity(0.5), location: 0.5),
                                    
                                    // 50-75%: Stronger blur becomes visible (full opacity)
                                    .init(color: .white.opacity(1), location: 0.75),
                                    
                                    // Bottom 25%: Full blur effect (full opacity)
                                    .init(color: .white.opacity(1), location: 1.0)
                                ]),
                                startPoint: .top,    // Gradient starts from top
                                endPoint: .bottom    // Gradient ends at bottom
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
    func bpkProgressiveBlur() -> some View {
        self.modifier(BPKProgressiveBlur(radius: 10))
    }
}
