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

final class BPKGradientSnapshotTests: XCTestCase {

    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testPrimaryGradient() {
        // Given
        let sut = BPKGradientView(gradient: BPKGradient.primary())
        sut.translatesAutoresizingMaskIntoConstraints = false
        
        // When
        NSLayoutConstraint.activate([
            sut.widthAnchor.constraint(equalToConstant: 100),
            sut.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Then
        assertSnapshot(sut)
    }
    
    func testBaselineScrimGradient() {
        // Given
        let container = UIView()
        container.backgroundColor = BPKColor.white
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let sut = BPKGradientView(gradient: BPKGradient.baselineScrim())
        sut.translatesAutoresizingMaskIntoConstraints = false
        sut.isOpaque = false
        
        container.addSubview(sut)
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 100),
            container.heightAnchor.constraint(equalToConstant: 200),
            
            sut.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            sut.topAnchor.constraint(equalTo: container.topAnchor),
            sut.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            sut.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        container.layoutIfNeeded()
        
        assertSnapshot(container)
    }
}
