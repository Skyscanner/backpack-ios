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
import Backpack
import SnapshotTesting

final class BPKMapSnapshotTest: XCTestCase {

    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testMapView() {
        // Given
        let sut = BPKMapView()
        sut.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sut.widthAnchor.constraint(equalToConstant: 100),
            sut.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        assertSnapshot(sut)
    }
}
