# Backpack/CarouselCard

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Classes/BPKCarouselCard.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/CarouselCard)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-carousel-card__default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-carousel-card__default_dm.png" alt="" width="375" /> |

## Usage

Example of a CarouselCard: 
```swift
BPKCarouselCard(
    content: {
        Image("paris")
            .resizable()
    },
    title: "Card Title",
    desctiption: "Card Description",
    imageAccessibilityLabel: "Card image accessibility label"
)
```
