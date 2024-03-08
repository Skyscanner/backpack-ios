#  Backpack-SwiftUI/RatingBar

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKRatingBar.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/RatingBar)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_rating-bar___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_rating-bar___default_dm.png" alt="" width="375" /> |

## Usage

### Default
    
```swift
BPKRatingBar(
    label: "Rating",
    value: 4.5,
    accessibilityLabel: "Rating of 4.5"
)
```

### Customising the Scale

You can customise the scale of the rating bar by setting the `ratingStyle` property. The available styles are:

- `zeroToFive` (default)
- `zeroToTen`

### Zero to Ten

```swift
BPKRatingBar(
    label: "Rating",
    value: 8,
    accessibilityLabel: "Rating of 8",
    ratingScale: .zeroToTen
)
```

### Customising the Style

You can customise the style of the rating bar by setting the `style` property. The available styles are:

- `default` (default)
- `onContrast`

### On Contrast

```swift
BPKRatingBar(
    label: "Rating",
    value: 4.5,
    accessibilityLabel: "Rating of 4.5",
    style: .onContrast
)
```