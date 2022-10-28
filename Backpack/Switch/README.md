# Backpack/Switch
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKSwitch.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Switch)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-switch___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-switch___default_dm.png" alt="" width="375" /> |

## Usage

`BPKSwitch` contains the Backpack Switch component which is a subclass of `UISwitch` with Skyscanner styles.

### Objective-C

```objective-c
#import <Backpack/Switch.h>

BPKSwitch *switch = [BPKSwitch new];
// Position switch with autolayout or other method
```

### Swift

```swift
import Backpack

let `switch` = BPKSwitch();
// Position switch with autolayout or other method
```

### Appearance attributes

- `(UIColor)onTintColor`
