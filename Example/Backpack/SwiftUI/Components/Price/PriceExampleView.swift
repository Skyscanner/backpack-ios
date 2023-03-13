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
                HStack {
                    BPKPrice(price: price, alignment: .leading, size: size)
                    Spacer()
                    BPKPrice(price: price, alignment: .trailing, size: size)
                }
                
                HStack {
                    BPKPrice(
                        price: price,
                        trailingText: trailingText,
                        alignment: .leading,
                        size: size
                    )
                    Spacer()
                    BPKPrice(
                        price: price,
                        trailingText: trailingText,
                        alignment: .trailing,
                        size: size
                    )
                }
                
                HStack {
                    BPKPrice(
                        price: price,
                        previousPrice: previousPrice,
                        trailingText: trailingText,
                        alignment: .leading,
                        size: size
                    )
                    Spacer()
                    BPKPrice(
                        price: price,
                        previousPrice: previousPrice,
                        trailingText: trailingText,
                        alignment: .trailing,
                        size: size
                    )
                }
                
                HStack {
                    BPKPrice(
                        price: price,
                        leadingText: leadingText,
                        trailingText: trailingText,
                        alignment: .leading,
                        size: size
                    )
                    Spacer()
                    BPKPrice(
                        price: price,
                        leadingText: leadingText,
                        trailingText: trailingText,
                        alignment: .trailing,
                        size: size
                    )
                }
                
                HStack {
                    BPKPrice(
                        price: price,
                        leadingText: leadingText,
                        previousPrice: previousPrice,
                        trailingText: trailingText,
                        alignment: .leading,
                        size: size
                    )
                    Spacer()
                    BPKPrice(
                        price: price,
                        leadingText: leadingText,
                        previousPrice: previousPrice,
                        trailingText: trailingText,
                        alignment: .trailing,
                        size: size
                    )
                }
            }
            .padding([.leading, .trailing], BPKSpacing.base.value)
            Spacer()
        }
    }
}

struct PriceExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PriceExampleView(size: .small)
    }
}
