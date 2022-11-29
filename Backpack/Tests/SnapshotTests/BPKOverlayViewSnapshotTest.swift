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

class BPKOverlayViewSnapshotTest: XCTestCase {
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testOverlayViewsWithBackground() {
        assertSnapshot(createTestViews(hasBackground: true, hasForeGround: false))
    }
    
    func testOverlayViewsWithForeground() {
        assertSnapshot(createTestViews(hasBackground: false, hasForeGround: true))
    }
    
    func testOverlayViewsWithBackgroundAndForeground() {
        assertSnapshot(createTestViews(hasBackground: true, hasForeGround: true))
    }
    
    // MARK: Helpers
    func createTestViews(hasBackground: Bool, hasForeGround: Bool) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = BPKSpacingMd
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let overlayViews = [
            BPKOverlayView(overlayType: .none, cornerStyle: .none),
            BPKOverlayView(overlayType: .tint, cornerStyle: .none),
            BPKOverlayView(overlayType: .tint, cornerStyle: .small),
            BPKOverlayView(overlayType: .tint, cornerStyle: .large),
        ]
        
        overlayViews.forEach { overlay in
            guard let overlay = overlay else {
                return
            }
            
            if hasBackground {
                let backgroundContent = createBackgroundView()
                stackView.addArrangedSubview(backgroundContent)
                overlay.backgroundView.addSubview(backgroundContent)
                
                NSLayoutConstraint.activate([
                    backgroundContent.topAnchor.constraint(equalTo: overlay.backgroundView.topAnchor),
                    backgroundContent.leadingAnchor.constraint(equalTo: overlay.backgroundView.leadingAnchor),
                    backgroundContent.trailingAnchor.constraint(equalTo: overlay.backgroundView.trailingAnchor),
                    backgroundContent.bottomAnchor.constraint(equalTo: overlay.backgroundView.bottomAnchor)
                ])
                
                // This is a hack used to reorder the layers before they are captured by the snapshot library.
                // This is necessary due to an issue with how UIGraphicsImageRenderer orders layers.
                // See
                // https://stackoverflow.com/questions/62172205/saving-a-uiview-as-an-image-causes-zpositioning-of-its-subviews-to-fail
                let tintLayer = overlay.backgroundView.layer.sublayers?.first
                overlay.backgroundView.layer.sublayers?[0].removeFromSuperlayer()
                overlay.backgroundView.layer.insertSublayer(tintLayer!, at: 1)
            }
            
            if hasForeGround {
                let foregroundContent = createForegroundView()
                overlay.foregroundView.addSubview(foregroundContent)
                
                NSLayoutConstraint.activate([
                    foregroundContent.widthAnchor.constraint(equalTo: overlay.foregroundView.widthAnchor, constant: -BPKSpacingLg),
                    foregroundContent.centerXAnchor.constraint(equalTo: overlay.foregroundView.centerXAnchor),
                    foregroundContent.centerYAnchor.constraint(equalTo: overlay.foregroundView.centerYAnchor),
                    overlay.foregroundView.heightAnchor.constraint(equalToConstant: 100),
                    overlay.foregroundView.widthAnchor.constraint(equalToConstant: 100)
                ])
            }
            
            stackView.addArrangedSubview(overlay)
        }
        
        return stackView
    }
    
    func createBackgroundView() -> UIView {
        let view = UIImageView(image: image(named: "pilanesburg-south-africa"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 200),
            view.heightAnchor.constraint(equalToConstant: 150)
        ])
        
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
        guard let bundlePath = Bundle(for: Self.self).path(forResource: "SnapshotTestImages", ofType: "bundle") else {
            print("Could not locate resource")
            return nil
        }
        
        let bundle = Bundle(path: bundlePath)
        return UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
