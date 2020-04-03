# Backpack/Badge

## Usage

`BPKBadge` contains the Backpack Badge component. It has 6 different styles defined in `BPKBadgeType` and can contain a message.


### Objective-C

```objective-c
#import <Backpack/Badge.h>

BPKBadge *badge = [[BPKBadge alloc] initWithType:BPKBadgeTypeSuccess message:@"Hello Travel"];
```

### Swift


```swift
import Backpack

let badge = BPKBadge(type: .success, message: "Hello Travel")
```
