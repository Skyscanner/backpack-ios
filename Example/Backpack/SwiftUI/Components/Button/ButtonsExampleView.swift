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

struct ButtonsExampleView: View {
    @State private var loading = true
    let style: Backpack_SwiftUI.BPKButton.Style
    
    var body: some View {
        ZStack {
            Color(backgroundColor)
            VStack(alignment: .leading) {
                BPKText("Default")
                buttonRow(size: .default)
                BPKText("Large")
                buttonRow(size: .large)
                BPKSwitch(isOn: $loading, text: "Switch loading")
            }
            .padding()
        }
    }
    
    private var backgroundColor: Backpack_SwiftUI.BPKColor {
        switch style {
        case .secondaryOnDark, .linkOnDark, .primaryOnDark:
            return .skyGray
        default:
            return .backgroundColor
        }
    }
    
    private var switchTextColor: Backpack_SwiftUI.BPKColor {
        switch style {
        case .secondaryOnDark, .linkOnDark, .primaryOnDark:
            return .white
        default:
            return .textPrimaryColor
        }
    }
    
    private func buttonRow(size: Backpack_SwiftUI.BPKButton.Size) -> some View {
        VStack(alignment: .leading) {
            loadingButtons(size: size)
            basicButtons(size: size)
            iconButtons(size: size)
        }
    }
    
    private func loadingButtons(size: Backpack_SwiftUI.BPKButton.Size) -> some View {
        HStack {
            BPKButton(
                "Button",
                loading: $loading,
                size: size
            ) { }
            .buttonStyle(style)
            
            BPKButton(
                "Button",
                icon: .trailing(icon: .longArrowRight),
                loading: $loading,
                size: size
            ) { }
            .buttonStyle(style)
            
            BPKButton(
                icon: .longArrowRight,
                accessibilityLabel: "Button",
                loading: $loading,
                size: size
            ) { }
            .buttonStyle(style)
        }
    }
    
    private func basicButtons(size: Backpack_SwiftUI.BPKButton.Size) -> some View {
        HStack {
            BPKButton(
                "Search flights",
                size: size
            ) { }
            .buttonStyle(style)
            
            BPKButton(
                "Disabled",
                enabled: .constant(false),
                size: size
            ) { }
            .buttonStyle(style)
            
            BPKButton(
                icon: .longArrowRight,
                accessibilityLabel: "Button",
                size: size
            ) { }
            .buttonStyle(style)
        }
    }
    
    private func iconButtons(size: Backpack_SwiftUI.BPKButton.Size) -> some View {
        HStack {
            BPKButton(
                "Button",
                icon: .trailing(icon: .longArrowRight),
                size: size
            ) { }
            .buttonStyle(style)
            
            BPKButton(
                "Button",
                icon: .leading(icon: .longArrowRight),
                size: size
            ) { }
            .buttonStyle(style)
        }
    }
}

struct ButtonsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsExampleView(style: .secondary)
    }
}
