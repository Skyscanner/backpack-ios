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

class BPKSelectTests: XCTestCase {
    func test_defaultSettings() {
        assertSnapshot(BPKSelect(placeholder: "Backpacks",
                                 options: ["Patagonia", "Nike"],
                                 selectedIndex: 0,
                                 onSelectionChange: { _ in }
                                )
            .frame(width: 300))
    }
    
    func test_selectSecondItem() {
        assertSnapshot(BPKSelect(placeholder: "Backpacks",
                                 options: ["Patagonia", "Nike"],
                                 selectedIndex: 1,
                                 onSelectionChange: { _ in }
                                )
            .frame(width: 300))
    }
    
    func test_selectOutOfBoundsItem() {
        assertSnapshot(BPKSelect(placeholder: "Backpacks",
                                 options: ["Patagonia", "Nike"],
                                 selectedIndex: 666,
                                 onSelectionChange: { _ in }
                                )
            .frame(width: 300))
    }
    
    func test_emptyOptions() {
        assertSnapshot(BPKSelect(placeholder: "Backpacks",
                                 options: [],
                                 selectedIndex: 0,
                                 onSelectionChange: { _ in }
                                )
            .frame(width: 300))
    }
    
    func test_errorState() {
        assertSnapshot(BPKSelect(placeholder: "Backpacks",
                                 options: ["Error"],
                                 selectedIndex: 0,
                                 onSelectionChange: { _ in }
                                ).inputState(.error)
            .frame(width: 300))
    }
    
    func test_disabledState() {
        assertSnapshot(BPKSelect(placeholder: "Backpacks",
                                 options: ["Disabled"],
                                 selectedIndex: 0,
                                 onSelectionChange: { _ in }
                                ).inputState(.disabled)
            .frame(width: 300))
    }
}
