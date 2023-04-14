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
    @State var optionSelected = false
    @State var dropdownSelected = false
    @State var disabled = false
    
    // swiftlint:disable closure_body_length
    var body: some View {
        VStack {
            HStack {
                Spacer()
                BPKChip("Option", style: style) {
                    optionSelected.toggle()
                }
                Spacer()
                BPKChip("Option", selected: true, style: style) {
                    optionSelected.toggle()
                }
                Spacer()
                BPKChip("Option", style: style) {
                    optionSelected.toggle()
                }
                .disabled(true)
                Spacer()
            }
            HStack {
                Spacer()
                BPKDropdownChip("Dropdown", style: style) {
                    dropdownSelected.toggle()
                }
                Spacer()
                BPKDropdownChip("Dropdown", selected: true, style: style) {
                    dropdownSelected.toggle()
                }
                Spacer()
                BPKDropdownChip("Dropdown", style: style) {
                    dropdownSelected.toggle()
                }
                .disabled(true)
                Spacer()
            }
            HStack {
                BPKDismissableChip("Dismiss", style: style) {
                    disabled.toggle()
                }
            }
            HStack {
                Spacer()
                BPKChip("With icon", icon: .deals, style: style) {
                    optionSelected.toggle()
                }
                Spacer()
                BPKChip("With icon", icon: .deals, selected: true, style: style) {
                    optionSelected.toggle()
                }
                Spacer()
                BPKChip("With icon", icon: .deals, selected: optionSelected, style: style) {
                    optionSelected.toggle()
                }
                .disabled(true)
                Spacer()
            }
        }
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
