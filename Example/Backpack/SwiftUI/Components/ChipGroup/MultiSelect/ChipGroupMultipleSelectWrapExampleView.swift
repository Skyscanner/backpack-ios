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

struct ChipGroupMultipleSelectWrapExampleView: View {
    struct ChipData {
        let name: String
        var selected: Bool
    }
    
    @State var chipsData = [
        ChipData(name: "Shenzhen", selected: false),
        ChipData(name: "London", selected: false),
        ChipData(name: "Edinburgh", selected: false),
        ChipData(name: "Manchester", selected: false),
        ChipData(name: "Belfast", selected: false),
        ChipData(name: "Glasgow", selected: false)
    ]
    
    var chips: [BPKMultiSelectChipGroup.ChipItem] {
        chipsData.enumerated().map({ (index, chip) in
            BPKMultiSelectChipGroup.ChipItem(
                text: chip.name, selected: chip.selected, onClick: { chipsData[index].selected.toggle() }
            )
        })
    }
    
    var body: some View {
        VStack {
            defaultChip
            onDarkChip
            onImageChip
        }
        .padding()
    }
    
    var defaultChip: some View {
        BPKMultiSelectChipGroup(
            chips: chips,
            type: .wrap
        )
            .padding()
    }
    
    var onDarkChip: some View {
        BPKMultiSelectChipGroup(
            chips: chips,
            style: .onDark,
            type: .wrap)
            .padding()
            .background(.surfaceContrastColor)
    }
    
    var onImageChip: some View {
        BPKMultiSelectChipGroup(
            chips: chips,
            style: .onImage,
            type: .wrap)
            .padding()
            .background(.statusSuccessSpotColor)
    }
}

struct ChipGroupMultipleSelectWrapExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ChipGroupMultipleSelectWrapExampleView()
    }
}
