# Backpack Font tokens

## Usage

### Skyscanner Relative
To enable Skyscanner Relative font, ensure that the Relative font files are present in your app, and add the following at the earliest possible point in the `AppDelegate`'s `didFinishLaunchingWithOptions` method:

```
[BPKFont setFontDefinition:[BPKRelativeFontDefinition new]];
```

All Backpack text rendering is done with `NSAttributedString` to correctly reflect our desired typography. For most cases you don't have care about this and can just use `BPKLabe` or `BPKTextView`. If you do need more control `BPKFont` provide several methods for constructing `NSAttributedString`s.

### Objective-C

`Backpack/Font.h` contains the Backpack typography styles in a single class `BPKFont`.

```objective-c
#import <Backpack/Font.h>

BPKFontStyle sm = BPKFontStyleTextBase;

[BPKFont attributedStringWithFontStyle:sm content:@"Hello travel"];
```

### Swift

```Swift
import Backpack

let style = BPKFontStyleTextBase;

let attributedString = BPKFont.makeAttributedString(fontStyle: style, content: "Hello Travel")
```
