# Backpack-SwiftUI/Spinner

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSpinner.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Spinner)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_spinner___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_spinner___default_dm.png" alt="" width="375" /> |

## Usage

### Basic spinner
If you don't specify a style, it will default to textPrimary

```swift
BPKSpinner(.sm)

BPKSpinner(.sm, style: .textPrimary)
BPKSpinner(.lg, style: .disabled)
BPKSpinner(.xl, style: .onDarkSurface)
```