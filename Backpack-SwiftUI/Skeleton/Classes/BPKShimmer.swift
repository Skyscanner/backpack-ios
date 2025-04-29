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

public struct BPKShimmer: ViewModifier {
    @State private var offset: CGFloat = 0.0
    private let duration: Double
    private let size: Size
    private let bandSize: CGFloat

    public enum Size {
        case small, `default`
    }

    public init(size: Size) {
        self.size = size
        self.duration = size == .default ? 1.0 : 0.5
        self.bandSize = size == .default ? 0.3 : 0.3
    }

    public func body(content: Content) -> some View {
        Group {
            if size == .default {
                // ORIGINAL SHIMMER FOR DEFAULT
                content
                    .mask(defaultMask)
                    .animation(
                        .linear(duration: duration)
                            .repeatForever(autoreverses: false),
                        value: offset
                    )
                    .onAppear {
                        offset = 1.0 + bandSize
                    }
            } else {
                // NEW SMALL SHIMMER METHOD
                content
                    .overlay(
                        GeometryReader { geo in
                            shimmerOverlay(width: geo.size.width, height: geo.size.height)
                                .offset(x: offset)
                                .onAppear {
                                    startSmallLoop(width: geo.size.width)
                                }
                        }
                    )
                    .mask(content)
            }
        }
        .clipped()
        .drawingGroup(opaque: false)
    }

    // MARK: Default Size - Mask logic
    private var defaultMask: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                alpha(1),
                alpha(0.8),
                alpha(1)
            ]),
            startPoint: UnitPoint(x: -bandSize + offset, y: 0.5),
            endPoint: UnitPoint(x: offset, y: 0.5)
        )
    }

    // MARK: Small Size - Moving overlay logic
    private func shimmerOverlay(width: CGFloat, height: CGFloat) -> some View {
        LinearGradient(
            gradient: Gradient(colors: [
                alpha(0.0),
                alpha(0.8),
                alpha(0.0)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .frame(width: width * 2.0, height: height) // 2x wider shimmer band
    }

    private func startSmallLoop(width: CGFloat) {
        Task {
            while true {
                // Reset offscreen left
                await MainActor.run {
                    offset = -width * 2
                }

                // Animate across to right
                withAnimation(.easeInOut(duration: duration)) {
                    offset = width * 2
                }

                // Wait for animation to finish and pause before resetting
                try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000 * 2.5))
            }
        }
    }

    private func alpha(_ alpha: CGFloat) -> Color {
        Color(BPKColor.skeletonShimmerCenterColor.withAlphaComponent(alpha))
    }
}

public extension View {
    @ViewBuilder func shimmering(size: BPKShimmer.Size = .default) -> some View {
        self.modifier(BPKShimmer(size: size))
    }
}
