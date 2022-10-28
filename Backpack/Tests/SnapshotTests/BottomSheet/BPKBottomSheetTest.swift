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
        isRecording = false
        sut = BottomSheetTestViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    private func constraintSut(toWidth width: CGFloat, height: CGFloat) {
        sut.view.translatesAutoresizingMaskIntoConstraints = false
        sut.view.widthAnchor.constraint(equalToConstant: width).isActive = true
        sut.view.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func test_moveBottomSheet_toHalf() {
        // Given
        sut.viewDidLoad()
        constraintSut(toWidth: 300, height: 400)
        
        // When
        sut.moveBottomSheet(toState: .half)
        
        // Then
        assertSnapshot(sut.view)
    }
    
    func test_moveBottomSheet_toTip() {
        // Given
        sut.viewDidLoad()
        constraintSut(toWidth: 300, height: 150)
        
        // When
        sut.moveBottomSheet(toState: .tip)
        
        // Then
        assertSnapshot(sut.view)
    }
    
    func test_moveBottomSheet_toFull() {
        // Given
        sut.viewDidLoad()
        constraintSut(toWidth: 300, height: 700)
        
        // When
        sut.moveBottomSheet(toState: .full)
        
        // Then
        assertSnapshot(sut.view)
    }
}
