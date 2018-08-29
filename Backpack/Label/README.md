# Backpack/Label

## Installation

In `Podfile` add

```
pod 'Backpack/Label'
```

and then run `pod install`.

## Usage

`Backpack/Label` contains the Backpack Label component in the class `BPKLabel` which is a subclass of `UILabel` with Skyscanner styles. It accepts a Backpack font style to set the desired size.

```objective-c
#import <Backpack/Label.h>

BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
// Position label with autolayout or other method
```

### Dynamic Text

`BPKLabel` doesn't currently support **Dynamic Text**, but this is planned for a later release.
