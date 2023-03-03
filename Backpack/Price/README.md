# Backpack/Carousel

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKPrice.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Price)

## Default
| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-Price___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-Price___default_dm.png" alt="" width="375" /> |

## Usage
 
```swift
import Backpack

let price = BPKPrice(
    price: "£1830",
    leadingText: "App only deal",
    previousPrice: "£2033",
    trailingText: "per day",
    alignment: .leading,
    size: .small
)

view.addSubview(price)

NSLayoutConstraint.activate([
    price.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    price.centerXAnchor.constraint(equalTo: view.centerXAnchor)
])
```