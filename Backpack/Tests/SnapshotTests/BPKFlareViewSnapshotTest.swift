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

final class BPKFlareViewSnapshotTest: XCTestCase {
    
    private lazy var innerView: UIView = {
        let view = UIView()
        view.backgroundColor = BPKColor.statusSuccessFillColor
        
        return view
    }()

    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testFlareViewBottomSnapshot() {
        // Given
        let sut = BPKFlareView()
        
        // When
        configure(flareView: sut, withInnerView: innerView)
        let snapshotView = embed(view: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testFlareViewTopSnapshot() {
        // Given
        let sut = BPKFlareView()
        sut.flarePosition = .top
        
        // When
        configure(flareView: sut, withInnerView: innerView)
        let snapshotView = embed(view: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testFlareViewBottomRoundedSnapshot() {
        // Given
        let sut = BPKFlareView()
        sut.cornerRadius = BPKCornerRadiusLg
        
        // When
        configure(flareView: sut, withInnerView: innerView)
        let snapshotView = embed(view: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }
    
    func testFlareViewTopRoundedSnapshot() {
        // Given
        let sut = BPKFlareView()
        sut.flarePosition = .top
        sut.cornerRadius = BPKCornerRadiusLg
        
        // When
        configure(flareView: sut, withInnerView: innerView)
        let snapshotView = embed(view: sut)
        
        // Then
        assertSnapshot(snapshotView)
    }

    // MARK: Helpers
    private func configure(flareView: BPKFlareView, withInnerView innerView: UIView) {
        [flareView, innerView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        flareView.backgroundColor = BPKColor.coreAccentColor
        flareView.contentView.addSubview(innerView)
        
        NSLayoutConstraint.activate([
            innerView.widthAnchor.constraint(equalToConstant: 150),
            innerView.heightAnchor.constraint(equalToConstant: 100),
            innerView.topAnchor.constraint(equalTo: flareView.contentView.topAnchor),
            innerView.leadingAnchor.constraint(equalTo: flareView.contentView.leadingAnchor),
            innerView.trailingAnchor.constraint(equalTo: flareView.contentView.trailingAnchor),
            innerView.bottomAnchor.constraint(equalTo: flareView.contentView.bottomAnchor)
        ])
    }
    
    private func embed(view: UIView) -> UIView {
        let parentView = UIView()
        parentView.backgroundColor = BPKColor.canvasColor
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        parentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: BPKSpacingBase),
            view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: BPKSpacingBase),
            view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -BPKSpacingBase),
            view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -BPKSpacingBase)
        ])
        
        return parentView
    }

}
