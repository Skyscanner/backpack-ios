# Backpack/FlareView

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-flare-view___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-flare-view___default_dm.png) |

## Rounded

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-flare-view___rounded_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-flare-view___rounded_dm.png) |

## Pointing up

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-flare-view___flare-at-top_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-flare-view___flare-at-top_dm.png) |

## With background image

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-flare-view___background-image_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-flare-view___background-image_dm.png) |

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
flareView.flarePosition = BPKFlarePositionTop;
flareView.cornerRadius = BPKCornerRadiusSm;
```

### Swift

```swift
import Backpack

let flareView = BPKFlareView(frame: .zero)
flareViewView.backgroundView.backgroundColor = BPKColor.skyBlue;

let label = BPKLabel(fontStyle: .textXlEmphasized)
label.text = "Much wow!"
label.textColor = BPKColor.white
label.translatesAutoresizingMaskIntoConstraints = false

flareView.contentView.addSubview(label)
flareView.flarePosition = .top
flareView.cornerRadius = BPKCornerRadiusSm
```
