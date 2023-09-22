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

class BPKTextAreaTests: XCTestCase {
    func test_defaultSettings() {
        assertSnapshot(
            BPKTextArea(.constant("Sample Text"), charLimit: 1000)
                .frame(width: 300, height: 200))
    }

    func test_emptyArea() {
        assertSnapshot(
            BPKTextArea(.constant(""), charLimit: 1000)
                .frame(width: 300, height: 200))
    }
    
    func test_exceedingCharLimit() {
        let longText = String(repeating: "a", count: 1100)
        assertSnapshot(
            BPKTextArea(.constant(longText), charLimit: 1000)
                .frame(width: 300, height: 200))
    }

    func test_withPlaceholder() {
        assertSnapshot(
            BPKTextArea(.constant(""), placeholder: "Enter your text", charLimit: 1000)
                .frame(width: 300, height: 200))
    }
}
