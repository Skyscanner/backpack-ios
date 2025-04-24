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
    @State private var offset = 0.0
    private let duration: Double
    private let bounce = false
    private let bandSize: Double
    private let size: BPKShimmer.Size
    public enum Size {
        case small, `default`
    }

    init(size: BPKShimmer.Size) {
        self.size = size
        self.duration = size == .default ? 1.0 : 1.0
        self.bandSize = size == .default ? 0.3 : 0.6
    }

    public func body(content: Content) -> some View {
        content
            .mask(size == .default ? linearGradient : smallLinearGradient)
            .animation(size == .default ? linearAnimation : easeInOuAnimation, value: offset)
            .clipped()
            .drawingGroup(opaque: false)
            .onAppear {
                offset = 1.0 + bandSize
            }
    }

    private var linearAnimation: Animation {
        .linear(duration: duration).repeatForever(autoreverses: bounce)
    }

    private var easeInOuAnimation: Animation {
        .easeInOut(duration: duration).repeatForever(autoreverses: bounce)
    }

    private var linearGradient: LinearGradient {
        .init(
            gradient: Gradient(colors: [alpha(1), alpha(0.8), alpha(1)]),
            startPoint: UnitPoint(x: -bandSize + offset, y: 0.5),
            endPoint: UnitPoint(x: offset, y: 0.5)
        )
    }

    private var smallLinearGradient: LinearGradient {
        .init(
            gradient: Gradient(stops: [
                .init(color: alpha(1), location: 0.0),
                .init(color: alpha(0.3), location: 0.5),
                .init(color: alpha(1), location: 1.0)
            ]),
            startPoint: UnitPoint(x: -bandSize + offset, y: 0.5),
            endPoint: UnitPoint(x: offset, y: 0.5)
        )
    }

    private func alpha(_ alpha: CGFloat) -> Color {
        return Color(BPKColor.skeletonShimmerCenterColor.withAlphaComponent(alpha))
    }
}

// Test to add a pause between occurrences of the animation but it ends with the view being white/clear
//
// public struct BPKShimmer: ViewModifier {
//    @State private var offset: CGFloat = -1.0
//    @State private var isAnimating: Bool = true
//    private let duration: Double
//    private let bandSize: CGFloat
//    private let size: BPKShimmer.Size
//
//    public enum Size {
//        case small, `default`
//    }
//
//    public init(size: BPKShimmer.Size) {
//        self.size = size
//        // Here both sizes use the same duration; adjust as needed.
//        self.duration = 1.0
//        self.bandSize = size == .default ? 0.3 : 0.1
//    }
//
//    public func body(content: Content) -> some View {
//        Group {
//            if size == .default {
//                content
//                    .mask(defaultMask)
//                    .onAppear {
//                        offset = 1.0 + bandSize
//                    }
//                    .animation(defaultAnimation, value: offset)
//            } else {
//                // For small, we toggle the mask between the moving shimmer and a plain white mask.
//                content
//                    .mask(
//                        GeometryReader { geo in
//                            if isAnimating {
//                                shimmerMask(width: geo.size.width, height: geo.size.height)
//                            } else {
//                                Color.white  // plain white mask: shows content fully
//                            }
//                        }
//                    )
//                    .onAppear {
//                        startManualLoop()
//                    }
//            }
//        }
//        .clipped()
//        .drawingGroup(opaque: false)
//    }
//
//    // MARK: - Default size using a mask
//    private var defaultMask: some View {
//        LinearGradient(
//            gradient: Gradient(colors: [
//                alpha(1), alpha(0.8), alpha(1)
//            ]),
//            startPoint: UnitPoint(x: -bandSize + offset, y: 0.5),
//            endPoint: UnitPoint(x: offset, y: 0.5)
//        )
//    }
//
//    private var defaultAnimation: Animation {
//        .linear(duration: duration)
//            .repeatForever(autoreverses: false)
//    }
//
//    // MARK: - Small size shimmer mask
//    private func shimmerMask(width: CGFloat, height: CGFloat) -> some View {
//        shimmerGradient
//            .frame(width: width * 3, height: height)
//            .offset(x: offset * width)
//    }
//
//    private var shimmerGradient: LinearGradient {
//        LinearGradient(
//            gradient: Gradient(stops: [
//                .init(color: alpha(1), location: 0.0),
//                .init(color: alpha(0), location: 0.1),
//                .init(color: alpha(1), location: 0.2)
//            ]),
//            startPoint: .leading,
//            endPoint: .trailing
//        )
//    }
//
//    // MARK: - Manual loop for small size shimmer with pause
//    private func startManualLoop() {
//        Task {
//            while true {
//                // Start with the shimmering phase.
//                isAnimating = true
//                offset = -1
//                withAnimation(.easeInOut(duration: duration * 2)) {
//                    offset = 1
//                }
//                // Wait until the animation pass completes.
//                try? await Task.sleep(nanoseconds: UInt64(duration * 2 * 1_000_000_000))
//
//                // End the shimmer; set mask to white.
//                isAnimating = false
//
//                // Wait for a pause period before starting over.
//                try? await Task.sleep(nanoseconds: UInt64(duration * 1 * 1_000_000_000))
//            }
//        }
//    }
//
//    // MARK: - Helper: return the color for the mask.
//    private func alpha(_ alpha: CGFloat) -> Color {
//        // Here you can return your design system’s color.
//        return Color(BPKColor.skeletonShimmerCenterColor.withAlphaComponent(alpha))
//    }
// }
//
public extension View {
    @ViewBuilder func shimmering(size: BPKShimmer.Size = .default) -> some View {
        self.modifier(BPKShimmer(size: size))
    }
}
