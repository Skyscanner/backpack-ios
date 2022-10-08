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

struct AttributedTextExampleView: View {
    let items: [BPKAttributedText.Item] = [
        .init("This is a ", style: .heading2),
        .init("BPKAttributedText ", style: .heading1, color: .statusDangerSpotColor),
        .init("Which supports ", style: .heading2),
        .init("multiple different font styles "),
        .init("You can simply create a ", style: .heading3),
        .init("BPKAttributedText ", style: .heading1, color: .skyBlue),
        .init("and pass different ", style: .footnote),
        .init("items with different ", style: .label3),
        .init("font styles "),
        .init("and colors.", color: .statusWarningSpotColor)
    ]
    
    var body: some View {
        BPKAttributedText(items: items)
    }
}

struct AttributedTextExampleView_Previews: PreviewProvider {
    static var previews: some View {
        AttributedTextExampleView()
    }
}
