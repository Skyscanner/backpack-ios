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

struct SpinnerExampleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            BPKText("TextPrimary", style: .heading4)
            makeSpinnerRow(.textPrimary)
            
            BPKText("Disabled", style: .heading4)
            makeSpinnerRow(.disabled)
            
            BPKText("OnDarkSurface", style: .heading4)
            makeSpinnerRow(.onDarkSurface, foregroundColor: .white)
                .background(.black)
        }
        .padding()
    }
    
    private func makeSpinnerRow(
        _ style: Backpack_SwiftUI.BPKSpinner.Style,
        foregroundColor: Backpack_SwiftUI.BPKColor = .textPrimaryColor
    ) -> some View {
        HStack(alignment: .bottom) {
            VStack {
                BPKSpinner(.sm, style: style)
                BPKText("Small")
                    .foregroundColor(foregroundColor)
            }
            Spacer()
            VStack {
                BPKSpinner(.lg, style: style)
                BPKText("Large")
                    .foregroundColor(foregroundColor)
            }
            Spacer()
            VStack {
                BPKSpinner(.xl, style: style)
                BPKText("ExtraLarge")
                    .foregroundColor(foregroundColor)
            }
        }
        .padding()
    }
}

struct SpinnerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerExampleView()
    }
}
