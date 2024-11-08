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

final class BPKFieldSetTests: XCTestCase {
    // swiftlint:disable large_tuple
    private var testsCases: [(label: String?, description: String?, name: String)] {
        [
            ("Label", "Description", "LabelAndDescription"),
            ("Label", nil, "LabelAndNoDescription"),
            (nil, "Description", "NoLabelAndDescription"),
            (nil, nil, "NoLabelAndNoDescription")
        ]
    }
    
    func test_defaultState() {
        testsCases.forEach { testCase in
            assertSnapshot(
                BPKFieldSet(label: testCase.label, description: testCase.description, content: {
                    BPKTextField(placeholder: "Enter text", .constant(""))
                })
                .frame(width: 300),
                testName: "test_defaultStateWith\(testCase.name)"
            )
        }
    }
    
    func test_errorState() {
        testsCases.forEach { testCase in
            assertSnapshot(
                BPKFieldSet(label: testCase.label, description: testCase.description, content: {
                    BPKTextField(placeholder: "Enter text", .constant(""))
                })
                .inputState(.error(message: "Error Message"))
                .frame(width: 300),
                testName: "test_errorStateWith\(testCase.name)"
            )
        }
    }
}
