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

private struct VerticalPriceStack: View {
    private let price: String
    private let trailingText: String?
    private let fontStyle: BPKFontStyle
    private let accessoryFontStyle: BPKFontStyle
    
    init(price: String, trailingText: String?, fontStyle: BPKFontStyle, accessoryFontStyle: BPKFontStyle) {
        self.price = price
        self.trailingText = trailingText
        self.fontStyle = fontStyle
        self.accessoryFontStyle = accessoryFontStyle
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            BPKText(price, style: fontStyle)
            if let trailingText = trailingText {
                BPKText(trailingText, style: accessoryFontStyle)
                    .foregroundColor(.textSecondaryColor)
            }
        }
    }
}

private struct HorizontalPriceStack: View {
    private let price: String
    private let trailingText: String?
    private let fontStyle: BPKFontStyle
    private let accessoryFontStyle: BPKFontStyle
    
    init(price: String, trailingText: String?, fontStyle: BPKFontStyle, accessoryFontStyle: BPKFontStyle) {
        self.price = price
        self.trailingText = trailingText
        self.fontStyle = fontStyle
        self.accessoryFontStyle = accessoryFontStyle
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: BPKSpacing.sm.value) {
            BPKText(price, style: fontStyle)
            if let trailingText = trailingText {
                BPKText(trailingText, style: accessoryFontStyle)
                    .foregroundColor(.textSecondaryColor)
            }
        }
    }
}

public struct BPKPrice: View {
    public enum Size {
        case large, small
    }
    
    public enum Alignment {
        case leading, trailing
    }
    
    private let price: String
    private let leadingText: String?
    private let previousPrice: String?
    private let trailingText: String?
    private let alignment: Alignment
    private let size: Size
    
    public init(
        price: String,
        leadingText: String? = nil,
        previousPrice: String? = nil,
        trailingText: String? = nil,
        alignment: Alignment = .leading,
        size: Size
    ) {
        self.price = price
        self.leadingText = leadingText
        self.previousPrice = previousPrice
        self.trailingText = trailingText
        self.alignment = alignment
        self.size = size
    }
    
    public var body: some View {
        VStack(alignment: mapAlignment(), spacing: BPKSpacing.none.value) {
            HStack(spacing: BPKSpacing.sm.value) {
                if let previousPrice = previousPrice {
                    accessoryText(previousPrice)
                        .strikethrough(true)
                }
                
                if previousPrice != nil && leadingText != nil {
                    accessoryText("•")
                }
                
                if let leadingText = leadingText {
                    accessoryText(leadingText)
                }
            }
            
            if let price = price, alignment == .trailing && size == .small {
                VerticalPriceStack(price: price,
                                   trailingText: trailingText,
                                   fontStyle: .heading4,
                                   accessoryFontStyle: accessoryFontStyle())
            } else if let price = price {
                HorizontalPriceStack(price: price,
                                     trailingText: trailingText,
                                     fontStyle: .heading2,
                                     accessoryFontStyle: accessoryFontStyle())
            }
            
        }
    }
    
    private func accessoryText(_ text: String) -> BPKText {
        return BPKText(text, style: accessoryFontStyle())
            .foregroundColor(.textSecondaryColor)
    }
    
    private func accessoryFontStyle() -> BPKFontStyle {
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
            previousPrice: "£2030",
            trailingText: "per day",
            alignment: .leading,
            size: .large
        )
    }
}
