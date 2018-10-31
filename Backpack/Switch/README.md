# Backpack/Switch

## Installation

In `Podfile` add

```
pod 'Backpack/Switch'
```

and then run `pod install`.

## Usage

`Backpack/Switch` contains the Backpack Switch component in the class `BPKSwitch` which is a subclass of `UISwitch` with Skyscanner styles.

```objective-c
#import <Backpack/Switch.h>

BPKSwitch *switch = [[BPKSwitch alloc] initWithFrame:CGRectZero];
// Position switch with autolayout or other method
```
