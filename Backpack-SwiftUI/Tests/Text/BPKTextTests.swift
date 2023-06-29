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
import SnapshotTesting
@testable import Backpack_SwiftUI

class BPKTextTests: XCTestCase {
    func test_defaultSettings() {
        assertSnapshot(BPKText("Hello Backpack, I hope you're having a great day!")
                        .frame(width: 300))
    }
    
    func test_multiLine() {
        assertSnapshot(BPKText("Hello Backpack, I hope you're having a great day!")
                        .lineLimit(2)
                        .frame(width: 300)
        )
    }
    
    func test_customStyle() {
        assertSnapshot(BPKText("Hello Backpack, I hope you're having a great day!", style: .heading1))
    }
    
    func test_customColor() {
        assertSnapshot(BPKText("Hello Backpack, I hope you're having a great day!")
                        .foregroundColor(.primaryColor)
        )
    }
}
