# Backpack/Card

## Installation

In `Podfile` add

```
pod 'Backpack/Card'
```

and then run `pod install`.

## Usage

### Card

`Backpack/Card` contains the Backpack Card component in the class `BPKCard`. The card is a simple control view with a shadow, offering user interaction. It has a padded and non-padded variation. `BPKCard` can only have 1 direct subview and will add the appropriate constraints automatically when calling `-setSubview:`.


```objective-c
#import <Backpack/Card.h>

BPKCard *card = [[BPKCard alloc] initWithPadded:YES];
[card setSubview:myInnerView];
card.padded = NO;
```

### Divided card

`Backpack/Card` contains the Backpack Divided Card component in the class `BPKDividedCard`. The divided card is a subclass of `BPKCard`. It can have 2 subviews and will add the appropriate constraints automatically when `-initWithPrimarySubview:secondarySubview:padded` or `-setPrimarySubview:secondarySubview` are called. It's axis can be vertical or horizontal.


```objective-c
#import <Backpack/DividedCard.h>

BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPrimarySubview:myFirstInnerView secondarySubview:mySecondInnerSubview padded:YES];
// card.padded = NO;
card.orientation = BPKDividedCardVerticalOrientation;
// [card setPrimarySubview:myFirstInnerSubview secondarySubview:mySecondInnerSubview];
```
