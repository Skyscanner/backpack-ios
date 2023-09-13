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
 * limitations under the License.
 */

import SwiftUI
import Backpack_SwiftUI

struct GraphicPromoExampleView: View {
    let verticalAlignment: BPKGraphicPromo.VerticalAlignment
    let sponsored: Bool

    init(verticalAlignment: BPKGraphicPromo.VerticalAlignment = .top, sponsored: Bool = false) {
        self.verticalAlignment = verticalAlignment
        self.sponsored = sponsored
    }
    
    var body: some View {
        ScrollView {
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the climb in 3 days",
                image: Image(decorative: "graphic_promo"),
                overlay: .solid(.off),
                verticalAlignment: verticalAlignment
            )
            .onTapGesture {
                print("Graphic promo tap")
            }
            .fallbackColor(Color(.surfaceHighlightColor))
            .if(sponsored) { view in
                view.sponsor(
                    title: "Sponsored",
                    logo: Image(decorative: "skyland"),
                    accessibilityLabel: "Sponsored by Skyland"
                )
            }
            .padding(.horizontal, .md)
        }
    }
}

struct GraphicPromoExampleView_Previews: PreviewProvider {
    static var previews: some View {
        GraphicPromoExampleView(verticalAlignment: .top, sponsored: false)
            .padding(.horizontal, .base)
    }
}
