# Backpack/StarRating

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKStarRating.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/StarRating)

## All types

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-star-rating___docs_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-star-rating___docs_dm.png) |

## Usage

`BPKStarRating` contains the Backpack Star rating component which is a view that's rendering star shaped items filled with color to indicate rating from 0.0 to 5.0. It supports three sizes considering the available `BPKIcon` sizes.
By default `userInteractionEnabled` is set to `NO` but we can change this value to `YES` to allow the users to change the rating value by tapping the component

### Rating Rounding

Use `StarRatingRounding` to adjust how rating values fill in the stars
- `BPKStarRatingRoundingDown` rounds down to the next half star. i.e. 3.26 fills in 3 stars  
- `BPKStarRatingRoundingUp` rounds up to the next half star. i.e. 3.26 fills in 3.5 stars 
- `BPKStarRatingRoundingNearest` rounds up/down to the nearest half star. i.e. 3.26 fills in 3.5 stars 

### Objective-C

Small stars

```objective-c
#import <Backpack/StarRating.h>

BPKStarRating *starRating = [[BPKStarRating alloc] initWithSize:BPKStarSizeSmall];
starRating.rating = 2.5;
// Position star rating with autolayout or other method
```

Large stars

```objective-c
#import <Backpack/StarRating.h>

BPKStarRating *starRating = [[BPKStarRating alloc] initWithSize:BPKStarSizeLarge];
starRating.rating = 2.5;
// Position star rating with autolayout or other method
```

Extra Large stars with user interaction

```objective-c
#import <Backpack/StarRating.h>

BPKStarRating *starRating = [[BPKStarRating alloc] initWithSize:BPKStarSizeXLarge];
starRating.rating = 2.5;
starRating.userInteractionEnabled = YES;
// Position star rating with autolayout or other method
```

Adjust rounding type to control how the half stars are filled in

```objective-c
#import <Backpack/StarRating.h>

BPKStarRating *starRating = [[BPKStarRating alloc] initWithSize:BPKStarSizeXLarge];
starRating.rounding = BPKStarRatingRoundingUp;
starRating.rating = 2.6;
// Position star rating with autolayout or other method
```

### Swift

Small stars

```swift
import Backpack

let starRating = BPKStarRating(size: .small)
starRating.rating = 2.5
// Position button with autolayout or other method
```

Large stars

```swift
import Backpack

let starRating = BPKStarRating(size: .large)
starRating.rating = 2.5
// Position button with autolayout or other method
```

Extra Large stars with user interaction

```swift
import Backpack

let starRating = BPKStarRating(size: .xLarge)
starRating.rating = 2.5
starRating.userInteractionEnabled = true
// Position button with autolayout or other method
```

Adjust rounding type to control how the half stars are filled in

```swift
import Backpack

let starRating = BPKStarRating(size: .xLarge)
starRating.rounding = .up
starRating.rating = 2.5
// Position button with autolayout or other method
```

### Appearance attributes

`BPKStarRating` is displaying `BPKStarRating` views which have the following appearance attributes.

- `(UIColor)starFilledColor`
