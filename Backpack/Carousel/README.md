# Backpack/Carousel

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKCarousel.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Carousel)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-carousel___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-carousel___default_dm.png" alt="" width="375" /> 

## Usage

BPKCarousel displays a collection of views in a horizontal scrollable list. It is designed to be used with `UIImageView` "cells".

```swift
let carousel = BPKCarousel()
carousel.set(images: [
    UIImageView(image: UIImage(named: "image1")),
    UIImageView(image: UIImage(named: "image2"))
])
```

To get notified when the user scrolls to a new page, set the `delegate` property.

```swift
let carousel = BPKCarousel()
carousel.delegate = MyCarouselDelegate()

class MyCarouselDelegate: BPKCarouselDelegate {
    func onImageChange(index: Int) {
        print("User scrolled to page \(index)")
    }
}
```
