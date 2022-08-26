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
    private let type: BPKSkeleton.ViewType
    private let size: BPKSkeleton.Size
    private let style: BPKSkeleton.Style
    private let color: Color = Color(.skyGrayTint06.darkVariant(.blackTint02))
    private let bodytextRowSpacing: CGFloat = BPKSpacing.md.value
   
    private init(
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
               .frame(width: size.image.width, height: size.image.height)
               .clipped()
            
        case .headline:
            RoundedRectangle(cornerRadius: BPKCornerRadius.xs)
               .fill(color)
               .frame(width: size.headline.width, height:  size.headline.height)
               .clipped()
            
        case .circle:
            Circle()
               .fill(color)
               .frame(width: size.circle.width, height:  size.circle.height)
               .clipped()
            
        case .bodytext:
            VStack(alignment: .leading, spacing: bodytextRowSpacing) {
                makeTextRow(size: size.bodytext, multiplier: 0.86)
                makeTextRow(size: size.bodytext, multiplier: 1.0)
                makeTextRow(size: size.bodytext, multiplier: 0.57)
            }
        }
    }
    
    private func makeTextRow(size: CGSize, multiplier: Double) -> some View {
        let rowHeight = abs(size.height - bodytextRowSpacing * 2) / 3.0
        return RoundedRectangle(cornerRadius: 2)
           .fill(color)
           .frame(width: size.width * multiplier, height: rowHeight)
           .clipped()
    }
}

public extension BPKSkeleton {
    static func image(style: BPKSkeleton.Style = .default, size: BPKSkeleton.Size = .default) -> BPKSkeleton {
        return BPKSkeleton(type: .image, size: size, style: style)
    }
    
    static func circle(size: BPKSkeleton.Size = .default) -> BPKSkeleton {
        return BPKSkeleton(type: .circle, size: size)
    }
    
    static func headline(size: BPKSkeleton.Size = .default) -> BPKSkeleton {
        return BPKSkeleton(type: .headline, size: size)
    }
    
    static func bodytext(size: BPKSkeleton.Size = .default) -> BPKSkeleton {
        return BPKSkeleton(type: .bodytext, size: size)
    }
}

struct BPKSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        BPKSkeleton.image()
    }
}
