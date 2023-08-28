# Backpack/Carousel

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Classes/BPKCarousel.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Carousel)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_carousel___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_carousel___default_dm.png" alt="" width="375" /> |

## Usage

Example of a Carousel: 
```swift
@State var currentIndex: Int = 0

func image(_ name: String) -> Image {
    Image(name)
        .resizable()
        .aspectRatio(contentMode: .fill)
}

BPKCarousel(
    images: [image("Paris"), image("Barcelona"), image("London")],
    currentIndex: $currentIndex
)
```
