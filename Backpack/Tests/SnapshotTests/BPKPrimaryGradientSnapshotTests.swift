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

final class BPKPrimaryGradientSnapshotTests: XCTestCase {

    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testPrimaryGradient() {
        // Given
        let sut = BPKPrimaryGradientView()
        
        // When
        sut.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sut.widthAnchor.constraint(equalToConstant: 150),
            sut.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Then
        assertSnapshot(sut)
    }
    
    func testPrimaryGradientWithCustomGradient() {
        // Given
        
        let startColor = BPKColor.statusSuccessFillColor
        let endColor = BPKColor.statusWarningFillColor
        
        let startPoint = BPKGradient.startPoint(for: .bottomRight)
        let endPoint = BPKGradient.endPointFor(for: .bottomRight)
        
        let sut = BPKPrimaryGradientView()
        
        // When
        sut.gradient = BPKGradient(
            colors: [
                startColor,
                endColor
            ],
            start: startPoint,
            end: endPoint
        )
        
        sut.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sut.widthAnchor.constraint(equalToConstant: 150),
            sut.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Then
        assertSnapshot(sut)
    }
    
    func testPrimaryGradientWithDirectionOverride() {
        // Given
        let sut = BPKPrimaryGradientView()
        sut.directionOverride = NSNumber(value: BPKGradientDirection.left.rawValue)
        
        // When
        sut.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sut.widthAnchor.constraint(equalToConstant: 150),
            sut.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Then
        assertSnapshot(sut)
    }

}
