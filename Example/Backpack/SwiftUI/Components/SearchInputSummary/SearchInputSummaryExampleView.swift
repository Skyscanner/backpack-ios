//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
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

struct SearchInputSummaryExampleView: View {
    @State var text1 = ""
    @State var text2 = "Value"
    @State var validationFieldText = ""
    
    var body: some View {
        ScrollView {
            VStack {
                BPKSearchInputSummary($text2)
                BPKSearchInputSummary(placeholder: "Placeholder", $text2)
                BPKSearchInputSummary($text1)
                BPKSearchInputSummary(inputPrefix: .text("To"), $text1)
                BPKSearchInputSummary(inputPrefix: .text("From"), $text2)
                BPKSearchInputSummary($text1)
                    .inputState(.disabled)
                BPKSearchInputSummary($text1)
                    .inputState(text1.isEmpty ? .default : .clear(accessibilityLabel: "Clear Field") { text1 = "" })
                BPKSearchInputSummary($text1)
                    .inputState(.valid)
                BPKSearchInputSummary($text1)
                    .inputState(.error)
                BPKSearchInputSummary(placeholder: "At least 6 characters", $validationFieldText)
                    .inputState(validateState())
            }
            .padding()
        }
    }
    
    private func validateState() -> Backpack_SwiftUI.BPKSearchInputSummary.State {
        switch validationFieldText.count {
        case 0: return .default
        case 1...5: return .error
        default: return .valid
        }
    }
}

struct SearchInputSummaryExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchInputSummaryExampleView()
    }
}
