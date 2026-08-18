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
    @State private var value = true
    @State private var disabledValue = true

    private var attributedLabel: AttributedString {
        var label = AttributedString("Switch with styled text")
        label.foregroundColor = Color(.coreAccentColor)
        return label
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .base) {
                BPKText("Default", style: .heading5)

                BPKSwitch(
                    isOn: $value,
                    text: "Switch is \(value ? "On" : "Off")"
                )

                BPKSwitch(
                    isOn: $disabledValue,
                    text: "Disabled switch",
                    enabled: false
                )

                BPKSwitch(
                    isOn: $value,
                    text: attributedLabel
                )

                BPKSwitch(
                    isOn: $value,
                    text: "A longer switch label that demonstrates multiline wrapping.",
                    truncate: false
                )

                VStack(alignment: .leading, spacing: .base) {
                    BPKText("On contrast", style: .heading5)
                        .foregroundColor(.textOnDarkColor)

                    HStack {
                        BPKText("On contrast switch")
                            .foregroundColor(.textOnDarkColor)
                            .accessibilityHidden(true)

                        Spacer()

                        BPKSwitch(
                            isOn: $value,
                            text: "On contrast switch",
                            style: .onContrast
                        )
                    }

                    HStack {
                        BPKText("Disabled on contrast")
                            .foregroundColor(.textOnDarkColor)
                            .accessibilityHidden(true)

                        Spacer()

                        BPKSwitch(
                            isOn: $disabledValue,
                            text: "Disabled on contrast",
                            enabled: false,
                            style: .onContrast
                        )
                    }
                }
                .padding(.base)
                .background(Color(.surfaceContrastColor))
            }
            .padding()
        }
    }
}

struct SwitchExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchExampleView()
    }
}
