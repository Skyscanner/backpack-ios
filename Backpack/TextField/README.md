# Backpack/TextField

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
import BPKTextField

let textField = TextField(fontStyle: .textBase)
// Position TextField with autolayout or other method
```

## Dynamic Text

`BPKTextField` doesn't currently support **Dynamic Text**, but this is planned for a later release.
