# Backpack/CardCarousel

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Classes/BPKCardCarousel.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/CardCarousel)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-card-carousel__default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-card-carousel__default_dm.png" alt="" width="375" /> |

## Usage

Example of a CarouselCard: 
```swift
BPKCardCarousel(
    cards: [
        BPKCarouselCard(
            content: {
                AnyView(
                    Rectangle()
                        .foregroundColor(BPKColor.skyBlue)
                )
            },
            title: "Test Title",
            description: "Test description",
            contentAccessibilityLabel: "Blue rectangle"
        ),
        BPKCarouselCard(
            content: {
                AnyView(
                    Rectangle()
                        .foregroundColor(BPKColor.skyBlue)
                )
            },
            title: "Test Title",
            description: "Test description",
            contentAccessibilityLabel: "Blue rectangle"
        ),
        BPKCarouselCard(
            content: {
                AnyView(
                    Rectangle()
                        .foregroundColor(BPKColor.skyBlue)
                )
            },
            title: "Test Title",
            description: "Test description",
            contentAccessibilityLabel: "Blue rectangle"
        )
    ],
    curentIndex: .constant(0),
    onCardChange: { }
)
```
