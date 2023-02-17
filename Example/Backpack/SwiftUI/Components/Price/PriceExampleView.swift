//
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
    @State var price: String = "£1830"
    @State var previousPrice: String? = "£2033"
    @State var leadingText: String? = "App only deal"
    @State var trailingText: String? = "per day"
    
    // swiftlint:disable closure_body_length
    var body: some View {
        VStack(spacing: BPKSpacing.base.value) {
            HStack {
                BPKText("Leading and large", style: .heading5)
                Spacer()
                BPKPrice(
                    price: price,
                    leadingText: leadingText,
                    previousPrice: previousPrice,
                    trailingText: trailingText,
                    alignment: .leading,
                    size: .large
                )
            }
            .padding([.leading, .trailing], BPKSpacing.base.value)
            
            HStack {
                BPKText("Leading and small", style: .heading5)
                Spacer()
                BPKPrice(
                    price: price,
                    leadingText: leadingText,
                    previousPrice: previousPrice,
                    trailingText: trailingText,
                    alignment: .leading,
                    size: .small
                )
            }
            .padding([.leading, .trailing], BPKSpacing.base.value)
            
            HStack {
                BPKText("Trailing and large", style: .heading5)
                Spacer()
                BPKPrice(
                    price: price,
                    leadingText: leadingText,
                    previousPrice: previousPrice,
                    trailingText: trailingText,
                    alignment: .trailing,
                    size: .large
                )
            }
            .padding([.leading, .trailing], BPKSpacing.base.value)
            
            HStack {
                BPKText("Trailing and small", style: .heading5)
                Spacer()
                BPKPrice(
                    price: price,
                    leadingText: leadingText,
                    previousPrice: previousPrice,
                    trailingText: trailingText,
                    alignment: .trailing,
                    size: .small
                )
            }
            .padding([.leading, .trailing], BPKSpacing.base.value)
        }
    }
}

struct PriceExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PriceExampleView()
    }
}
