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
    @State private var phase: CGFloat = 0
    let duration = 1.0
    let bounce = false
    let delay = 0.2

    public func body(content: Content) -> some View {
        content
            .modifier(ShimmerMask(phase: phase).animation(
                Animation.linear(duration: duration)
                    .repeatForever(autoreverses: bounce)
            ))
            .onAppear { phase = 0.8 }
    }

    struct ShimmerMask: AnimatableModifier {
        var phase: CGFloat = 0

        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }

        func body(content: Content) -> some View {
            content
                .mask(GradientMask(phase: phase).scaleEffect(3))
        }
    }

    struct GradientMask: View {
        let phase: CGFloat

        var body: some View {
            LinearGradient(gradient:
                Gradient(stops: [
                    .init(color: alpha(1), location: phase),
                    .init(color: alpha(0.4), location: phase + 0.1),
                    .init(color: alpha(1), location: phase + 0.2)
                ]), startPoint: .leading, endPoint: .trailing)
        }
        
        private func alpha(_ alpha: CGFloat) -> Color {
            return Color(.white.withAlphaComponent(alpha).darkVariant(.black.withAlphaComponent(alpha)))
        }
    }
}

public extension View {
    @ViewBuilder func shimmering() -> some View {
        modifier(BPKShimmer())
    }
}
