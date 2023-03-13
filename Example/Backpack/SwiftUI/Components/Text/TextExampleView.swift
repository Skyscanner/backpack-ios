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

struct TextExampleView: View {
    let items: [(Backpack_SwiftUI.BPKFontStyle, String)]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(0..<items.count, id: \.self) { index in
                    HStack {
                        BPKText(items[index].1, style: items[index].0)
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}

struct TextExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TextExampleView(items: [
            (.bodyLongform, "Body long form"),
            (.bodyDefault, "Body default")
        ])
    }
}
