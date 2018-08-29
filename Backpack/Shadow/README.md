# Backpack/Shadow

## Installation

In `Podfile` add

```
pod 'Backpack/Shadow'
```

and then run `pod install`.

## Usage

`Backpack/Shadow` contains the Backpack shadow definitions in the class `BPKShadow`.

```objective-c
#import <Backpack/Shadow.h>

BPKShadow *shadowSm = [BPKShadow shadowSm];
// BPKShadow *shadowLg = [BPKShadow shadowLg];
// BPKShadow *shadowXl = [BPKShadow shadowXl];

[shadowSm applyToLayer:myView.layer];
```
