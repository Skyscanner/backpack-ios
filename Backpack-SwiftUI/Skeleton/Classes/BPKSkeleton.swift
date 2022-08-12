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
import Backpack_Common

public struct BPKSkeleton: View {
    private var type: BPKSkeleton.ViewType = .image
    private var size: BPKSkeleton.Size = .default
    private var style: BPKSkeleton.Style = .default
    private var color: Color = Color(.skyGrayTint06.darkVariant(.blackTint02))
    private var transformX: CGFloat {
        switch type {
        case .image:
            return (size.imageSize / 2) + size.shimmerOverlayWidth
        case .headline:
            return (size.headlineWidth / 2) + size.shimmerOverlayWidth
        case .circle:
            return (size.circleDiameter / 2) + size.shimmerOverlayWidth
        case .bodytext:
            return 100 + size.shimmerOverlayWidth
        }
    }
    
    @State var animated = false
    
    public init(
        type: BPKSkeleton.ViewType,
        size: BPKSkeleton.Size = .default,
        style: BPKSkeleton.Style = .default
    ) {
        self.type = type
        self.style = style
        self.size = size

    }
    
    public var body: some View {
        switch type {
        case .image:
            RoundedRectangle(cornerRadius: style.cornerRadius)
               .fill(color)
               .frame(width: size.imageSize, height: size.imageSize)
               .clipped()
               .overlay(makeGradientOverlay())
        case .headline:
            RoundedRectangle(cornerRadius: BPKCornerRadius.xs)
               .fill(color)
               .frame(width: size.headlineWidth, height: size.headlineHeight)
               .clipped()
               .overlay(makeGradientOverlay())
        case .circle:
            Circle()
               .fill(color)
               .frame(width: size.circleDiameter, height: size.circleDiameter)
               .clipped()
               .overlay(makeGradientOverlay())
            
        case .bodytext:
            VStack(alignment: .leading, spacing: BPKSpacing.sm.value * 2.5) {
                makeTextRow(width: 171)
                makeTextRow(width: 200)
                makeTextRow(width: 114)
            }
        }
    }
    
    private func makeTextRow(width: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: BPKCornerRadius.xs.value / 2)
           .fill(color)
           .frame(width: width, height: BPKSpacing.md.value)
           .clipped()
           .overlay(makeGradientOverlay())
    }
    
    private func makeGradientOverlay() -> some View {
        Rectangle()
            .fill(alpha(0))
            .frame(width: size.shimmerOverlayWidth)
            .background(
                LinearGradient(gradient: Gradient(colors: [alpha(0), alpha(0.6), alpha(0)]), startPoint: .leading, endPoint: .trailing))
            .offset(x: animated ? transformX : -transformX)
            .animation(
                .linear(duration: 1).delay(0.2).repeatForever(autoreverses: false))
            .onAppear() {
                animated.toggle()
            }
    }
    
    private func alpha(_ alpha: CGFloat) -> Color {
        return Color(.white.withAlphaComponent(alpha).darkVariant(.black.withAlphaComponent(alpha)))
    }
}

struct BPKSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        BPKSkeleton(type: .image, size: .default, style: .default)
    }
}
