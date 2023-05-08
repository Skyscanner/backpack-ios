# Backpack-SwiftUI/StarRating

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKStarRating.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/StarRating)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_star-rating___all_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_star-rating___all_dm.png" alt="" width="375" /> |

## Usage

To use the star rating component in your code you will need to bind the `rating` property and set the `maxRating` property. The `maxRating` is the maximum number of stars that can be displayed.

### Basic star rating

```swift
@State var rating: Float = 3.5
BPKStarRating(rating: $rating, maxRating: 5)
```

### Interactive star rating

```swift
@State var rating: Float = 3.5
BPKStarRating(rating: $rating, maxRating: 5) { selectedRating in
    rating = selectedRating
}
```

### Hotel star rating

```swift
@State var hotelRating: Int = 3
BPKHotelStarRating(rating: $hotelRating)
```

### Star rating with Large size

```swift
@State var rating: Float = 3.5
BPKStarRating(rating: $rating, maxRating: 5, size: .large)
```

### Customise Rating Rounding

Rounding can be customised by setting the `rounding` property. The default is `.down`.

```swift
@State var rating: Float = 3.5
BPKStarRating(rating: $rating, maxRating: 5, rounding: .down)
```