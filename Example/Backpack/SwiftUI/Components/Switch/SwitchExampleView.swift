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

struct SwitchExampleView: View {
    @State var value = true
    
    var body: some View {
        VStack {
            BPKSwitch(isOn: $value, text: "Switch is \(value ? "On" : "Off")")
            BPKSwitch(
                isOn: $value,
                // swiftlint:disable:next line_length
                text: "This is a sample sentence designed to test the layout behavior, text truncation, and multi-line wrapping in SwiftUI previews, especially when rendering across different screen sizes, accessibility font settings, and dynamic type scaling scenarios. ",
                truncate: true
            )
            BPKSwitch(
                isOn: $value,
                // swiftlint:disable:next line_length
                text: "This is a sample sentence designed to test the layout behavior, text truncation, and multi-line wrapping in SwiftUI previews, especially when rendering across different screen sizes, accessibility font settings, and dynamic type scaling scenarios. ",
                truncate: false
            )
            BPKSwitch(
                isOn: $value,
                text: "Switch Text",
                truncate: false
            ).labelsHidden()
        }
        .padding()
    }
}

struct SwitchExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchExampleView()
    }
}
