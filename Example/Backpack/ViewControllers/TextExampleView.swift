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
    let styles = BPKTextContentExample.allFontStyles
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(0..<styles.count, id: \.self) { index in
                    BPKText(styles[index].1, style: styles[index].0)
                }
            }
        }
    }
}

private struct BPKTextContentExample {
    static let allFontStyles: [(Backpack_SwiftUI.BPKFontStyle, String)] = [
        (.hero1, "Hero 1"),
        (.hero2, "Hero 2"),
        (.hero3, "Hero 3"),
        (.hero4, "Hero 4"),
        (.hero5, "Hero 5"),
        (.heading1, "Heading 1"),
        (.heading2, "Heading 2"),
        (.heading3, "Heading 3"),
        (.heading4, "Heading 4"),
        (.heading5, "Heading 5"),
        (.subheading, "Subheading"),
        (.bodyDefault, "Body default"),
        (.bodyLongform, "Body long form"),
        (.caption, "Caption"),
        (.footnote, "Footnote"),
        (.label1, "Label 1"),
        (.label2, "Label 2"),
        (.label3, "Label 3")
    ]
}

struct TextExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TextExampleView()
    }
}
