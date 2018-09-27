# Backpack/Spinner

## Installation

In `Podfile` add

```
pod 'Backpack/Spinner'
```

and then run `pod install`.

## Usage

`Backpack/Spinner` contains the Backpack Spinner component in the class `BPKSpinner` which is a subclass of `UIActivityIndicatorView` with Skyscanner styles. It accepts a Backpack font style to set the desired size, style and positioning properties.

```objective-c
#import <Backpack/Spinner.h>

BPKSpinner *spinner = [[BPKSpinner alloc] initWithSize:BPKSpinnerSizeDefault style:BPKSpinnerStylePrimary];
// Position spinner with autolayout or other method
```
