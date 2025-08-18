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

// Based on Variable Blur Shader from Variablur
// Source: https://github.com/daprice/Variablur
// License: MIT License (https://github.com/daprice/Variablur/blob/main/LICENSE)
// Copyright (c) 2023 Daniel Price

/*
 * Variable Blur Metal Shader
 *
 * Two-pass Gaussian blur with variable radius controlled by mask texture.
 * Mask alpha values determine blur intensity (0 = no blur, 1 = full blur).
 */

import SwiftUI
import Metal
import MetalKit

@available(iOS 17, macOS 14, macCatalyst 17, tvOS 17, visionOS 1, *)
extension VisualEffect {
    
    /// Applies variable blur with radius determined by mask image.
    /// - Parameters:
    ///   - radius: Maximum blur radius where mask is fully opaque.
    ///   - maxSampleCount: Sample count per direction. Higher = smoother but more GPU intensive.
    ///   - mask: Alpha channel determines blur strength at each pixel.
    func variableBlur(
        radius: CGFloat,
        maxSampleCount: Int = 15,
        verticalPassFirst: Bool = false,
        mask: Image,
        isEnabled: Bool = true
    ) -> some VisualEffect {
        self.layerEffect(
            BackpackShaderLibrary.variableBlur(
                .boundingRect,
                .float(radius),
                .float(CGFloat(maxSampleCount)),
                .image(mask),
                .float(verticalPassFirst ? 1 : 0)
            ),
            maxSampleOffset: CGSize(width: radius, height: radius),
            isEnabled: isEnabled
        )
        .layerEffect(
            BackpackShaderLibrary.variableBlur(
                .boundingRect,
                .float(radius),
                .float(CGFloat(maxSampleCount)),
                .image(mask),
                .float(verticalPassFirst ? 0 : 1)
            ),
            maxSampleOffset: CGSize(width: radius, height: radius),
            isEnabled: isEnabled
        )
    }
}

@available(iOS 17, macOS 14, macCatalyst 17, tvOS 17, visionOS 1, *)
public extension View {
    /// Applies variable blur with custom mask renderer.
    /// - Parameters:
    ///   - radius: Blur radius where mask is fully opaque.
    ///   - maxSampleCount: Sample count per direction for quality vs performance.
    private func variableBlur(
        radius: CGFloat,
        maxSampleCount: Int = 15,
        verticalPassFirst: Bool = false,
        maskRenderer: @escaping (GeometryProxy, inout GraphicsContext) -> Void
    ) -> some View {
        self.visualEffect { content, geometryProxy in
            content.variableBlur(
                radius: radius,
                maxSampleCount: maxSampleCount,
                verticalPassFirst: verticalPassFirst,
                mask: Image(size: geometryProxy.size, renderer: { context in
                    maskRenderer(geometryProxy, &context)
                })
            )
        }
        .clipped()
    }

    /// Applies progressive blur effect from bottom to top.
    func bpkProgressiveBlur() -> some View {
        self.variableBlur(
            radius: 24,
            maxSampleCount: 15,
            verticalPassFirst: false
        ) { geometryProxy, context in
            let frame = geometryProxy.frame(in: .local)
            let halfHeight = frame.height / 2
            
            let bottomHalf = CGRect(
                x: frame.origin.x,
                y: frame.maxY - halfHeight,
                width: frame.width,
                height: halfHeight
            )
            
            context.fill(
                Path(bottomHalf),
                with: .linearGradient(
                    Gradient(stops: [
                        .init(color: Color.black.opacity(0.5), location: 0.0),
                        .init(color: Color.black.opacity(0.3), location: 0.5),
                        .init(color: .clear, location: 1.0)
                    ]),
                    startPoint: CGPoint(x: bottomHalf.midX, y: bottomHalf.maxY),
                    endPoint: CGPoint(x: bottomHalf.midX, y: bottomHalf.minY)
                )
            )
        }
        .clipped()
    }
}
