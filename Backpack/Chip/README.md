# Backpack/Chip

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKChip.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Chip)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-chip___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-chip___default_dm.png" alt="" width="375" /> |

## On dark

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-chip___on-dark_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-chip___on-dark_dm.png" alt="" width="375" /> |

## On Image

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-chip___on-image_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-chip___on-image_dm.png" alt="" width="375" /> |

## Usage

Example of a Chip: 
```swift
let chip = BPKChip(title: "Chip text")
```

Example of a selected Chip:
```swift
let chip = BPKChip(title: "Chip text")
chip.isSelected = true
```

Example of a disabled Chip:
```swift
let chip = BPKChip(title: "Chip text")
chip.isEnabled = false
```

Example of a Chip with leading icon:
```swift
let chip = BPKChip(title: "Chip text", icon: .deals)
```

Example of a Chip on dark background:
```swift
let chip = BPKChip(title: "Chip text")
chip.style = .onDark
```

Example of a Chip on an image background:
```swift
let chip = BPKChip(title: "Chip text")
chip.style = .onImage
```

Example of a Chip with a different semantic type:
```swift
let chip = BPKChip(title: "Chip text")
chip.type = .dropdown
```