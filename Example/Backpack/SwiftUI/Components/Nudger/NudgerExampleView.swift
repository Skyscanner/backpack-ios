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

struct NudgerExampleView: View {
    @State private var value = 0
    
    var body: some View {
        VStack {
            BPKNudger(value: $value, min: 1, max: 10, step: 1)
                .accessibilityPrefix("Prefix")
                .accessibilityLabel("Passengers")
            BPKNudger(title: "Adults", subtitle: "Aged 16+", value: $value, min: 1, max: 10)
            BPKNudger(title: "Rooms", value: $value, min: 1, max: 10)
            BPKNudger(
                title: "Rooms",
                subtitle: "Each room should contain at least 1 adult",
                value: $value,
                min: 1,
                max: 10
            )
            BPKNudger(title: "Rooms", icon: .room, value: $value, min: 1, max: 10)
            BPKNudger(
                title: "Travellers",
                subtitle: "Aged 16 and older",
                icon: .adult,
                value: $value,
                min: 1,
                max: 10
            )
        }
        .padding()
    }
}

struct NudgerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NudgerExampleView()
    }
}
