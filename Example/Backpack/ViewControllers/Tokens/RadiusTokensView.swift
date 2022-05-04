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

struct RadiusTokensView: View {
    
    let radiusTokens = [
        ("BPKCornerRadiusXs", BPKCornerRadiusXs),
        ("BPKCornerRadiusSm", BPKCornerRadiusSm),
        ("BPKCornerRadiusMd", BPKCornerRadiusMd),
        ("BPKCornerRadiusLg", BPKCornerRadiusLg),
        ("BPKCornerRadiusPill", BPKCornerRadiusPill)
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(radiusTokens, id: \.0) { token in
                    Text("\(token.0) = \(token.1, specifier: "%.0f")")
                        .padding(.lg)
                        .background(.primaryColor)
                        .foregroundColor(.abisko)
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
