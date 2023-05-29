//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

import UIKit
import Backpack

final class CarouselViewController: UIViewController {
    
    private let images = [
        CarouselViewController.createImageView(with: "carousel_placeholder_1"),
        CarouselViewController.createImageView(with: "carousel_placeholder_2"),
        CarouselViewController.createImageView(with: "carousel_placeholder_3"),
        CarouselViewController.createImageView(with: "carousel_placeholder_4")
    ]
    
    private let carousel: BPKCarousel = {
        let carousel = BPKCarousel()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.canvasColor
        setupConstraints()
        carousel.delegate = self
        carousel.set(images: images)
    }
    
    private func setupConstraints() {
        view.addSubview(carousel)
        
        NSLayoutConstraint.activate([
            carousel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BPKSpacingBase),
            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -BPKSpacingBase),
            carousel.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private static func createImageView(with imageName: String) -> UIImageView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}

extension CarouselViewController: BPKCarouselDelegate {
    func onImageChange(index: Int) {
        print("New index: \(index)")
    }
}
