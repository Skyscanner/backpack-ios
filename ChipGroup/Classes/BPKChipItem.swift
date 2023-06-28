/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

public struct BPKSingleChipItem {
    
    let text: String
    var icon: BPKIcon? = nil
    
    public init(text: String, icon: BPKIcon? = nil) {
        self.text = text
        self.icon = icon
    }
}

public struct BPKChipItem: View {
    let chip: BPKSingleChipItem
    let selected: Bool
    let style: BPKChipStyle
    let onSelectedChange: () -> Void
    
    public init(_ chip: BPKSingleChipItem,
                selected: Bool = false,
                style: BPKChipStyle = .default,
                onSelectedChange: @escaping () -> Void) {
        self.chip = chip
        self.selected = selected
        self.style = style
        self.onSelectedChange = onSelectedChange
    }
    
    public var body: some View {
        BPKChip(chip.text,
                icon: chip.icon,
                selected: selected,
                style: style,
                onClick: onSelectedChange)
    }
}

struct BPKChipItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKChipItem(BPKSingleChipItem(text: "Option", icon: .hotels)) {}
        }
    }
}
