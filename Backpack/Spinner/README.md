# Backpack/Spinner

## Usage

`BPKSpinner`/`Backpack.Spinner` contains the Backpack Spinner component which is a subclass of `UIActivityIndicatorView` with Skyscanner styles.

### Objective-C

```objective-c
#import <Backpack/Spinner.h>

BPKSpinner *spinner = [[BPKSpinner alloc] initWithSize:BPKSpinnerSizeDefault style:BPKSpinnerStylePrimary];
// Position spinner with autolayout or other method
```

### Swift

```swift
import Backpack

let spinner = Backpack.Spinner(size: .`default`, style: .primary)
// Position spinner with autolayout or other method
```

### Appearance attributes
`(UIColor)primaryColor`

