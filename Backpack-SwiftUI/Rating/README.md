# Rating

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKRating.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Rating)

## Using Title String

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_rating___with-title-text_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_rating___with-title-text_dm.png" alt="" width="375" /> |

## Using Title View

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_rating___with-custom-title-view-image_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_rating___with-custom-title-view-image_dm.png" alt="" width="375" /> |

## Usage

### Rating with a title string

```swift
BPKRating(
    accessibilityLabel: "Rated Excellent, 4.5 out of 5. Base on 1,532 reviews",
    title: "Excellent",
    value: 4.5,
    ratingScale: .zeroToFive,
    size: .default,
    subtitle: "1,532 reviews",
    showScale: true
)
```

### with default parameters

```swift 
BPKRating(
    accessibilityLabel: "Rated Excellent, 4.5 out of 5.",
    title: "Excellent",
    value: 4.5
)
```

### Rating with a custom title view


```swift
BPKRating(
    accessibilityLabel: "4.5 out of 5. Base on 1,532 reviews",
    value: 4.5,
    ratingScale: .zeroToFive,
    size: .default,
    subtitle: "1,532 reviews",
    showScale: true
) {
    AnyView(
        Image("backpack-logo-horizontal")
            .resizable()
            .frame(width: 110, height: 24)
            .aspectRatio(contentMode: .fit)
    )
}
```

