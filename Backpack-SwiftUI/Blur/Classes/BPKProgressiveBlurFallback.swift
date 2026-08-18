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
///
/// - Note: This is the < iOS 17 fallback for `bpkProgressiveBlur()` (see `VisualEffect+Blur.swift`).
///   It intentionally differs from the Metal-based `bpkProgressiveBlur()` in both region and gradient:
///   this fallback blurs the *full* height of the view (0%–100%) via a fixed 10pt blur revealed through
///   a 5-stop alpha cross-fade, whereas `bpkProgressiveBlur()` only blurs the bottom half (50%–100%) with
///   a continuously variable radius up to 24pt. As a result the two can look meaningfully different
///   depending on OS version. See `Backpack-SwiftUI/Blur/README.md` for the full comparison.
public struct BPKProgressiveBlurFallback: ViewModifier {
    /// The maximum blur radius to apply at the bottom of the view
    let radius: CGFloat
    
    public func body(content: Content) -> some View {
        content
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
                    .clipped()
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
