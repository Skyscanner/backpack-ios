/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

public struct BPKPrice: View {
    public enum Size {
        case large, small
    }
    
    public enum Alignment {
        case left, right
    }
    
    @Binding public var price: String
    @Binding public var leadingText: String?
    @Binding public var lineThroughText: String?
    @Binding public var trailingText: String?
    @Binding public var alignment: Alignment
    public let size: Size
    
    public init(
        price: Binding<String>,
        leadingText: Binding<String?> = .constant(nil),
        lineThroughText: Binding<String?> = .constant(nil),
        trailingText: Binding<String?> = .constant(nil),
        alignment: Binding<Alignment> = .constant(.left),
        size: Size
    ) {
        self._price = price
        self._leadingText = leadingText
        self._lineThroughText = lineThroughText
        self._trailingText = trailingText
        self._alignment = alignment
        self.size = size
    }
    
    public var body: some View {
        VStack(alignment: mapAlignment(), spacing: BPKSpacing.none.value) {
            HStack(spacing: BPKSpacing.sm.value) {
                if let lineThroughText = lineThroughText {
                    BPKText(lineThroughText, style: footnoteOrCaptionFontStyle())
                        .strikethrough(true)
                        .foregroundColor(.textSecondaryColor)
                }
                
                if lineThroughText != nil && leadingText != nil {
                    BPKText("•", style: footnoteOrCaptionFontStyle())
                        .foregroundColor(.textSecondaryColor)
                }
                
                if let leadingText = leadingText {
                    BPKText(leadingText, style: footnoteOrCaptionFontStyle())
                        .foregroundColor(.textSecondaryColor)
                }
            }
            
            if alignment == .right && size == .small {
                VStack(alignment: .trailing) {
                    BPKText(price, style: size == .large ? .heading2 : .heading4)
                    
                    if let trailingText = trailingText {
                        BPKText(trailingText, style: footnoteOrCaptionFontStyle())
                            .foregroundColor(.textSecondaryColor)
                    }
                }
            } else {
                HStack(alignment: .firstTextBaseline, spacing: BPKSpacing.sm.value) {
                    BPKText(price, style: size == .large ? .heading2 : .heading4)
                    if let trailingText = trailingText {
                        BPKText(trailingText, style: footnoteOrCaptionFontStyle())
                            .foregroundColor(.textSecondaryColor)
                    }
                }
            }
            
        }
    }
    
    private func footnoteOrCaptionFontStyle() -> BPKFontStyle {
        return size == .large ? .footnote : .caption
    }
    
    private func mapAlignment() -> HorizontalAlignment {
        switch alignment {
        case .left:
            return .leading
        case .right:
            return .trailing
        }
    }
}

struct BPKPrice_Previews: PreviewProvider {
    static var previews: some View {
        BPKPrice(
            price: .constant("£1830"),
            leadingText: .constant("App only deal"),
            lineThroughText: .constant("£2030"),
            trailingText: .constant("per day"),
            alignment: .constant(.left),
            size: .large
        )
    }
}
