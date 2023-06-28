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

struct ChipGroupExampleView: View {
    var style: Backpack_SwiftUI.BPKChipStyle
    
    var body: some View {
        VStack {
            BPKText("Rail", style: .heading5)
                .foregroundColor(style == .onDark ? .textOnDarkColor : .textPrimaryColor)
            BPKSingleSelectChipGroup(chips: [
                BPKSingleChipItem(text: "Shenzhen", icon: .city),
                BPKSingleChipItem(text: "London", icon: .city),
                BPKSingleChipItem(text: "Edinburgh"),
                BPKSingleChipItem(text: "Manchester"),
                BPKSingleChipItem(text: "Belfast"),
                BPKSingleChipItem(text: "Glasgow")
            ], style: style, type: .rail) {}

            BPKText("Wrap", style: .heading5)
                .foregroundColor(style == .onDark ? .textOnDarkColor : .textPrimaryColor)
            BPKSingleSelectChipGroup(chips: [
                BPKSingleChipItem(text: "Shenzhen", icon: .city),
                BPKSingleChipItem(text: "London", icon: .city),
                BPKSingleChipItem(text: "Edinburgh"),
                BPKSingleChipItem(text: "Manchester"),
                BPKSingleChipItem(text: "Belfast"),
                BPKSingleChipItem(text: "Glasgow")
            ], style: style, type: .wrap) {}
        }
        .padding()
    }
}

struct ChipGroupExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ChipGroupExampleView(style: .default)
        ChipGroupExampleView(style: .onDark)
    }
}
