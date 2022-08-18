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
    private var size: BPKSkeleton.Size = .none
    private var customSize: CGSize = .zero
    private var style: BPKSkeleton.Style = .default
    private var color: Color = Color(.skyGrayTint06.darkVariant(.blackTint02))

    @State private var phase: CGFloat = 0
    let duration = 1.0
    let delay = 0.2
    
    public init(
        type: BPKSkeleton.ViewType,
        size: BPKSkeleton.Size = .default,
        style: BPKSkeleton.Style = .default
    ) {
        self.type = type
        self.style = style
        self.size = size

    }
    
    public init(
        type: BPKSkeleton.ViewType,
        size: CGSize,
        style: BPKSkeleton.Style = .default
    ) {
        self.type = type
        self.style = style
        self.customSize = size
    }
    
    public var body: some View {
        switch type {
        case .image:
            RoundedRectangle(cornerRadius: style.cornerRadius)
               .fill(color)
               .frame(width: size.imageSize, height: size.imageSize)
               .clipped()
        case .headline:
            RoundedRectangle(cornerRadius: BPKCornerRadius.xs)
               .fill(color)
               .frame(width: size.headlineWidth, height: size.headlineHeight)
               .clipped()
        case .circle:
            Circle()
               .fill(color)
               .frame(width: size.circleDiameter, height: size.circleDiameter)
               .clipped()
            
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
    }
}

struct BPKSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        BPKSkeleton(type: .image, size: .default, style: .default)
    }
}
