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

final class BPKBarChartBarSnapshotTest: XCTestCase {
    
    var sut: BPKBarChartBar!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        sut = BPKBarChartBar()
        sut.title = "Fri"
        sut.subtitle = "4"
        
        sut.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sut.widthAnchor.constraint(equalToConstant: 60),
            sut.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    override func tearDownWithError() throws {
        sut = nil
        try? super.tearDownWithError()
    }

    func testBarDefault() {
        assertSnapshot(sut)
    }
    
    func testBarDefaultWithValue() {
        // Given
        sut.fillValue = 0.7
        
        // Then
        assertSnapshot(sut)
    }
    
    func testBarSelected() {
        // Given
        sut.isSelected = true
        
        // Then
        assertSnapshot(sut)
    }
    
    func testBarDefaultWithValueSelected() {
        // Given
        sut.fillValue = 0.7
        sut.isSelected = true
        
        // Then
        assertSnapshot(sut)
    }
    
    func testBarDefaultWithValueDescription() {
        // Given
        sut.fillValue = 0.7
        sut.valueDescription = "£200"
        
        // Then
        assertSnapshot(sut)
    }
    
    func testBarDefaultWithValueRealSelected() {
        // Given
        sut.fillValue = 0.7
        sut.valueDescription = "£200"
        sut.isSelected = true
        
        // Then
        assertSnapshot(sut)
    }
}
