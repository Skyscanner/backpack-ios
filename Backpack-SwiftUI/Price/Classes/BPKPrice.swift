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
    private let icon: (BPKIcon, String)?
    private let cta: String?
    private let ctaOnCustomLink: (URL) -> Void
    private let alignment: Alignment
    private let size: Size
    
    public init(
        price: String,
        leadingText: String? = nil,
        previousPrice: String? = nil,
        trailingText: String? = nil,
        icon: (BPKIcon, String)? = nil,
        cta: String? = nil,
        ctaOnCustomLink: @escaping (URL) -> Void = { _ in },
        alignment: Alignment = .leading,
        size: Size
    ) {
        self.price = price
        self.leadingText = leadingText
        self.previousPrice = previousPrice
        self.trailingText = trailingText
        self.icon = icon
        self.cta = cta
        self.ctaOnCustomLink = ctaOnCustomLink
        self.alignment = alignment
        self.size = size
    }
    
    public var body: some View {
        Group {
            switch alignment {
            case .leading:
                VStack(alignment: .leading, spacing: BPKSpacing.none) {
                    content
                    ctaView
                }
            case .trailing:
                VStack(alignment: .trailing, spacing: BPKSpacing.none) {
                    content
                    ctaView
                }
            case .row:
                if cta == nil {
                    HStack(alignment: .firstTextBaseline, spacing: .sm) {
                        content
                    }
                } else {
                    VStack(alignment: .leading, spacing: BPKSpacing.none) {
                        HStack(alignment: .firstTextBaseline, spacing: .sm) {
                            content
                        }
                        ctaView
                    }
                }
            }
        }
        .if(!BPKFont.enableDynamicType, transform: {
            $0.sizeCategory(.large)
        })
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
                VStack(alignment: .trailing, spacing: 0) {
                    priceLabel
                }
            }
        }
    }

    private var additionalInfoLabel: some View {
        HStack(spacing: .sm) {
            ForEach(additionalInfo, id: \.self) { item in
                let color = (item == previousPrice) ? BPKColor.textErrorColor: BPKColor.textSecondaryColor
                BPKLink(
                    markdown: item,
                    fontStyle: accessoryFontStyle,
                    textColor: color
                )
                .lineLimit(1)
                .strikethrough(item == previousPrice)
            }
        }
    }
    
    @ViewBuilder
    private var priceLabel: some View {
        switch alignment {
        case .leading, .row:
            BPKLink(markdown: price, fontStyle: priceFontStyle)
                .lineLimit(1)
            if let icon {
                redirectingIcon(icon: icon)
                    .offset(y: 2)
            }
        case .trailing:
            HStack(spacing: .sm) {
                BPKLink(markdown: price, fontStyle: priceFontStyle)
                    .lineLimit(1)
                if let icon {
                    redirectingIcon(icon: icon)
                }
            }
        }
        if let trailingText = trailingText {
            BPKLink(
                markdown: trailingText,
                fontStyle: accessoryFontStyle,
                textColor: .textSecondaryColor
            )
            .lineLimit(1)
        }
    }

    @ViewBuilder
    private var ctaView: some View {
        if let cta {
            BPKLink(
                markdown: cta,
                fontStyle: accessoryFontStyle,
                onCustomLink: ctaOnCustomLink
            )
            .padding(.top, .sm)
        }
    }
    
    private func redirectingIcon(icon: (BPKIcon, String)) -> some View {
        let (newIcon, accessibilityLabel) = icon
        return BPKIconView(newIcon, size: .small, accessibilityLabel: accessibilityLabel)
            .accessibilityAddTraits(.isButton)
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
            icon: (.newWindow, ""),
            alignment: .leading,
            size: .extraSmall
        )
    }
}
