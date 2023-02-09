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
    
    private lazy var imageViewOne: UIImageView = {
        let image = UIImage(named: "dialog_flare")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var imageViewTwo: UIImageView = {
        let image = UIImage(named: "dialog_image")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var imageViewThree: UIImageView = {
        let image = UIImage(named: "pilanesburg-south-africa")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
        
    private lazy var onImageChanged: ((Int) -> Void)? = { [weak self] selectedRowIndex in
        self?.displayedIndexLabel.text = "\(selectedRowIndex)"
    }
    
    private lazy var carousel = BPKCarousel(
        images: [imageViewOne, imageViewTwo, imageViewThree],
        currentImage: 1,
        onImageChanged: onImageChanged
    )
    
    private lazy var descriptionLabel: UILabel = {
        let label = BPKLabel(fontStyle: .textCaption)
        label.textColor = BPKColor.textPrimaryColor
        label.text = "Currently selected index:"
        return label
    }()
    
    private lazy var displayedIndexLabel: UILabel = {
        let label = BPKLabel(fontStyle: .textCaption)
        label.textColor = BPKColor.textPrimaryColor
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.canvasColor
        setupConstraints()
    }
    
    private func setupConstraints() {
        [
        carousel,
        descriptionLabel,
        displayedIndexLabel
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate(
            [
                carousel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                carousel.heightAnchor.constraint(equalToConstant: 300),
                
                descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 20),
                
                displayedIndexLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                displayedIndexLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20)
            ]
        )
    }
}
