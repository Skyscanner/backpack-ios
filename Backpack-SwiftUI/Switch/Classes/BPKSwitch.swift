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

public struct BPKSwitch: View {
    @Binding private var isOn: Bool
    
    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            Group {}
        }
        .labelsHidden()
        .toggleStyle(SwitchToggleStyle(tint: Color(.primaryColor)))
        
    }
}

struct BPKSwitch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                BPKSwitch(isOn: .constant(true))
                BPKSwitch(isOn: .constant(false))
            }
            .previewLayout(.sizeThatFits)
            HStack {
                BPKSwitch(isOn: .constant(true))
                BPKSwitch(isOn: .constant(false))
            }
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        }
    }
}
