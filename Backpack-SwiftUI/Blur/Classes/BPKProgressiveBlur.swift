//
//  ProgressiveBlur 2.swift
//  Pods
//
//  Created by Ilkay Hamit on 25/07/2025.
//

import SwiftUI

public struct BPKProgressiveBlur: ViewModifier {
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

// Extension to make the modifier easy to use
public extension View {
    func bpkProgressiveBlur() -> some View {
        self.modifier(BPKProgressiveBlur(radius: 10))
    }
}
