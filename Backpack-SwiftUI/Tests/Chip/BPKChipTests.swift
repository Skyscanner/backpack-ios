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

class BPKChipTests: XCTestCase {
    func test_textChip() {
        assertSnapshot(
            VStack {
                BPKChip("Option") {}
                BPKChip("Option", style: .onDark) {}
                    .padding()
                    .background(.surfaceContrastColor)
                BPKChip("Option", style: .onImage) {}
                    .padding()
                    .background(.coreEcoColor)
            }.padding()
        )
    }

    func test_chipWithIcon() {
        assertSnapshot(
            VStack {
                BPKChip("Option", icon: .account) {}
                BPKChip("Option", icon: .account, style: .onDark) {}
                    .padding()
                    .background(.surfaceContrastColor)
                BPKChip("Option", icon: .account, style: .onImage) {}
                    .padding()
                    .background(.coreEcoColor)
            }.padding()
        )
    }
    
    func test_chipSelected() {
        assertSnapshot(
            VStack {
                BPKChip("Selected", icon: .account, selected: true) {}
                BPKChip("Selected", icon: .account, selected: true, style: .onDark) {}
                    .padding()
                    .background(.surfaceContrastColor)
                BPKChip("Selected", icon: .account, selected: true, style: .onImage) {}
                    .padding()
                    .background(.coreEcoColor)
            }.padding()
        )
    }
    
    func test_chipDropdown() {
        assertSnapshot(
            VStack {
                BPKDropdownChip("Options") {}
                BPKDropdownChip("Options", icon: .account) {}
                BPKDropdownChip("Selected", icon: .account, selected: true) {}
                BPKDropdownChip("Options", icon: .account, style: .onDark) {}
                    .padding()
                    .background(.surfaceContrastColor)
                BPKDropdownChip("Options", icon: .account, style: .onImage) {}
                    .padding()
                    .background(.coreEcoColor)
            }.padding()
        )
    }
    
    func test_chipDismissable() {
        assertSnapshot(
            VStack {
                BPKDismissableChip("Dismiss") {}
                BPKDismissableChip("Dismiss", icon: .account) {}
                BPKDismissableChip("Dismiss", icon: .account, style: .onDark) {}
                    .padding()
                    .background(.surfaceContrastColor)
                BPKDismissableChip("Dismiss", icon: .account, style: .onImage) {}
                    .padding()
                    .background(.coreEcoColor)
                
            }.padding()
        )
    }
}
