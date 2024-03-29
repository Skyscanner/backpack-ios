# Backpack/FlareView

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKFlareView.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/FlareView)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-flare-view___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-flare-view___default_dm.png" alt="" width="375" /> |

## Rounded

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-flare-view___rounded_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-flare-view___rounded_dm.png" alt="" width="375" /> |

## Pointing up

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-flare-view___flare-at-top_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-flare-view___flare-at-top_dm.png" alt="" width="375" /> |

## With background image

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-flare-view___background-image_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-flare-view___background-image_dm.png" alt="" width="375" /> |

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
