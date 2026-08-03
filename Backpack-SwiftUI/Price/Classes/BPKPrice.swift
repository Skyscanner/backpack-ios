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
    
    public enum Style: Equatable {
        case `default`
        case onContrast
    }
    
    private let price: String
    private let leadingText: String?
    private let previousPrice: String?
    private let trailingText: String?
    private let icon: (BPKIcon, String)?
    private let style: Style
    private let onPriceClicked: (() -> Void)?
    private let alignment: Alignment
    private let size: Size
    
    public init(
        price: String,
        leadingText: String? = nil,
        previousPrice: String? = nil,
        trailingText: String? = nil,
        icon: (BPKIcon, String)? = nil,
        style: Style = .default,
        onPriceClicked: (() -> Void)? = nil,
        alignment: Alignment = .leading,
        size: Size
    ) {
        self.price = price
        self.leadingText = leadingText
        self.previousPrice = previousPrice
        self.trailingText = trailingText
        self.icon = icon
        self.style = style
        self.alignment = alignment
        self.size = size
        self.onPriceClicked = onPriceClicked
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
                VStack(alignment: .trailing, spacing: 0) {
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
                let color = (item == previousPrice) ? style.previousTextColor : style.leadingTextColor
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
            priceText(price, fontStyle: priceFontStyle)
            if let icon {
                redirectingIcon(icon: icon)
                    .offset(y: 2)
            }
        case .trailing:
            HStack(spacing: .sm) {
                priceText(price, fontStyle: priceFontStyle)
                if let icon {
                    redirectingIcon(icon: icon)
                }
            }
        }
        if let trailingText = trailingText {
            BPKText(trailingText, style: accessoryFontStyle)
                .foregroundColor(style.trailingTextColor)
        }
    }

    @ViewBuilder
    private func priceText(
        _ text: String,
        fontStyle: BPKFontStyle
    ) -> some View {
        if let onPriceClicked {
            BPKLink(
                markdown: "[\(text)](\(text))",
                style: style == .default ? .default : .onContrast,
                fontStyle: fontStyle,
                onCustomLink: { _ in onPriceClicked() }
            )
        } else {
            BPKText(text, style: fontStyle)
                .foregroundColor(style.priceTextColor)
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

// MARK: - Style

extension BPKPrice.Style {
    var previousTextColor: BPKColor {
        BPKColor.textErrorColor
    }
    
    var leadingTextColor: BPKColor {
        switch self {
        case .default: .textSecondaryColor
        case .onContrast: .textSecondaryOnContrastColor
        }
    }
    
    var priceTextColor: BPKColor {
        switch self {
        case .default: .textPrimaryColor
        case .onContrast: .textOnDarkColor
        }
    }
    
    var trailingTextColor: BPKColor {
        switch self {
        case .default: .textSecondaryColor
        case .onContrast: .textSecondaryOnContrastColor
        }
    }
}

// MARK: - Previews

struct BPKPrice_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BPKPrice(
                price: "£1830",
                leadingText: "App only deal",
                previousPrice: "£2030",
                trailingText: "per day",
                icon: (.newWindow, ""),
                style: .default,
                alignment: .leading,
                size: .extraSmall
            )
            .background(.surfaceDefaultColor)
            .previewDisplayName("Default Style")
            
            Group {
                BPKPrice(
                    price: "£1830",
                    leadingText: "App only deal",
                    previousPrice: "£2030",
                    trailingText: "per day",
                    icon: (.newWindow, ""),
                    style: .onContrast,
                    alignment: .leading,
                    size: .extraSmall
                )
                .background(.surfaceContrastColor)
                .previewDisplayName("OnContrast Style")
            }
        }
    }
}
