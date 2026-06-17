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
        assertSnapshot(
            VStack {
                BPKCheckbox("Option", onTap: {})
                    .padding()
                BPKCheckbox("Option", selected: true,
                            status: .intermediate,
                            onTap: {})
                    .padding()
                BPKCheckbox("Option",
                            status: .error,
                            onTap: {})
                    .padding()
                BPKCheckbox("Option", selected: true,
                            status: .regular,
                            onTap: {})
                    .padding()
                BPKCheckbox("Option", onTap: {})
                    .disabled(true)
                    .padding()
            }.padding()
        )
    }

    func test_bpkChip_states_onContrast() {
        assertSnapshot(
            VStack {
                BPKCheckbox("Option",
                            onTap: {})
                    .padding()
                    .background(.surfaceContrastColor)
                BPKCheckbox("Option", selected: true,
                            style: .onContrast,
                            status: .intermediate,
                            onTap: {})
                    .padding()
                    .background(.surfaceContrastColor)
                BPKCheckbox("Option",
                            style: .onContrast,
                            status: .error,
                            onTap: {})
                    .padding()
                    .background(.surfaceContrastColor)
                BPKCheckbox("Option", selected: true,
                            style: .onContrast,
                            status: .regular,
                            onTap: {})
                    .padding()
                    .background(.surfaceContrastColor)
                BPKCheckbox("Option",
                            style: .onContrast,
                            onTap: {})
                .disabled(true)
                    .padding()
                    .background(.surfaceContrastColor)
            }.padding()
        )
    }
}
