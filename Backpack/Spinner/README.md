# Backpack/Spinner

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
