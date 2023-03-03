# Backpack/Carousel

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKCarousel.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Carousel)

## Default
| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-carousel___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-carousel___default_dm.png" alt="" width="375" /> |

## Usage
 
```swift
import Backpack

final class CarouselExampleViewController: UIViewController {
    
    private let imagesNames = [
        "example_image",
        "example_image_two"
    ]
    
    private let carousel: BPKCarousel = {
        let carousel = BPKCarousel()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        carousel.delegate = self
        carousel.set(images: imagesNames.map { createImageView(with: $0) })
    }
    
    private func setupConstraints() {
        view.addSubview(carousel)
        
        NSLayoutConstraint.activate([
            carousel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            carousel.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func createImageView(with imageName: String) -> UIImageView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}

extension CarouselExampleViewController: BPKCarouselDelegate {
    func onImageChange(index: Int) {
        /* Handle image change */
    }
}

```