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

struct CardWrapperExampleView: View {
    var body: some View {
        VStack {
            BPKCardWrapper(backgroundColor: .coreAccentColor) {
                HStack {
                    BPKText("Wrapper title", style: .label1)
                        .foregroundColor(.textOnDarkColor)
                    Spacer()
                }
                .padding([.leading, .trailing], .base)
                .padding([.top, .bottom], .md)
            } card: {
                BPKCard(elevation: .none) {
                    VStack(alignment: .leading, spacing: .md) {
                        BPKText("Let's explore", style: .heading5)
                        // swiftlint:disable:next line_length
                        BPKText("It's your world and we'll help you explore it. Find the best prices across millions of flights, hotels and car hire options to create your perfect trip.")
                            .lineLimit(nil)
                    }
                }
            }
        }
        .padding()
    }
}

struct CardWrapperExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            CardWrapperExampleView().preferredColorScheme($0)
        }
    }
}
