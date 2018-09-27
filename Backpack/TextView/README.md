# Backpack/TextView

## Installation

In `Podfile` add

```
pod 'Backpack/TextView'
```

and then run `pod install`.

## Usage

`Backpack/TextView` contains the Backpack TextView component in the class `BPKTextView` which is a subclass of `UITextView` with Skyscanner styles. It accepts a Backpack font style to set the desired size.

```objective-c
#import <Backpack/TextView.h>

BPKTextView *TextView = [[BPKTextView alloc] initWithFontStyle:BPKFontStyleTextBase];
// Position TextView with autolayout or other method
```

### Dynamic Text

`BPKTextView` doesn't currently support **Dynamic Text**, but this is planned for a later release.
