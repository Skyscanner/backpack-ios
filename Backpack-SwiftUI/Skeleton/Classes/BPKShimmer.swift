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

struct BPKShimmer: ViewModifier {
    @State private var offset = 0.0
    private let duration = 1.0
    private let bandSize = 0.3
    
    public func body(content: Content) -> some View {
        content
            .mask(linearGradient)
            .animation(linearAnimation, value: offset)
            .onAppear {
                offset = 1.0 + bandSize
            }
    }
    
    private var linearAnimation: Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
    
    private var linearGradient: LinearGradient {
        .init(
            gradient: Gradient(colors: [alpha(1), alpha(0.8), alpha(1)]),
            startPoint: UnitPoint(x: -bandSize + offset, y: 0.5),
            endPoint: UnitPoint(x: offset, y: 0.5)
        )
    }
    
    private func alpha(_ alpha: CGFloat) -> Color {
        return Color(BPKColor.skeletonShimmerCenterColor.withAlphaComponent(alpha))
    }
}

public extension View {
    @ViewBuilder func shimmering() -> some View {
        modifier(BPKShimmer())
    }
}
