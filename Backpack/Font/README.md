# Backpack/Font

## Installation

In `Podfile` add

```
pod 'Backpack/Font'
```

and then run `pod install`.

## Usage

`Backpack/Font` contains the Backpack typography styles in a single class `BPKFont`. This subspec also contains an enum defining all the text styles supported by Backpack, `BPKFontStyle` which can be used with `+fontWithStyle:`.

```objective-c
#import <Backpack/Font.h>

[BPKFont textXs];
[BPKFont textXsEmphasized];
[BPKFont fontWithStyle:BPKFontStyleTextBase];
```

We support a variety of sizes and an emphasized style for each.
