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

## Installation

In `Podfile` add

```
pod 'Backpack/Chip'
```

and then run `pod install`.

## Usage

`Backpack/Chip` contains the Backpack Chip component in the class `BPKChip`. The chip is a simple padded control with a subtle outline and some text inside. It has two boolean properties, `selected` and `enabled`. `selected` is toggled when the user touches the chip.

```objective-c
#import <Backpack/Chip.h>

BPKChip *chip = [[BPKChip alloc] init];
chip.title = @"Some title";
chip.enabled = NO;
chip.backgroundTint = BPKColor.panjin;
chip.iconName = BPKLargeIconNameMap;
```

```swift
import Backpack

let chip = BPKChip()
chip.title = "Some title"
chip.enabled = false
chip.backgroundTint = BPKColor.panjin
chip.iconName = .map
```

### Appearance attributes

- `(UIColor)primaryColor`
