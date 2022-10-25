/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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
import Backpack

import SnapshotTesting

class BPKSwitchSnapshotTest: XCTestCase {
    
    let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        isRecording = false
    }

    private func makeSwitch(withPrimaryColor color: UIColor? = nil, state: Bool = false) -> BPKSwitch {
        let bpkSwitch = BPKSwitch()
        if let color = color {
            bpkSwitch.primaryColor = color
        }
        bpkSwitch.setOn(state, animated: false)
        return bpkSwitch
    }
    
    func testSwitchWhenOff() {
        assertSnapshot(makeSwitch())
    }
    
    func testSwitchWhenOn() {
        assertSnapshot(makeSwitch(state: true))
    }
    
    func testSwitchWhenOnWithTheme() {
        assertSnapshot(makeSwitch(withPrimaryColor: .orange, state: true))
    }
}
