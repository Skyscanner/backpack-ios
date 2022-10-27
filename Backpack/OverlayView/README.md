# Backpack/OverlayView

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKOverlayView.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/OverlayView)

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-overlay-view___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-overlay-view___default_dm.png) |

## Disabled tint

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-overlay-view___overlay-type-none_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-overlay-view___overlay-type-none_dm.png) |

## Foreground content

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-overlay-view___foreground-content_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-overlay-view___foreground-content_dm.png) |


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
