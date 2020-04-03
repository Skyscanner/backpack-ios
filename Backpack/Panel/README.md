# Backpack/Panel

## Usage

`BPKPanel` contains the Backpack Panel component. The panel is a simple container view with a subtle shadow. It has a padded and non-padded variation. `BPKPanel` can only have 1 direct subview and will add the appropriate constraints automatically when calling `-addSubview:`/`addSubview(:)`.

### Objective-C

```objective-c
#import <Backpack/Panel.h>

BPKPanel *panel = [[BPKPanel alloc] initWithPadded:YES];
[panel addSubview:myInnerView];
panel.padded = NO;
panel.style = BPKPanelStyleDefault;
```

### Swift

```swift
import Backpack

let panel = BPKPanel(padded: true)
panel.addSubview(myInnerView)
panel.padded = false
panel.style = .default
```
