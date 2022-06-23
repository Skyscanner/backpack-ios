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
import FBSnapshotTestCase
import Backpack

class BPKChipSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    private func create(
        title: String = "Test",
        icon: BPKSmallIconName? = nil,
        enrich: (BPKChip) -> Void = { _ in }
    ) -> BPKChip {
        let chip = BPKChip(title: title, icon: icon)
        chip.style = .default
        chip.translatesAutoresizingMaskIntoConstraints = false
        enrich(chip)
        return chip
    }
    
    func testChipUnselected() {
        BPKSnapshotVerifyViewLight(create())
        BPKSnapshotVerifyViewDark(create())
    }
    
    func testChipSelected() {
        func enrich(_ chip: BPKChip) {
            chip.isSelected = true
        }
        BPKSnapshotVerifyViewLight(create(enrich: enrich))
        BPKSnapshotVerifyViewDark(create(enrich: enrich))
    }
    
    func testChipWithSelectType() {
        func enrich(_ chip: BPKChip) {
            chip.type = .select
        }
        BPKSnapshotVerifyViewLight(create(enrich: enrich))
        BPKSnapshotVerifyViewDark(create(enrich: enrich))
    }
    
    func testChipWithDismissType() {
        func enrich(_ chip: BPKChip) {
            chip.type = .dismiss
        }
        BPKSnapshotVerifyViewLight(create(enrich: enrich))
        BPKSnapshotVerifyViewDark(create(enrich: enrich))
    }
    
    func testChipDisabled() {
        func enrich(_ chip: BPKChip) {
            chip.isEnabled = false
        }
        BPKSnapshotVerifyViewLight(create(enrich: enrich))
        BPKSnapshotVerifyViewDark(create(enrich: enrich))
    }
    
    func testChipWithIcon() {
        BPKSnapshotVerifyViewLight(create(icon: .map))
        BPKSnapshotVerifyViewDark(create(icon: .map))
    }
    
    func testChipSelectedWithIcon() {
        func enrich(_ chip: BPKChip) {
            chip.isSelected = true
        }
        BPKSnapshotVerifyViewLight(create(icon: .map))
        BPKSnapshotVerifyViewDark(create(icon: .map))
    }
}
