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
        CarouselViewController.createImageView(with: "dialog_flare"),
        CarouselViewController.createImageView(with: "dialog_image"),
        CarouselViewController.createImageView(with: "pilanesburg-south-africa")
    ]
    
    private let carousel: BPKCarousel = {
        let carousel = BPKCarousel()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    
    private let descriptionLabel: UILabel = {
        let label = BPKLabel(fontStyle: .textCaption)
        label.textColor = BPKColor.textPrimaryColor
        label.text = "Currently selected index:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let displayedIndexLabel: UILabel = {
        let label = BPKLabel(fontStyle: .textCaption)
        label.textColor = BPKColor.textPrimaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.canvasColor
        setupConstraints()
        carousel.delegate = self
        carousel.set(images: images)
    }
    
    private func setupConstraints() {
        [carousel, descriptionLabel, displayedIndexLabel]
            .forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            carousel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            carousel.heightAnchor.constraint(equalToConstant: 300),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 20),
            
            displayedIndexLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayedIndexLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20)
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
        displayedIndexLabel.text = "\(index)"
    }
}
