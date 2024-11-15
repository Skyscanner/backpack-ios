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
        case large, small, extraSmall
    }
    
    public enum Alignment {
        case leading, trailing, row
    }
    
    private let price: String
    private let leadingText: String?
    private let previousPrice: String?
    private let trailingText: String?
    private let alignment: Alignment
    private let size: Size
    private let accessibilityLabel: String?
    
    public init(
        price: String,
        leadingText: String? = nil,
        previousPrice: String? = nil,
        trailingText: String? = nil,
        alignment: Alignment = .leading,
        size: Size,
        accessibilityLabel: String? = nil
    ) {
        self.price = price
        self.leadingText = leadingText
        self.previousPrice = previousPrice
        self.trailingText = trailingText
        self.alignment = alignment
        self.size = size
        self.accessibilityLabel = accessibilityLabel
    }
    
    public var body: some View {
        switch alignment {
        case .leading:
            VStack(alignment: .leading, spacing: BPKSpacing.none) {
                content
            }
        case .trailing:
            VStack(alignment: .trailing, spacing: BPKSpacing.none) {
                content
            }
        case .row:
            HStack(alignment: .firstTextBaseline, spacing: .sm) {
                content
            }
        }
    }
    
    private var content: some View {
        Group {
            additionalInfoLabel
            
            switch alignment {
            case .leading, .row:
                HStack(alignment: .firstTextBaseline, spacing: .sm) {
                    priceLabel
                }
            case .trailing:
                VStack(alignment: .trailing) {
                    priceLabel
                }
            }
        }
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
    }
    
    private var additionalInfoLabel: some View {
        HStack(spacing: .sm) {
            ForEach(additionalInfo, id: \.self) { item in
                let color = (item == previousPrice) ? BPKColor.textErrorColor: BPKColor.textSecondaryColor
                BPKText(item, style: accessoryFontStyle)
                    .foregroundColor(color)
                    .strikethrough(item == previousPrice)
            }
        }
    }
    
    @ViewBuilder
    private var priceLabel: some View {
        switch alignment {
        case .leading, .row:
            BPKText(price, style: priceFontStyle)
        case .trailing:
            HStack(spacing: .sm) {
                BPKText(price, style: priceFontStyle)
                redirectingIcon
            }
            Spacer().frame(height: 0)
        }

        if let trailingText = trailingText {
            BPKText(trailingText, style: accessoryFontStyle)
                .foregroundColor(.textSecondaryColor)
        }
    }
    
    private var redirectingIcon: some View {
        BPKIconView(.newWindow, size: iconSize)
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel(accessibilityLabel ?? "")
    }
    
    private var accessoryFontStyle: BPKFontStyle {
        switch size {
        case .large:
            return .footnote
        case .small, .extraSmall:
            return .caption
        }
    }
    
    private var priceFontStyle: BPKFontStyle {
        switch size {
        case .large:
            return .heading2
        case .small:
            return .heading4
        case .extraSmall:
            return .heading5
        }
    }
    
    private var iconSize: BPKIcon.Size {
        size == .large ? .large : .small
    }
    
    private var additionalInfo: [String] {
        var items = [String]()
        
        if let previousPrice = previousPrice {
            items.append(previousPrice)
        }
        
        if previousPrice != nil && leadingText != nil {
            items.append("•")
        }
        
        if let leadingText = leadingText {
            items.append(leadingText)
        }
        
        return items
    }
}

struct BPKPrice_Previews: PreviewProvider {
    static var previews: some View {
        BPKPrice(
            price: "£1830",
            leadingText: "App only deal",
            previousPrice: "£2030",
            trailingText: "per day",
            alignment: .trailing,
            size: .small
        )
    }
}
