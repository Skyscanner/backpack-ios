# Backpack/Badge

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKBadge.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Badge)

## Default

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-badge___all_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-badge___all_dm.png) |

## Usage

`BPKBadge` contains the Backpack Badge component. It has 6 different styles defined in `BPKBadgeType` and can contain a message as well as an icon.


### Objective-C

```objective-c
#import <Backpack/Badge.h>
BPKBadge *badge = [[BPKBadge alloc] initWithType:BPKBadgeTypeSuccess icon:[[BPKBadgeIcon alloc] initWithPosition:BPKBadgeIconPositionLeading iconName:BPKSmallIconTick] message:@"Hello Travel"];
```

### Swift


```swift
import Backpack

let badge = BPKBadge(type: .success, icon: Icon(position: .trailing, iconName: .tick), message: "Hello Travel")
```
