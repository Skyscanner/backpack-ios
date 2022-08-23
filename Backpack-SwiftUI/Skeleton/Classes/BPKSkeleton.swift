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
        let isCustom: Bool = (size == .none)
        switch type {
        case .image:
            let imageSize = isCustom ? customSize : size.imageSize
            RoundedRectangle(cornerRadius: style.cornerRadius)
               .fill(color)
               .frame(width: imageSize.width, height: imageSize.height)
               .clipped()
            
        case .headline:
            let headlineSize = isCustom ? customSize : size.headlineSize
            RoundedRectangle(cornerRadius: BPKCornerRadius.xs)
               .fill(color)
               .frame(width: headlineSize.width, height:  headlineSize.height)
               .clipped()
            
        case .circle:
            let circleSize = isCustom ? customSize : size.circleDiameter
            Circle()
               .fill(color)
               .frame(width: circleSize.width, height:  circleSize.height)
               .clipped()
            
        case .bodytext:
            let bodytextSize = isCustom ? customSize : size.bodytextSize
            VStack(alignment: .leading, spacing: BPKSpacing.sm.value * 2.5) {
                makeTextRow(size: bodytextSize, multiplier: 0.86)
                makeTextRow(size: bodytextSize, multiplier: 1.0)
                makeTextRow(size: bodytextSize, multiplier: 0.57)
            }
        }
    }
    
    private func makeTextRow(size: CGSize, multiplier: Double) -> some View {
        let rowHeight = abs(size.height - BPKSpacing.sm.value * 5) / 3.0
        return RoundedRectangle(cornerRadius: BPKCornerRadius.xs.value / 2)
           .fill(color)
           .frame(width: size.width * multiplier, height: rowHeight)
           .clipped()
    }
}

public extension BPKSkeleton {
    static func image(style: BPKSkeleton.Style = .default, size: CGSize = .zero) -> BPKSkeleton {
        return size == .zero ?
        BPKSkeleton(type: .image, style: style) :
        BPKSkeleton(type: .image, size: size, style: style)
    }
    
    static func circle(size: BPKSkeleton.Size = .default) -> BPKSkeleton {
        return BPKSkeleton(type: .circle, size: size)
    }
    
    static func circle(size: CGSize) -> BPKSkeleton {
        return BPKSkeleton(type: .circle, size: size)
    }
    
    static func headline(size: BPKSkeleton.Size = .default) -> BPKSkeleton {
        return BPKSkeleton(type: .headline, size: size)
    }
    
    static func headline(size: CGSize) -> BPKSkeleton {
        return BPKSkeleton(type: .headline, size: size)
    }
    
    static func bodytext(size: CGSize = .zero) -> BPKSkeleton {
        return size == .zero ?
        BPKSkeleton(type: .bodytext) :
        BPKSkeleton(type: .bodytext, size: size)
    }
}

struct BPKSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        BPKSkeleton(type: .image, size: .default, style: .default)
    }
}
