# Backpack/FlareView

## Usage

`BPKFlareView` is a `UIView` with the Skyscanner flare style. The flare can be easily enabled and disabled with a `BOOL` property.

### Objective-C

```objective-c
#import <Backpack/FlareView.h>

BPKFlareView *flareView = [[BPKFlareView alloc] initWithFrame:CGRectZero];
flareViewView.backgroundView.backgroundColor = BPKColor.skyBlue;

UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
innerView.backgroundColor = [BPKColor systemRed];

[flareView.contentView addSubview:innerView];
```

### Swift

```swift
import Backpack

let flareView = FlareView(frame: .zero)
flareViewView.backgroundView.backgroundColor = BPKColor.skyBlue;

let label = Label(fontStyle: .textXlEmphasized)
label.text = "Much wow!"
label.textColor = BPKColor.white
label.translatesAutoresizingMaskIntoConstraints = false

flareView.contentView.addSubview(label)
```

