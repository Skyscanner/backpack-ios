# Backpack/TextField

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKTextField.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/TextField)

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-text-field___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-text-field___default_dm.png) |


## Usage

`BPKTextField` contains the Backpack TextField component which is a subclass of `UITextField` with Skyscanner styles. It accepts a Backpack font style to set the desired size.

### Objective-C

```objective-c
#import <Backpack/TextField.h>

BPKTextField *textField = [[BPKTextField alloc] initWithFontStyle:BPKFontStyleTextBase];
// Position textView with autolayout or other method
```

### Swift

```swift
import Backpack

let textField = BPKTextField(fontStyle: .textBase)
// Position TextField with autolayout or other method
```

## Dynamic Text

`BPKTextField` doesn't currently support **Dynamic Text**, but this is planned for a later release.
