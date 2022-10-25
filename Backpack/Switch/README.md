# Backpack/Switch

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-switch___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-switch___default_dm.png) |

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
