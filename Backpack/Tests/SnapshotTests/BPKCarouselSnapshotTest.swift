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

class BPKCarouselSnapshotTest: XCTestCase {
    
    private let imageNames = ["dialog_flare", "dialog_image", "pilanesburg-south-africa"]
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    func testViewSnapshotWithOneImage() {
        let imageViews = createImageViews(count: 1)
        let exampleView = createView(with: imageViews)
        assertSnapshot(exampleView)
    }
    
    func testViewSnapshotWithTwoImages() {
        let imageViews = createImageViews(count: 2)
        let exampleView = createView(with: imageViews)
        assertSnapshot(exampleView)
    }

    func testViewSnapshotWithThreeImages() {
        let imageViews = createImageViews(count: 3)
        let exampleView = createView(with: imageViews)
        assertSnapshot(exampleView)
    }

    func testViewSnapshotWithSecondSelected() {
        let imageViews = createImageViews(count: 3)
        let exampleView = createView(with: imageViews, currentImage: 1)
        assertSnapshot(exampleView)
    }

    func testViewSnapshotWithThirdSelected() {
        let imageViews = createImageViews(count: 3)
        let exampleView = createView(with: imageViews, currentImage: 2)
        assertSnapshot(exampleView)
    }
}

// MARK: Helpers
extension BPKCarouselSnapshotTest {
    private func createImageViews(count: Int) -> [UIImageView] {
        var imageViews = [UIImageView]()
        for index in 0..<count {
            let image = image(named: imageNames[index])
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageViews.append(imageView)
        }
        return imageViews
    }
    
    private func createView(with images: [UIView], currentImage: Int = 0) -> UIView {
        let parentView = UIView(frame: .zero)
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        let carousel = BPKCarousel()
        carousel.set(images: images)
        carousel.setCurrentImage(index: currentImage)
        parentView.addSubview(carousel)
        carousel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            parentView.heightAnchor.constraint(equalToConstant: 250),
            parentView.widthAnchor.constraint(equalToConstant: 300),
            
            carousel.topAnchor.constraint(equalTo: parentView.topAnchor),
            carousel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            carousel.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
        return parentView
    }
    
    private func image(named: String) -> UIImage? {
        guard let bundlePath = Bundle(for: Self.self).path(forResource: "SnapshotTestImages", ofType: "bundle") else {
            XCTFail("Could not locate resource")
            return nil
        }
        
        let bundle = Bundle(path: bundlePath)
        
        guard let image = UIImage(named: named, in: bundle, compatibleWith: nil) else {
            XCTFail("Could not locate resource")
            return nil
        }
        return image
    }
}
