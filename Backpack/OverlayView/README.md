# Backpack/OverlayView

## Usage

`BPKOverlayView` provides an easy way to place content either in-front or behind a tint layer. It ensures that, when placing text on a graphic, the text will be legible and accessible.

### Objective-C

```objective-c
#import <Backpack/OverlayView.h>

BPKOverlayView *OverlayView = [[BPKOverlayView alloc] initWithOverlayType:BPKOverlayViewOverlayTypeNone cornerStyle:BPKOverlayViewCornerStyleNone];
overlayView.cornerStyle = BPKOverlayViewCornerStyleLarge;
overlayView.overlayType = BPKOverlayViewOverlayTypeTint;

...

[overlayView.backgroundView addSubView:myBackground];
[overlayView.foregroundView addSubView:myForeground];
```

### Swift

```swift
import Backpack

let overlayView = BPKOverlayView(overlayType: .none, cornerStyle: .none)
overlayView.cornerStyle = .large
overlayView.overlayType = .tint

...

overlayView.backgroundView.addSubview(myBackground)
overlayView.foregroundView.addSubview(myForeground)
```
