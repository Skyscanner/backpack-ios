# Backpack/Badge

## Installation

In `Podfile` add

```
pod 'Backpack/Badge'
```

and then run `pod install`.

## Usage

`Backpack/Badge` contains the Backpack Badge component in the class `BPKBadge`. It has 6 different styles defined in `BPKBadgeType` and can contain a message.


```objective-c
#import <Backpack/Badge.h>

BPKBadge *badge = [[BPKBadge alloc] initWithType:BPKBadgeTypeSuccess message:@"Hello World"];
```
