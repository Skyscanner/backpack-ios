# Backpack/TextView

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKTextView.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/TextView)

## Usage

`BPKTextView` contains the Backpack TextView component which is a subclass of `UITextView` with Skyscanner styles. It accepts a Backpack font style to set the desired size.

### Objective-C

```objective-c
#import <Backpack/TextView.h>

BPKTextView *textView = [[BPKTextView alloc] initWithFontStyle:BPKFontStyleTextBase];
// Position textView with autolayout or other method
```

### Swift

```swift
import Backpack

let textView = BPKTextView(fontStyle: .base)
// Position TextView with autolayout or other method
```

## Dynamic Text

`BPKTextView` doesn't currently support **Dynamic Text**, but this is planned for a later release.
