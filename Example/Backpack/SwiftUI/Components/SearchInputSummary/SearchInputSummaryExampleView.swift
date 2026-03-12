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
    @State var text = "Text"
    @State var enableHighlihting = false
    @State var readOnly = false
    
    // swiftlint:disable closure_body_length line_length
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Text input with text prefix")
                    .font(.caption)
                BPKSearchInputSummary(inputPrefix: .text("To"), clearAction: .init(accessibilityLabel: "Clear", action: { text = "" }), $text)
                    .padding(.bottom)
                Text("Text input with icon prefix")
                    .font(.caption)
                BPKSearchInputSummary(inputPrefix: .icon(.search), clearAction: .init(accessibilityLabel: "Clear", action: { text = "" }), $text)
                    .padding(.bottom)
                Text("Clear action")
                    .font(.caption)
                BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: { text = "" }), $text)
                    .padding(.bottom)
                Text("Placeholder with empty text")
                    .font(.caption)
                BPKSearchInputSummary(placeholder: "Read Only with Placeholder", clearAction: .init(accessibilityLabel: "Clear", action: {}), readOnly: true, .constant(""))
                    .padding(.bottom)
                Text("Highlighting and read only states")
                    .font(.caption)
                BPKSearchInputSummary(clearAction: .init(accessibilityLabel: "Clear", action: { text = "" }), readOnly: readOnly, $text)
                    .customStyle($enableHighlihting.wrappedValue ? .focused : .default)
                Text("Docking Inputs")
                    .font(.caption)
                VStack(spacing: .base) {
                    BPKSearchInputSummary(placeholder: "Top", inputPrefix: .icon(.flight), clearAction: .init(accessibilityLabel: "Clear", action: { text = "" }), $text)
                        .docking(.top)
                        .padding([.top, .horizontal])

                    BPKSearchInputSummary(placeholder: "Middle", inputPrefix: .icon(.flight), clearAction: .init(accessibilityLabel: "Clear", action: { text = "" }), $text)
                        .docking(.middle)
                        .padding(.horizontal)
                    
                    BPKSearchInputSummary(placeholder: "Bottom", inputPrefix: .icon(.flight), clearAction: .init(accessibilityLabel: "Clear", action: { text = "" }), $text)
                        .docking(.bottom)
                        .padding([.bottom, .horizontal])
                }
                .background(.surfaceContrastColor)

                HStack {
                    Toggle("Enable highlighting", isOn: $enableHighlihting)
                    Toggle("Read only", isOn: $readOnly)
                }
            }
            .padding()
        }
    }
}

struct SearchInputSummaryExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchInputSummaryExampleView()
    }
}
