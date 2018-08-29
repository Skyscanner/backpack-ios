# Backpack/Panel

## Installation

In `Podfile` add

```
pod 'Backpack/Panel'
```

and then run `pod install`.

## Usage

`Backpack/Panel` contains the Backpack Panel component in the class `BPKPanel`. The panel is a simple container view with a subtle shadow. It has a padded and non-padded variation. `BPKPanel` can only have 1 direct subview and will add the appropriate constraints automatically when calling `-addSubview:`.


```objective-c
#import <Backpack/Panel.h>

BPKPanel *panel = [[BPKPanel alloc] initWithPadded:YES];
[panel addSubview:myInnerView];
panel.padded = NO;
```
