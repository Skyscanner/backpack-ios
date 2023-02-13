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
        case leading, trailing
    }
    
    public let price: String
    public let leadingText: String?
    public let lineThroughText: String?
    public let trailingText: String?
    public let alignment: Alignment
    public let size: Size
    
    public init(
        price: String,
        leadingText: String? = nil,
        lineThroughText: String? = nil,
        trailingText: String? = nil,
        alignment: Alignment = .leading,
        size: Size
    ) {
        self.price = price
        self.leadingText = leadingText
        self.lineThroughText = lineThroughText
        self.trailingText = trailingText
        self.alignment = alignment
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
            
            if alignment == .trailing && size == .small {
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
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

struct BPKPrice_Previews: PreviewProvider {
    static var previews: some View {
        BPKPrice(
            price: "£1830",
            leadingText: "App only deal",
            lineThroughText: "£2030",
            trailingText: "per day",
            alignment: .leading,
            size: .large
        )
    }
}
