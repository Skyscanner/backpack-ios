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

struct SelectExampleView: View {
    @State var goodChoices = ["Item 1", "Item 2", "Item 3"]
    @State var disabledChoices = ["Item 1", "Item 2", "Item 3"]
    @State var badChoices = ["Item 1", "Item 2", "Item 3"]
    @State var disabledSelection: Int? = 0
    @State var errorSelection: Int? = 0
    @State var selectionStartsNil: Int?
    @State var inBoundsSelection: Int? = 1
    @State var outOfBoundsSelection: Int? = 99
    
    var disabled: BPKSelect {
    BPKSelect(
        placeholder: "Disabled List",
        options: [],
        selectedIndex: $disabledSelection)
        .inputState(.disabled)
    }
    
    var error: BPKSelect {
    BPKSelect(
        placeholder: "List Error State",
        options: badChoices,
        selectedIndex: $errorSelection)
        .inputState(.error)
    }
    
    var goodChoicesNoSelection: BPKSelect {
        BPKSelect(
            placeholder: "Placeholder",
            options: goodChoices,
            selectedIndex: $selectionStartsNil)
    }
    
    var goodChoicesInBoundsSelection: BPKSelect {
        BPKSelect(
            placeholder: "Placeholder",
            options: goodChoices,
            selectedIndex: $inBoundsSelection)
    }
    
    var goodChoicesOutOfBoundsSelection: BPKSelect {
        BPKSelect(
            placeholder: "Placeholder",
            options: goodChoices,
            selectedIndex: $outOfBoundsSelection)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                goodChoicesNoSelection
                    .onChange(of: selectionStartsNil) { index in
                        print("Selection changed: \(index.map(String.init) ?? "nil")")
                    }
                goodChoicesInBoundsSelection
                goodChoicesOutOfBoundsSelection
                disabled
                error
            }
            .padding()
            .background(.canvasContrastColor)
        }
    }
}

struct SelectExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SelectExampleView()
    }
}
