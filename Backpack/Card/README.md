# Backpack/Card

## Installation

In `Podfile` add

```
pod 'Backpack/Card'
```

and then run `pod install`.

## Usage

`Backpack/Card` contains the Backpack Card component in the class `BPKCard`. The card is a simple control view with a shadow, offering user interaction. It has a padded and non-padded variation. `BPKCard` can only have 1 direct subview and will add the appropriate constraints automatically when calling `-addSubview:`.


```objective-c
#import <Backpack/Card.h>

BPKCard *card = [[BPKCard alloc] initWithPadded:YES];
[card addSubview:myInnerView];
card.padded = NO;
```
