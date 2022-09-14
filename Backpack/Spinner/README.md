# Backpack/Spinner

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
