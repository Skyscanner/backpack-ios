# Backpack/Chip

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Classes/BPKChip.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Chip)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip___default_dm.png" alt="" width="375" /> |

## On dark

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip___on-dark_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip___on-dark_dm.png" alt="" width="375" /> |

## On Image

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip___on-image_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_chip___on-image_dm.png" alt="" width="375" /> |

## Usage

Example of a Chip: 
```swift
BPKChip("Chip text")
```

Example of a Chip with an action closure:
```swift
BPKChip("Chip text") {
    print("Chip tapped")
}
```

Example of a selected Chip:
```swift
BPKChip("Chip text", selected: true)
```

Example of a disabled Chip:
```swift
BPKChip("Chip text")
    .disabled(true)
```

Example of a Chip with leading icon:
```swift
BPKChip("Chip text", icon: .deals)
```

Example of a Chip on dark background:
```swift
BPKChip("Chip text", style: .onDark)
```

Example of a Chip on an image background:
```swift
BPKChip("Chip text", style: .onImage)
```

Example of a Dropdown Chip:
```swift
BPKDropdownChip("Chip text")
```

Example of a Dismissable Chip:
```swift
BPKDismissableChip("Chip text")
```