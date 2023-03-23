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

struct PanelExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: BPKSpacing.md.value) {
            BPKText("Default", style: .heading4)
            BPKPanel() {
                exampleContent
            }
            
            BPKText("No padding", style: .heading4)
            BPKPanel(padding: false) {
                exampleContent
            }
            Spacer()
        }
        .padding(.base)
    }
    
    private var exampleContent: some View {
        VStack {
            BPKText("Content")
                .foregroundColor(.textOnLightColor)
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .padding()
        .background(.statusWarningFillColor)
    }
}

struct PanelExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PanelExampleView()
    }
}
