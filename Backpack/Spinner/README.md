# Backpack/Spinner

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKSpinner.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Spinner)

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-spinner___all_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-spinner___all_dm.png) |

## Usage

`BPKSpinner` contains the Backpack Spinner component which is a subclass of `UIActivityIndicatorView` with Skyscanner styles.

### Objective-C

```objective-c
#import <Backpack/Spinner.h>

BPKSpinner *spinner = [[BPKSpinner alloc] initWithSize:BPKSpinnerSizeSm style:BPKSpinnerStyleTextPrimary];
// Position spinner with autolayout or other method
```

### Swift

```swift
import Backpack

let spinner = BPKSpinner(size: .sm, style: .textPrimary)
// Position spinner with autolayout or other method
```

### Appearance attributes

- `(UIColor)primaryColor`
