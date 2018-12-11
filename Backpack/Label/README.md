# Backpack/Label

## Usage

`BPKLabel`/`Backpack.Label` contains the Backpack Label component which is a subclass of `UILabel` with Skyscanner styles. It accepts a Backpack font style to set the desired size.

### Objective-C

```objective-c
#import <Backpack/Label.h>

BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
// Position label with autolayout or other method
```

### Swift

```swift
import Backpack

let label = Backpack.Label(fontStyle: .base)
// Position label with autolayout or other method
```

## Dynamic Text

`BPKLabel` doesn't currently support **Dynamic Text**, but this is planned for a later release.
