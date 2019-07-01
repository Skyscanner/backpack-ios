# Backpack/Label

## Usage

`BPKLabel`/`Backpack.Label` contains the Backpack Label component which is a subclass of `UILabel` with Skyscanner styles. It accepts a Backpack font style to set the desired size.

### Objective-C

```objective-c
#import <Backpack/Label.h>

BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
// Position label with autolayout or other method

// Append text:
[label appendText:@"Some text" withFontStyle:BPKFontStyleTextLg];

// Insert text:
[label insertText:@"Some text" atIndex:20 withFontStyle:BPKFontStyleTextLg];

```

### Swift

```swift
import Backpack

let label = Backpack.Label(fontStyle: .base)
// Position label with autolayout or other method

// Append text:
label.appendText("Some text", with: .textLg);

// Insert text:
label.insertText("Some text", at:20, with: .textLg);

```

## Dynamic Text

`BPKLabel` doesn't currently support **Dynamic Text**, but this is planned for a later release.

### Appearance attributes
`(BPKFontMapping)fontMapping`

