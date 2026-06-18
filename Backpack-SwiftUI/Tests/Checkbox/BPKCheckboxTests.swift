/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

import XCTest
import SwiftUI
@testable import Backpack_SwiftUI

class BPKCheckboxTests: XCTestCase {
    func test_bpkChip_states() {
        assertSnapshot(CheckboxStatesTestView())
    }

    func test_bpkChip_states_onContrast() {
        assertSnapshot(CheckboxStatesOnContrastTestView())
    }
}

private struct CheckboxStatesTestView: View {
    @State var unchecked = false
    @State var intermediate = true
    @State var error = false
    @State var regular = true
    @State var disabled = false

    var body: some View {
        VStack {
            BPKCheckbox("Option", checked: $unchecked)
                .padding()
            BPKCheckbox("Option", checked: $intermediate,
                        status: .intermediate)
                .padding()
            BPKCheckbox("Option", checked: $error,
                        status: .error)
                .padding()
            BPKCheckbox("Option", checked: $regular,
                        status: .regular)
                .padding()
            BPKCheckbox("Option", checked: $disabled)
                .disabled(true)
                .padding()
        }.padding()
    }
}

private struct CheckboxStatesOnContrastTestView: View {
    @State var unchecked = false
    @State var intermediate = true
    @State var error = false
    @State var regular = true
    @State var disabled = false

    var body: some View {
        VStack {
            BPKCheckbox("Option", checked: $unchecked,
                        style: .onContrast)
                .padding()
                .background(Color(.surfaceContrastColor))
            BPKCheckbox("Option", checked: $intermediate,
                        style: .onContrast,
                        status: .intermediate)
                .padding()
                .background(Color(.surfaceContrastColor))
            BPKCheckbox("Option", checked: $error,
                        style: .onContrast,
                        status: .error)
                .padding()
                .background(Color(.surfaceContrastColor))
            BPKCheckbox("Option", checked: $regular,
                        style: .onContrast,
                        status: .regular)
                .padding()
                .background(Color(.surfaceContrastColor))
            BPKCheckbox("Option", checked: $disabled,
                        style: .onContrast)
                .disabled(true)
                .padding()
                .background(Color(.surfaceContrastColor))
        }.padding()
    }
}
