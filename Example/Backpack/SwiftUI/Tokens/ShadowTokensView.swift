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

struct ShadowTokensView: View {
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Small")
                .frame(width: 200, height: 200)
                .background(.surfaceDefaultColor)
                .clipShape(RoundedRectangle(cornerRadius: .lg))
                .shadow(.sm)
            Text("Large")
                .frame(width: 200, height: 200)
                .background(.surfaceDefaultColor)
                .clipShape(RoundedRectangle(cornerRadius: .lg))
                .shadow(.lg)
        }
        .padding()
    }
}

struct ShadowTokensView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShadowTokensView()
                .previewLayout(.sizeThatFits)
            ShadowTokensView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
