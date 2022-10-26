# Backpack/Badge

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
