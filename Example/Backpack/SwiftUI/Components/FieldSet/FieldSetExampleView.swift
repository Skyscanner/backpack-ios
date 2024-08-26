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

struct FieldSetExampleView: View {
    @State var text1 = ""
    let state: FieldState
    
    // swiftlint:disable closure_body_length
    var body: some View {
        ScrollView {
            VStack(spacing: .md) {
                BPKText("With Label & Description", style: .label1)
                constructFieldSet(
                    withLabel: "Label",
                    andDescription: "Description",
                    wrappedView: BPKTextField(placeholder: "Enter text", .constant(""))
                    )
                Divider()
                BPKText("With Label & No Description", style: .label1)
                constructFieldSet(
                    withLabel: "Label",
                    wrappedView: BPKTextField(placeholder: "Enter text", .constant(""))
                )
                Divider()
                BPKText("With No Label & Description", style: .label1)
                constructFieldSet(
                    andDescription: "Description",
                    wrappedView: BPKTextArea(.constant(""), placeholder: "Enter text")
                )
                Divider()
                BPKText("With No Label & No Description", style: .label1)
                constructFieldSet(
                    wrappedView: BPKSelect(
                        placeholder: "Breakfast Choices",
                        options: ["Porridge", "Eggs", "Swift UI"],
                        selectedIndex: .constant(1)
                    )
                )
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func constructFieldSet(
        withLabel label: String? = nil,
        andDescription description: String? = nil,
        wrappedView: some BPKFieldSetContentView
    ) -> some View {
        BPKFieldSet(label: label, description: description) {
            wrappedView
        }
        .accessibilityPrefix("Example")
        .if(state == .error) { view in
            view.inputState(.error(message: "Error Message"))
        }
    }

    enum FieldState {
        case `default`
        case error
    }
}

#Preview("Default State") {
    FieldSetExampleView(state: .default)
}

#Preview("Error State") {
    FieldSetExampleView(state: .error)
}
