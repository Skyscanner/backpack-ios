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

struct ChipExampleView: View {
    let style: Backpack_SwiftUI.BPKChipStyle
    
    @State private var optionOffSelected = false
    @State private var optionOnSelected = true
    
    @State private var dropdownOffSelected = false
    @State private var dropdownOnSelected = true
    
    @State private var withIconOffSelected = false
    @State private var withIconOnSelected = true
    
    // swiftlint:disable closure_body_length
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                BPKText("Off", style: .heading5)
                    .foregroundColor(style == .onDark ? .textOnDarkColor : .textPrimaryColor)
                BPKChip("Option", selected: optionOffSelected, style: style) {
                    optionOffSelected.toggle()
                }
                BPKDropdownChip("Dropdown", selected: dropdownOffSelected, style: style) {
                    dropdownOffSelected.toggle()
                }
                Rectangle()
                    .fill(.clear)
                    .frame(height: .xl)
                BPKChip("With icon", icon: .deals, selected: withIconOffSelected, style: style) {
                    withIconOffSelected.toggle()
                }
            }
            
            VStack(alignment: .leading) {
                BPKText("On", style: .heading5)
                    .foregroundColor(style == .onDark ? .textOnDarkColor : .textPrimaryColor)
                BPKChip("Option", selected: optionOnSelected, style: style) {
                    optionOnSelected.toggle()
                }
                BPKDropdownChip("Dropdown", selected: dropdownOnSelected, style: style) {
                    dropdownOnSelected.toggle()
                }
                BPKDismissableChip("Dismiss", style: style) {
                    
                }
                BPKChip("With icon", icon: .deals, selected: withIconOnSelected, style: style) {
                    withIconOnSelected.toggle()
                }
            }
            
            VStack(alignment: .leading) {
                BPKText("Disabled", style: .heading5)
                    .foregroundColor(style == .onDark ? .textOnDarkColor : .textPrimaryColor)
                BPKChip("Option", style: style) {}
                .disabled(true)
                BPKDropdownChip("Dropdown", style: style) {
                }
                .disabled(true)
                Rectangle()
                    .fill(.clear)
                    .frame(height: .xl)
                BPKChip("With icon", icon: .deals, style: style) {
                }
                .disabled(true)
            }
        }
        .padding()
    }
}

struct ChipExampleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChipExampleView(style: .default)
            ChipExampleView(style: .onDark)
            ChipExampleView(style: .onImage)
        }
    }
}
