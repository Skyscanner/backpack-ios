# Backpack/TextView

## Usage

`BPKTextView`/`Backpack.TextView` contains the Backpack TextView component which is a subclass of `UITextView` with Skyscanner styles. It accepts a Backpack font style to set the desired size.

### Objective-C

```objective-c
#import <Backpack/TextView.h>

BPKTextView *textView = [[BPKTextView alloc] initWithFontStyle:BPKFontStyleTextBase];
// Position textView with autolayout or other method
```

### Swift

```swift
#import <Backpack/TextView.h>

let textView = Backpack.TextView(fontStyle: .base)
// Position TextView with autolayout or other method
```

## Dynamic Text

`BPKTextView`/`Backpack.TextView` doesn't currently support **Dynamic Text**, but this is planned for a later release.
