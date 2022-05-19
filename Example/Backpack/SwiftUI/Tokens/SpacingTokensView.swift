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

struct SpacingTokensView: View {
    let spacingTokens: [(String, BPKSpacing)] = [
        ("BPKSpacingSm", .sm),
        ("BPKSpacingMd", .md),
        ("BPKSpacingBase", .base),
        ("BPKSpacingLg", .lg),
        ("BPKSpacingXl", .xl),
        ("BPKSpacingXxl", .xxl)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            ForEach(spacingTokens, id: \.0) { token in
                HStack {
                    Color(.primaryColor)
                        .frame(
                            maxWidth: token.1,
                            maxHeight: .base)
                    Spacer()
                    Text("\(token.0) = \(token.1.value, specifier: "%.0f")")
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct SpacingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpacingTokensView()
    }
}
