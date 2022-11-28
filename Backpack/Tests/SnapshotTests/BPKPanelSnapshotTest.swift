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

class BPKPanelSnapshotTest: XCTestCase {
    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testViewSnapshotElevatedWithoutPadded() {
        // Given
        let parentView = UIView()
        let innerView = UIView()
        innerView.backgroundColor = BPKColor.statusSuccessFillColor
        
        let sut = BPKPanel(padded: false)
        sut.style = .elevated
        
        // When
        configure(panel: sut, withInnerView: innerView)
        configure(parentView: parentView, forPanel: sut)
        
        // Then
        assertSnapshot(parentView)
    }
    
    func testViewSnapshotElevated() {
        // Given
        let parentView = UIView()
        let innerView = UIView()
        innerView.backgroundColor = BPKColor.statusSuccessFillColor
        
        let sut = BPKPanel(padded: true)
        sut.style = .elevated
        
        // When
        configure(panel: sut, withInnerView: innerView)
        configure(parentView: parentView, forPanel: sut)
        
        // Then
        assertSnapshot(parentView)
    }
    
    func testViewSnapshotWithoutPadded() {
        // Given
        let parentView = UIView()
        let innerView = UIView()
        innerView.backgroundColor = BPKColor.statusSuccessFillColor
        
        let sut = BPKPanel(padded: false)
        
        // When
        configure(panel: sut, withInnerView: innerView)
        configure(parentView: parentView, forPanel: sut)
        
        // Then
        assertSnapshot(parentView)
    }
    
    func testViewSnapshotWithPadded() {
        // Given
        let parentView = UIView()
        let innerView = UIView()
        innerView.backgroundColor = BPKColor.statusSuccessFillColor
        
        let sut = BPKPanel(padded: true)
        
        // When
        configure(panel: sut, withInnerView: innerView)
        configure(parentView: parentView, forPanel: sut)
        
        // Then
        assertSnapshot(parentView)
    }
    
    // MARK: Helpers
    private func configure(parentView: UIView, forPanel panel: BPKPanel) {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.backgroundColor = BPKColor.canvasColor
        parentView.addSubview(panel)
        
        NSLayoutConstraint.activate([
            panel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: BPKSpacingBase),
            panel.topAnchor.constraint(equalTo: parentView.topAnchor, constant: BPKSpacingBase),
            panel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -BPKSpacingBase),
            panel.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -BPKSpacingBase)
        ])
    }
    
    private func configure(panel: BPKPanel, withInnerView innerView: UIView) {
        panel.translatesAutoresizingMaskIntoConstraints = false
        innerView.translatesAutoresizingMaskIntoConstraints = false
        panel.addSubview(innerView)
        
        NSLayoutConstraint.activate([
            innerView.widthAnchor.constraint(equalToConstant: 90),
            innerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
