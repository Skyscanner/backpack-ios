# Backpack/Button

## Usage

`BPKButton`/`Backpack.Button` contains the Backpack Button component which is a subclass of `UIButton` with Skyscanner styles. It accepts a Backpack font style to set the desired size, style and positioning properties.

### Objective-C
```objective-c
#import <Backpack/Button.h>

BPKButton *button = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
[button setTitle:@"My Button"];
// Position button with autolayout or other method
```

With Icon

```objective-c
#import <Backpack/Button.h>
#import <Backpack/Icon.h>

UIImage *icon = [BPKIcon templateIconNamed:@"long-arrow-right" size:BPKIconSizeSmall];
BPKButton *button = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
[button setTitle:@"My Button"];
[button setImage:icon];
// Position button with autolayout or other method
```

### Swift

```swift
import Backpack

let button = Backpack.Button(size: .default, style: .primary)
button.title = "My Button"
// Position button with autolayout or other method
```

With Icon

```swift
import Backpack

let icon = Backpack.Icon.makeTemplateIcon(name: .longArrowRight, size: .small)
let button = Backpack.Button(size: .default, style: .primary)
button.title = "My Button"
button.image = icon
// Position button with autolayout or other method
```

### Dynamic Text

`BPKButton`/`Backpack.Button` doesn't currently support **Dynamic Text**, but this is planned for a later release.
