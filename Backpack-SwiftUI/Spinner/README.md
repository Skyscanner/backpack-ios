# Backpack-SwiftUI/Spinner

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSpinner.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Spinner)

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_spinner___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-swiftui_spinner___default_dm.png) |

## Usage

### Basic spinner
If you don't specify a style, it will default to textPrimary

```swift
BPKSpinner(.sm)

BPKSpinner(.sm, style: .textPrimary)
BPKSpinner(.lg, style: .disabled)
BPKSpinner(.xl, style: .onDarkSurface)
```