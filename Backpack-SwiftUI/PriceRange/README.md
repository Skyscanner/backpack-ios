# Backpack-SwiftUI/PriceRange

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKPrice.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Price)

## Examples

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_price-range___all_lm" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_price-range___all_dm" alt="" width="375" /> |
 
## Usage

### Default
```swift
import Backpack_SwiftUI

BPKPriceRange(configuration: .default(.init(
    min: 0, // default value: 0
    max: 100, // default value: 100
    marker: .init(text: "£850", percentage: 85),
    segments: .init(
        lower: .init(text: "£200", percentage: 20),
        upper: .init(text: "£800", percentage: 80)
    )
)))

```

### Collapsed

```swift
import Backpack_SwiftUI

BPKPriceRange(configuration: .collapsed(.init(
    min: 0, // default value: 0
    max: 100, // default value: 100
    markerPercentage: 90,
    segments: .init(
        lower: 20,
        upper: 80
    )
)))
```
