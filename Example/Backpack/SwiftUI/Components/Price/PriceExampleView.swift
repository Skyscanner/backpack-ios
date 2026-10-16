/*
 * Backpack - Skyscanner's Design System
 *
 * CopyTrailing © 2023 Skyscanner Ltd. All Trailings reserved.
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
 * limitations under the License.
 */

import SwiftUI
import Backpack_SwiftUI

struct PriceExampleView: View {
    let size: Backpack_SwiftUI.BPKPrice.Size
    
    private let price: String = "£1830"
    private let previousPrice: String = "£2033"
    private let leadingText: String = "App only deal"
    private let trailingText: String = "per day"
    
    // swiftlint:disable closure_body_length
    var body: some View {
        ScrollView {
            VStack(spacing: BPKSpacingBase) {
                priceSection(style: .default, backgroundColor: .canvasColor)
                priceSection(style: .onContrast, backgroundColor: .surfaceContrastColor)
            }
            .padding([.leading, .trailing], .base)
            Spacer()
        }
    }

    @ViewBuilder
    private func priceSection(
        style: Backpack_SwiftUI.BPKPrice.Style,
        backgroundColor: Backpack_SwiftUI.BPKColor
    ) -> some View {
        VStack(spacing: BPKSpacingBase) {
            buildLeadingAndTrailingPrice(
                price: price,
                size: size,
                style: style
            )
            
            buildLeadingAndTrailingPrice(
                price: price,
                trailingText: trailingText,
                size: size,
                style: style
            )
            
            buildLeadingAndTrailingPrice(
                price: price,
                previousPrice: previousPrice,
                trailingText: trailingText,
                size: size,
                style: style
            )
            
            buildLeadingAndTrailingPrice(
                price: price,
                leadingText: leadingText,
                trailingText: trailingText,
                size: size,
                style: style
            )
            
            buildLeadingAndTrailingPrice(
                price: price,
                leadingText: leadingText,
                previousPrice: previousPrice,
                trailingText: trailingText,
                size: size,
                style: style
            )
            
            buildPriceWithClickAction(
                price: price,
                leadingText: leadingText,
                previousPrice: previousPrice,
                trailingText: trailingText,
                size: size,
                style: style
            )
            
            if size != .large {
                BPKPrice(
                    price: price,
                    previousPrice: previousPrice,
                    trailingText: trailingText,
                    style: style,
                    alignment: .row,
                    size: size
                )
                
                BPKPrice(
                    price: price,
                    leadingText: leadingText,
                    trailingText: trailingText,
                    style: style,
                    alignment: .row,
                    size: size
                )
                
                BPKPrice(
                    price: price,
                    leadingText: leadingText,
                    previousPrice: previousPrice,
                    trailingText: trailingText,
                    style: style,
                    alignment: .row,
                    size: size
                )
            }
        }
        .padding(.base)
        .background(Color(backgroundColor))
        .cornerRadius(BPKCornerRadius.md.value)
    }

    private func buildLeadingAndTrailingPrice(
        price: String,
        leadingText: String? = nil,
        previousPrice: String? = nil,
        trailingText: String? = nil,
        size: Backpack_SwiftUI.BPKPrice.Size,
        style: Backpack_SwiftUI.BPKPrice.Style
    ) -> some View {
        HStack {
            BPKPrice(
                price: price,
                leadingText: leadingText,
                previousPrice: previousPrice,
                trailingText: trailingText,
                style: style,
                alignment: .leading,
                size: size
            )
            Spacer()
            BPKPrice(
                price: price,
                leadingText: leadingText,
                previousPrice: previousPrice,
                trailingText: trailingText,
                style: style,
                alignment: .trailing,
                size: size
            )
        }
    }

    private func buildPriceWithClickAction(
        price: String,
        leadingText: String? = nil,
        previousPrice: String? = nil,
        trailingText: String? = nil,
        size: Backpack_SwiftUI.BPKPrice.Size,
        style: Backpack_SwiftUI.BPKPrice.Style
    ) -> some View {
        HStack {
            BPKPrice(
                price: price,
                leadingText: leadingText,
                previousPrice: previousPrice,
                trailingText: trailingText,
                style: style,
                onPriceClicked: {},
                alignment: .leading,
                size: size
            )
            Spacer()
            BPKPrice(
                price: price,
                leadingText: leadingText,
                previousPrice: previousPrice,
                trailingText: trailingText,
                style: style,
                onPriceClicked: {},
                alignment: .trailing,
                size: size
            )
        }
    }
}

struct PriceExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PriceExampleView(size: .small)
    }
}
