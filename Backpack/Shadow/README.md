# Backpack/Shadow

## Usage

`BPKShadow` contains the Backpack shadow definitions.

### Objective-C

```objective-c
#import <Backpack/Shadow.h>

BPKShadow *shadowSm = [BPKShadow shadowSm];
// BPKShadow *shadowLg = [BPKShadow shadowLg];

[shadowSm applyToLayer:myView.layer];
```

### Swift

```swift
import Backpack
let shadowSm = BPKShadow.shadowSm()


shadowSm.apply(to: myView.layer)

```
