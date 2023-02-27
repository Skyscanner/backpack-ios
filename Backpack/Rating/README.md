# Backpack/Rating

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKRating.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Rating)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___with-title-text_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___with-title-text_dm.png" alt="" width="375" /> |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___with-custom-title-view_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___with-custom-title-view_dm.png" alt="" width="375" /> |


## Usage

The BPKRating component supports two different sizes, as defined by the `BPKRatingSize` enum. 
It also includes two rating scales, defined in `BPKRatingScale`. 
An optional subtitle is available, which will be hidden if it is set to nil. 
The visibility of the rating scale (either /5 or /10) is controlled by the `showScale` property. 
If a titleView is provided, the title string will be ignored.


BPKRating
```swift
import Backpack
let ratingWithTitle = BPKRating(
    accessibilityLabel: "",
    title: "Excellent",
    value: 4.5,
)

let starRating = BPKStarRating()
starRating.rating = 4.5
let ratingWithCustomView = BPKRating(
    accessibilityLabel: "",
    value: 4.5,
    titleView: starRating
)

let ratingWithAllPossibleArguments = BPKRating(
    accessibilityLabel: "",
    title: "Excellent",
    value: 4.5,
    ratingScale: .zeroToTen,
    size: .large,
    subtitle: "1,532 reviews",
    showScale: false,
)

```