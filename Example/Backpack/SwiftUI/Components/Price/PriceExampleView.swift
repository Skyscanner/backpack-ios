//
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
 * limitations under the License.
 */

import SwiftUI
import Backpack_SwiftUI

struct PriceExampleView: View {
    @State var price: String = "£1830"
    
    var body: some View {
        VStack(spacing: BPKSpacing.base.value) {
            HStack {
                BPKText("Left and large", style: .heading5)
                Spacer()
                makePrice()
            }
            .padding([.leading, .trailing], BPKSpacing.base.value)
            
            HStack {
                BPKText("Left and small", style: .heading5)
                Spacer()
                makePrice(size: .small)
            }
            .padding([.leading, .trailing], BPKSpacing.base.value)
            
            HStack {
                BPKText("Right and large", style: .heading5)
                Spacer()
                makePrice(alignment: .right)
            }
            .padding([.leading, .trailing], BPKSpacing.base.value)
            
            HStack {
                BPKText("Right and small", style: .heading5)
                Spacer()
                makePrice(alignment: .right, size: .small)
            }
            .padding([.leading, .trailing], BPKSpacing.base.value)
        }
    }
    
    private func makePrice(
        _ price: String = "£1830",
        lineThroughText: String? = "£2033",
        leadingText: String? = "App only deal",
        trailingText: String? = "per day",
        alignment: Backpack_SwiftUI.BPKPrice.Alignment = .left,
        size: Backpack_SwiftUI.BPKPrice.Size = .large
    ) -> Backpack_SwiftUI.BPKPrice {
        BPKPrice(
            price: .constant(price),
            leadingText: .constant(leadingText),
            lineThroughText: .constant(lineThroughText),
            trailingText: .constant(trailingText),
            alignment: .constant(alignment), size: size
        )
    }
}

struct PriceExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PriceExampleView()
    }
}
