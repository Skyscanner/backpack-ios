# Backpack/StarRating

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
