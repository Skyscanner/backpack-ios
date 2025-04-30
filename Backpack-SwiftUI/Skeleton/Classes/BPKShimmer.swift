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
    private let size: Size
    private let bounce = false

    public enum Size {
        case small, `default`
    }

    public init(size: Size) {
        self.size = size
    }

    public func body(content: Content) -> some View {
        content
            .mask(linearGradient)
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
        .easeInOut(duration: duration).delay(0.8).repeatForever(autoreverses: bounce)
    }

    private var linearGradient: LinearGradient {
        .init(
            gradient: gradient,
            startPoint: UnitPoint(x: -bandSize + offset, y: 0.5),
            endPoint: UnitPoint(x: offset, y: 0.5)
        )
    }

    private func alpha(_ alpha: CGFloat) -> Color {
        Color(BPKColor.skeletonShimmerCenterColor.withAlphaComponent(alpha))
    }

    private var duration: Double {
        return size == .default ? 1.0 : 0.5
    }

    private var bandSize: Double {
        return size == .default ? 0.3 : 2.0
    }

    private var gradient: Gradient {
        return size == .default ?
        Gradient(colors: [alpha(1), alpha(0.8), alpha(1)]) :
        Gradient(stops: [
            .init(color: alpha(1), location: 0.0),
            .init(color: alpha(0.3), location: 0.5),
            .init(color: alpha(1), location: 1.0)
        ])
    }
}

public extension View {
    @ViewBuilder func shimmering(size: BPKShimmer.Size = .default) -> some View {
        self.modifier(BPKShimmer(size: size))
    }
}
