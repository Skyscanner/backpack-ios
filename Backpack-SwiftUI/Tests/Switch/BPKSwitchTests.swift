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

class BPKSwitchTests: XCTestCase {
    func testSwitchOnState() {
        assertSnapshot(BPKSwitch(isOn: .constant(true), text: "Test").padding(.sm))
    }
    
    func testSwitchOffState() {
        assertSnapshot(BPKSwitch(isOn: .constant(false), text: "Test").padding(.sm))
    }

    func testSwitchTruncatedByDefault() {
        assertSnapshot(BPKSwitch(isOn: .constant(false), text: "line 1\n line 2").padding(.sm))
    }

    func testSwitchTruncatedFalse() {
        assertSnapshot(
            BPKSwitch(
                isOn: .constant(false),
                text: "line 1\n line 2",
                truncate: false
            ).padding(.sm)
        )
    }
}
