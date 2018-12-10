# Backpack Font tokens

## Usage

All Backpack text rendering is done with `NSAttributedString` to correctly reflect our desired typography. For most cases you don't have care about this and can just use `BPKLabe`/`Backpack.Label` or `BPKTextView`/`Backpack.TextView`. If you do need more control `BPKFont`/`Backpack/Font` provide several methods for constructing `NSAttributedString`s.

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

let attributedString = Backpack.Font.makeAttributedString(fontStyle: style, content: "Hello Travel")
```

