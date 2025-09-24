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

class BPKOverlaySnapshotTest: XCTestCase {
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testSolidOverlays() {
        assertSnapshot(createTestViews(types: [.solidLow, .solidMedium, .solidHigh]))
    }
    
    func testTopOverlays() {
        assertSnapshot(createTestViews(types: [.topLow, .topMedium, .topHigh]))
    }
    
    func testBottomOverlays() {
        assertSnapshot(createTestViews(types: [.bottomLow, .bottomMedium, .bottomHigh]))
    }
    
    func testLeftOverlays() {
        assertSnapshot(createTestViews(types: [.leftLow, .leftMedium, .leftHigh]))
    }
    
    func testRightOverlays() {
        assertSnapshot(createTestViews(types: [.rightLow, .rightMedium, .rightHigh]))
    }
    
    func testVignetteOverlay() {
        assertSnapshot(createTestViews(types: [.vignette]))
    }
    
    // MARK: Helpers
    func createTestViews(types: [BPKOverlayType]) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = BPKSpacingMd
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for type in types {
            let content = createBackgroundView()
            
            let overlay = BPKOverlay(content: content, overlayType: type)
            
            NSLayoutConstraint.activate([
                overlay.widthAnchor.constraint(equalToConstant: 200),
                overlay.heightAnchor.constraint(equalToConstant: 150)
            ])
            
            stackView.addArrangedSubview(overlay)
        }
        
        for type in types {
            let content = createBackgroundView()
            let foregroundContent = createForegroundView()
            
            let overlay = BPKOverlay(content: content, overlayType: type, foregroundContent: foregroundContent)
            
            NSLayoutConstraint.activate([
                overlay.widthAnchor.constraint(equalToConstant: 200),
                overlay.heightAnchor.constraint(equalToConstant: 150),
                foregroundContent.topAnchor.constraint(equalTo: overlay.topAnchor),
                foregroundContent.bottomAnchor.constraint(equalTo: overlay.bottomAnchor),
                foregroundContent.leadingAnchor.constraint(equalTo: overlay.leadingAnchor),
                foregroundContent.trailingAnchor.constraint(equalTo: overlay.trailingAnchor)
            ])
            
            stackView.addArrangedSubview(overlay)
        }
        
        return stackView
    }
    
    func createBackgroundView() -> UIView {
        let view = UIImageView(image: image(named: "pilanesburg-south-africa"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
                
        return view
    }
    
    func createForegroundView() -> UIView {
        let label = BPKLabel()
        label.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = BPKColor.textOnDarkColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func image(named: String) -> UIImage? {
        #if SWIFT_PACKAGE
        let bundle: Bundle? = .module
        #else
        guard let bundlePath = Bundle(for: Self.self).path(forResource: "SnapshotTestImages", ofType: "bundle") else {
            print("Could not locate resource")
            return nil
        }

        let bundle = Bundle(path: bundlePath)
        #endif
        return UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
