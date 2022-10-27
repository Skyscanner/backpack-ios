# Backpack/Panel

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKPanel.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Panel)

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-panel___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-panel___default_dm.png) |

## Without padding

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-panel___without-padding_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-panel___without-padding_dm.png) |


## Elevated

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-panel___elevated_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-panel___elevated_dm.png) |

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
