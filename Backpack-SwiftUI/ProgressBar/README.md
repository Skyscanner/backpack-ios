#  Backpack-SwiftUI/ProgressBar

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKProgressBar.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/ProgressBar)

## Default
| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_progress-bar___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_progress-bar___default_dm.png" alt="" width="375" /> |

## Usage

### Small Progress Bar

```swift
BPKProgressBar(max: 3, stepped: false, size: .small, value: 1.5)
```

### Small Stepped Progress Bar

```swift
BPKProgressBar(max: 3, stepped: true, size: .small, value: 1.5)
```

### Large Progress Bar

```swift
BPKProgressBar(max: 3, stepped: false, size: .large, value: 1.5)
```

### Large Stepped Progress Bar

```swift
BPKProgressBar(max: 3, stepped: true, size: .large, value: 1.5)
```
