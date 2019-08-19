# Backpack/FlareView

## Usage

`BPKFlareView`/`Backpack.FlareView` is a `UIView` with the Skyscanner flare style. The flare can be easily enabled and disabled with a `BOOL` property.

### Objective-C

```objective-c
#import <Backpack/FlareView.h>

BPKFlareView *flareView = [[BPKFlareView alloc] initWithFrame:CGRectZero];
flareView.isFlareVisible = YES;
flareViewView.backgroundColor = BPKColor.blue500;

UIView *innerView = [[UIView alloc] initWithFrame:CGRectZero];
innerView.backgroundColor = [BPKColor red500];

[flareView.contentView addSubview:innerView];
```

### Swift

```swift
import Backpack

let flareView = FlareView(frame: .zero)
flareView.isFlareVisible = showFlare
flareView.backgroundColor = Color.blue500

let label = Label(fontStyle: .textXlEmphasized)
label.text = "Much wow!"
label.textColor = Color.white
label.translatesAutoresizingMaskIntoConstraints = false

flareView.contentView.addSubview(label)
```

