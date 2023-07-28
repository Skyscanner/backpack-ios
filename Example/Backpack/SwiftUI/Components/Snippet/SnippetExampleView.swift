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

struct SnippetExampleView: View {
    var imageOrientation: BPKSnippet.ImageOrientation = .landscape
    
    var body: some View {
        ScrollView {
            snippet
        }
    }
    
    var snippet: some View {
        BPKSnippet(
            image: Image("dialog_image"),
            accessibilityLabel: "London at dawn",
            headline: "Headline Text",
            description: "Subheading",
            bodyText: "Body Text",
            imageOrientation: imageOrientation,
            onClick: {
                print("Clicked Snippet")
            }
        )
        .padding()
    }
}

struct SnippetExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SnippetExampleView(imageOrientation: .landscape)
        SnippetExampleView(imageOrientation: .square)
        SnippetExampleView(imageOrientation: .portrait)
    }
}
