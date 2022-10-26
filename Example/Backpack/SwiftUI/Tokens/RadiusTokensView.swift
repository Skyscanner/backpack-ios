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
import Backpack
import Backpack_SwiftUI

struct RadiusTokensView: View {
    
    let radiusTokens: [(String, BPKCornerRadius)] = [
        ("BPKCornerRadiusXs", .xs),
        ("BPKCornerRadiusSm", .sm),
        ("BPKCornerRadiusMd", .md),
        ("BPKCornerRadiusLg", .lg),
        ("BPKCornerRadiusPill", .pill)
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(radiusTokens, id: \.0) { token in
                    BPKText("\(token.0) = \(Int(token.1.value))")
                        .foregroundColor(.white)
                        .padding(.lg)
                        .background(.corePrimaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: token.1))
                }
            }
        }
    }
}

struct RadiusView_Previews: PreviewProvider {
    static var previews: some View {
        RadiusTokensView()
    }
}
