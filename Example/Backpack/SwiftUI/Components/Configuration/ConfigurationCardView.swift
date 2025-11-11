//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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

import Backpack_SwiftUI
import SwiftUI

struct ConfigurationCardView: View {
    var body: some View {
        VStack(spacing: 40) {
            BPKCard() {
                BPKText("Default")
            }
            BPKCard(elevation: .focus) {
                BPKText("Focused")
            }
            BPKCard(padding: .none) {
                BPKText("Not Padded")
            }
            BPKCard(cornerStyle: .large) {
                BPKText("Large Corner")
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .background(.canvasContrastColor)
    }
}

#Preview {
    ConfigurationCardView()
}
