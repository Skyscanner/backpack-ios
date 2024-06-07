# Backpack/CardButton

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKSaveCardButton.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/CardButton)

## Default
| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-button___all_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-button___all_dm.png" alt="" width="375" /> |

## Usage

Backpack Card button consists of 2 classes: `BPKSaveCardButton` & `BPKShareCardButton`. It supports 3 different styles defined in `BPKCardButtonStyle` and 2 sizes defined in `BPKCardButtonSize`

Make sure you provide a localized accessibility label that matches the function of the button.


#### BPKShareCardButton 
```swift
import Backpack_SwiftUI

BPKShareCardButton(
    size: .default,
    style: .default,
    accessibilityLabel: "share"
) {
    print("Button tap closure")
}
```

#### BPKSaveCardButton 

```swift
BPKSaveCardButton(
    size: .default,
    style: .default,
    checked: true,
    accessibilityLabel: "save"
) {
    print("Button tap closure")
}

```
