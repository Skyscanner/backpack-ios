# Backpack/Label

## Multiple font styles

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-label___multiple-font-styles_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-label___multiple-font-styles_dm.png) |

## Usage

`BPKLabel` contains the Backpack Label component which is a subclass of `UILabel` with Skyscanner styles. It accepts a Backpack font style to set the desired size.

### Objective-C

```objective-c
#import <Backpack/Label.h>

BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
// Position label with autolayout or other method

// Set font style for a specific range
[label setFontStyle:BPKFontStyleTextLg range:NSMakeRange(12, 10)];

```

### Swift

```swift
import Backpack

let label = BPKLabel(fontStyle: .base)
// Position label with autolayout or other method

// Set font style for a specific range
label.setFontStyle(.textLg, range: NSRange(location: 12, length: 10))

```

## Dynamic Text

`BPKLabel` doesn't currently support **Dynamic Text**, but this is planned for a later release.

