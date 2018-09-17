# Backpack/Button

## Installation

In `Podfile` add

```
pod 'Backpack/Button'
```

and then run `pod install`.

## Usage

`Backpack/Button` contains the Backpack Button component in the class `BPKButton` which is a subclass of `UIButton` with Skyscanner styles. It accepts a Backpack font style to set the desired size, style and positioning properties.

```objective-c
#import <Backpack/Button.h>

BPKButton *button = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
// Position button with autolayout or other method
```

### Dynamic Text

`BPKButton` doesn't currently support **Dynamic Text**, but this is planned for a later release.
