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

struct DividedCardExampleView: View {
    
    private func primaryContent(title: String) -> some View {
        let message =  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. " +
            "Aenean commodo ligula eget dolor. Aenean massa."
        return VStack {
            BPKText(title, style: .heading3)
            BPKText(message)
                .lineLimit(3)
        }
    }
    
    private func secondaryContent() -> some View {
        BPKText("Lorem ipsum dolor sit amet")
    }
    
    var body: some View {
        VStack(spacing: 20) {
            BPKDividedCard {
                primaryContent(title: "Default")
            } secondaryContent: {
                secondaryContent()
            }
            
            BPKDividedCard(elevation: .none) {
                primaryContent(title: "Not Elevated")
            } secondaryContent: {
                secondaryContent()
            }
            
            BPKDividedCard {
                primaryContent(title: "Padded")
                    .padding()
            } secondaryContent: {
                secondaryContent()
                    .padding()
            }
        }
        .padding()
    }
}

struct DividedCardExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DividedCardExampleView()
    }
}
