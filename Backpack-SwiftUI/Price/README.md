# Backpack-SwiftUI/Price

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKPrice.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Price)

## Small

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_price___small_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_price___small_dm.png" alt="" width="375" /> |
 

 ## Large

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_price___large_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_price___large_dm.png" alt="" width="375" /> |

## Usage

```swift
import Backpack_SwiftUI

BPKPrice(
    price: "£1830",
    leadingText: "App only deal",
    previousPrice: "£2033",
    trailingText: "per day",
    onPriceClicked: {
        // Respond to taps on the price label
    },
    alignment: .leading,
    size: size
)

BPKPrice(
    price: "£1830",
    onPriceClicked: {
        // Respond to taps on the price label
    },
    icon: (.priceAlertAdd, "Create price alert"),
    alignment: .leading,
    size: .small
)
```

Providing an `onPriceClicked` handler converts the price text into a tappable link using the specified `linkStyle` (defaults to `.default`).
