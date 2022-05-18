/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

public struct BPKSwitch<Content: View>: View {
    @Binding private var isOn: Bool
    private let content: Content
    
    public init(isOn: Binding<Bool>, text: String) where Content == BPKText {
        self.init(isOn: isOn) {
            BPKText(text)
        }
    }
    
    public init(isOn: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isOn = isOn
        self.content = content()
    }
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            content
        }
        .toggleStyle(SwitchToggleStyle(tint: Color(.primaryColor)))
        
    }
}

struct BPKSwitch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                BPKSwitch(isOn: .constant(true), text: "Test")
                BPKSwitch(isOn: .constant(false)) {
                    BPKText("Test")
                }
            }
            .previewLayout(.sizeThatFits)
            VStack {
                BPKSwitch(isOn: .constant(true), text: "Test")
                BPKSwitch(isOn: .constant(false)) {
                    BPKText("Test")
                }
            }
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        }
    }
}
