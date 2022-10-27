# Backpack/Card

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKCard.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Card)

## Default

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___default_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___default_dm.png) |

## Selected

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___selected_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___selected_dm.png) |

## Large corner style

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___corner-style-large_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___corner-style-large_dm.png) |

## Without padding

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___without-padding_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___without-padding_dm.png) |

## With divider

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-divider_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-divider_dm.png) |

## With divider arranged vertically

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-divider-arranged-vertically_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-divider-arranged-vertically_dm.png) |

## With divider and without padding

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-divider-without-padding_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-divider-without-padding_dm.png) |

## With divider and with large corner style

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-divider-and-corner-style-large_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-divider-and-corner-style-large_dm.png) |

## With solid divider

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-solid-divider-with-padding_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-solid-divider-with-padding_dm.png) |

## With solid divider and without padding

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-solid-divider-without-padding_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-card___with-solid-divider-without-padding_dm.png) |


## Usage

`BPKCard` contains the Backpack Card component. The card is a simple control view with or without a shadow, offering user interaction. It has a padded and non-padded variation. `BPKCard` can only have 1 direct subview and will add the appropriate constraints automatically when calling setting the `subview` property.

`BPKDividedCard` contains the Backpack Divided Card component. The divided card is a subclass of `BPKCard`. It can have 2 subviews and will add the appropriate constraints automatically when `-initWithPrimarySubview:secondarySubview:padded`/`init(primarySubview: secondarySubview: padded: )` or `-setPrimarySubview:secondarySubview`/`setSubviews(primarySubview: secondarySubview:)` are called. It's axis can be vertical or horizontal.

Cards have an accessibility configuration. By default this is `Container` which means the card is invisible to assistive technology. In this case, ensure that the content of the card provides users of AT with the same action as tapping the card, and explain actions clearly.

Use the `isElevated` property to enable or disable shadows on the card.

If using a `Button` or `Link` configuration, ensure that the accessibilityLabel used describes the whole content of the card and the same action.

Do not use `Button` or `Link` configurations if the card has multiple actions or if the copy is long.

### Objective-C

**`BPKCard`**

```objective-c
#import <Backpack/Card.h>

BPKCard *card = [[BPKCard alloc] initWithPadded:YES];
[card setSubview:myInnerView];
card.padded = NO;
card.isElevated = NO;
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
card.isElevated = false
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
