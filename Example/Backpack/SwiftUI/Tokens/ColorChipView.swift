//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

struct ColorChipView: View {
    let color: Backpack_SwiftUI.BPKColor
    let name: String
    
    var body: some View {
        HStack {
            BPKCard(padding: .none) {
                HStack {
                    Rectangle()
                        .frame(width: .lg, height: .lg)
                        .foregroundColor(color)
                        .clipShape(RoundedRectangle(cornerRadius: .sm))
                        .overlay(
                            RoundedRectangle(cornerRadius: .sm)
                                .stroke(Color(.lineColor), lineWidth: 1)
                        )
                    BPKText(name, style: .label1)
                }
                .padding(.md)
            }
            Spacer()
        }
    }
}

struct ColourChipView_Previews: PreviewProvider {
    static var previews: some View {
        ColorChipView(color: .textPrimaryInverseColor, name: "Text primary inverse")
    }
}
