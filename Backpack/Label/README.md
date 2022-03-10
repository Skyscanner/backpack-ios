# Backpack/Label

## Usage

`BPKLabel` contains the Backpack Label component which is a subclass of `UILabel` with Skyscanner styles. It accepts a Backpack font style to set the desired size.

### Objective-C

```objective-c
#import <Backpack/Label.h>

BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextHero2];
// Position label with autolayout or other method

// Set font style for a specific range
[label setFontStyle:BPKFontStyleTextBodyDefault range:NSMakeRange(12, 10)];

```

### Swift

```swift
import Backpack

let label = BPKLabel(fontStyle: .textLabel2)
// Position label with autolayout or other method

// Set font style for a specific range
label.setFontStyle(.textHeading2, range: NSRange(location: 12, length: 10))

```

## Dynamic Text

`BPKLabel` doesn't currently support **Dynamic Text**, but this is planned for a later release.

