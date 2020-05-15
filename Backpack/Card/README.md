# Backpack/Card

## Usage

`BPKCard` contains the Backpack Card component. The card is a simple control view with a shadow, offering user interaction. It has a padded and non-padded variation. `BPKCard` can only have 1 direct subview and will add the appropriate constraints automatically when calling setting the `subview` property.

`BPKDividedCard` contains the Backpack Divided Card component. The divided card is a subclass of `BPKCard`. It can have 2 subviews and will add the appropriate constraints automatically when `-initWithPrimarySubview:secondarySubview:padded`/`init(primarySubview: secondarySubview: padded: )` or `-setPrimarySubview:secondarySubview`/`setSubviews(primarySubview: secondarySubview:)` are called. It's axis can be vertical or horizontal.

### Objective-C

**`BPKCard`**

```objective-c
#import <Backpack/Card.h>

BPKCard *card = [[BPKCard alloc] initWithPadded:YES];
[card setSubview:myInnerView];
card.padded = NO;
```

**`BPKDividedCard`**

```objective-c
#import <Backpack/Card.h>

BPKDividedCard *dividedCard = [[BPKDividedCard alloc] initWithPrimarySubview:myFirstInnerView secondarySubview:mySecondInnerSubview padded:YES];
// dividedCard.padded = NO;
dividedCard.orientation = UILayoutConstraintAxisVertical;
```

### Swift

**`BPKCard`**

```swift
import Backpack

let card = BPKCard(paddded: true)
card.subview = myInnerView
card.padded = false
```

**`BPKDividedCard`**

```swift
import Backpack

let dividedCard = BPKDividedCard(
    primarySubview: myFirstInnerView,
    secondarySubview: mySecondInnerSubview,
    padded: true
)
// dividedCard.padded = false
dividedCard.orientation = .vertical
```
