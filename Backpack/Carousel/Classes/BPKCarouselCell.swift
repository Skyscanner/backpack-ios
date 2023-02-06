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

import Foundation

enum TapDirection {
    case previous
    case next
}

final class BPKCarouselCell: UICollectionViewCell {
    
    private var imageChangeTapped: ((TapDirection) -> Void)?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var displayPreviousImageButton: UIControl = {
        let button = UIControl()
        button.addTarget(self, action: #selector(tappedDisplayPreviousImage), for: .touchUpInside)
        return button
    }()
    
    private lazy var displayNextImageButton: UIControl = {
        let button = UIControl()
        button.addTarget(self, action: #selector(tappedDisplayNextImage), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [
            imageView,
            displayPreviousImageButton,
            displayNextImageButton
        ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                displayPreviousImageButton.topAnchor.constraint(equalTo: contentView.topAnchor),
                displayPreviousImageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                displayPreviousImageButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
                displayPreviousImageButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                displayNextImageButton.topAnchor.constraint(equalTo: contentView.topAnchor),
                displayNextImageButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
                displayNextImageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                displayNextImageButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(with viewModel: CarouselViewModel) {
        imageView.image = viewModel.image
        imageChangeTapped = viewModel.imageChangeTapped
    }
    
    @objc
    private func tappedDisplayNextImage() {
        imageChangeTapped?(.next)
    }
    
    @objc
    private func tappedDisplayPreviousImage() {
        imageChangeTapped?(.previous)
    }
}
