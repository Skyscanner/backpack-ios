/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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

struct MarkdownTextExampleView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                BPKText(markdown: "**London** to **Miami**")
                BPKText(markdown: "Book your **flight** and _hotel_ today", style: .heading3)
                BPKText(markdown: "Terms apply. See _full details_ for more information.", style: .footnote)
                    .lineLimit(nil)
                Spacer()
            }
            .padding()
        }
    }
}

struct MarkdownTextExampleView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownTextExampleView()
    }
}
