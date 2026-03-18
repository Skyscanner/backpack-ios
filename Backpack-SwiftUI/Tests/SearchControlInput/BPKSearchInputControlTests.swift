/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2024 Skyscanner Ltd
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

class BPKSearchInputControlTests: XCTestCase {
    func test_defaultSearchInputControl() {
        assertSnapshot(
            BPKSearchInputControl(
                placeholder: "Placeholder",
                value: nil,
                icon: .calendar,
                accessibilityLabel: "Label",
                action: {}
            )
            .frame(width: 300)
        )
    }
    
    func test_defaultSearchInputControl_withValue() {
        assertSnapshot(
            BPKSearchInputControl(
                placeholder: "Placeholder",
                value: "Value",
                icon: .calendar,
                accessibilityLabel: "Label",
                action: {}
            )
            .frame(width: 300)
        )
    }
    
    func test_defaultSearchInputControl_withLongText() {
        assertSnapshot(
            BPKSearchInputControl(
                placeholder: "Placeholder",
                value: "Long value text to fit",
                icon: .calendar,
                accessibilityLabel: "Label",
                action: {}
            )
            .frame(width: 150)
        )
    }
    
    func test_accessibility() {
        let searchInput = BPKSearchInputControl(
            placeholder: "Placeholder",
            value: nil,
            icon: .calendar,
            accessibilityLabel: "Label",
            action: {}
        )
        .frame(width: 300)
        assertA11ySnapshot(searchInput)
    }
    
    func test_accessibility_withLongText() {
        let searchInput = BPKSearchInputControl(
            placeholder: "Placeholder",
            value: "Long value text to fit",
            icon: .calendar,
            accessibilityLabel: "Label",
            action: {}
        )
        .frame(width: 150)
        assertA11ySnapshot(searchInput)
    }
}
