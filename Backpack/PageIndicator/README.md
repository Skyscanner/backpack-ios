# Backpack/PageIndicator

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKPageIndicator.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/PageIndicator)

## Default
| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-page indicator___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-page indicator___default_dm.png" alt="" width="375" /> |

## Usage
 
```swift
import Backpack

let pageIndicator = BPKPageIndicator(
    variant: .overImage,
    currentIndex: 0,
    totalIndicators: 3
)

pageIndicator.translatesAutoresizingMaskIntoConstraints = false

view.addSubview(pageIndicator)

NSLayoutConstraint.activate([
    pageIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    pageIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
])

// Updating the indicator
pageIndicator.currentIndex = 2
pageIndicator.totalIndicators = 7
```