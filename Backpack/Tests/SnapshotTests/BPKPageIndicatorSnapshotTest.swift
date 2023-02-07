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

class BPKPageIndicatorSnapshotTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    private func createView(for variant: BPKPageIndicator.Variant, currentIndex: Int, totalIndicators: Int) -> UIView {
        let parentView = UIView(frame: .zero)
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        let pageIndicator: BPKPageIndicator
        switch variant {
        case .`default`:
            pageIndicator = BPKPageIndicator(
                currentIndex: currentIndex,
                totalIndicators: totalIndicators
            )
            
            parentView.backgroundColor = .systemBackground
        case .overImage:
            pageIndicator = BPKPageIndicator(
                variant: .overImage,
                currentIndex: currentIndex,
                totalIndicators: totalIndicators
            )
            
            parentView.backgroundColor = .bpk_corePrimary
        }
        
        pageIndicator.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(pageIndicator)
        
        NSLayoutConstraint.activate([
            pageIndicator.topAnchor.constraint(equalTo: parentView.topAnchor),
            pageIndicator.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            pageIndicator.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            pageIndicator.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
        
        return parentView
    }
        
    func testViewSnapshotWithDefault() {
        let exampleView = createView(for: .default, currentIndex: 0, totalIndicators: 3)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotDarkBackground() {
        let exampleView = createView(for: .overImage, currentIndex: 0, totalIndicators: 3)
        assertSnapshot(exampleView)
    }
}
