# Backpack/CardButton

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKBadge.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/CardButton)

## Default
| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-cardbutton___all_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-cardbutton___all_dm.png" alt="" width="375" /> |

## Usage

Backpack Card button consists of 2 classes: `BPKSaveCardButton` & `BPKShareCardButton`. It supports 3 different styles defined in `BPKCardButtonStyle` and 2 sizes defined in `BPKCardButtonSize`

### Swift

BPKShareCardButton 
```swift
import Backpack

let shareButton = BPKShareCardButton(
    accessibilityLabel: "",
    style: .default,
    size: .default,
    onClick: {}
)
```

```swift
let saveButton = BPKSaveCardButton(
    checked: false,
    accessibilityLabel: "",
    style: .default,
    size: .default,
    onCheckedChange: { _ in }
)
```
