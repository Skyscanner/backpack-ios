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
import SnapshotTesting

@testable import Backpack

class BPKBottomSheetTest: XCTestCase {
    
    var sut: BottomSheetTestViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = BottomSheetTestViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_moveBottomSheet_toHalf() {
        // Given
        sut.viewDidLoad()
        
        // When
        sut.moveBottomSheet(toState: .half, animated: false)
        
        // Then
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_moveBottomSheet_toTip() {
        // Given
        sut.viewDidLoad()
        
        // When
        sut.moveBottomSheet(toState: .tip, animated: false)
        
        // Then
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_moveBottomSheet_toFull() {
        // Given
        sut.viewDidLoad()
        
        // When
        sut.moveBottomSheet(toState: .full, animated: false)
        
        // Then
        assertSnapshot(matching: sut, as: .image)
    }
}
