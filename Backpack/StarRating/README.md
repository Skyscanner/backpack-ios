# Backpack/StarRating

## Usage

`BPKStarRating`/`Backpack.StarRating` contains the Backpack Star rating component which is a view that's rendering star shaped items filled with color to indicate rating from 0.0 to 5.0. It supports two sizes considering the available `BPKIcon` sizes.

### Objective-C

Small stars
```objective-c
#import <Backpack/StarRating.h>

BPKStarRating *starRating = [[BPKStarRating alloc] initWithSize:BPKStarSizeSmall];
[button setRating:2.5];
// Position star rating with autolayout or other method
```

Large stars
```objective-c
#import <Backpack/StarRating.h>

BPKStarRating *starRating = [[BPKStarRating alloc] initWithSize:BPKStarSizeLarge];
[button setRating:2.5];
// Position star rating with autolayout or other method
```

### Swift

Small stars
```swift
import Backpack

let starRating = Backpack.StarRating(size: .small)
starRating.rating = 2.5
// Position button with autolayout or other method
```

Large stars
```swift
import Backpack

let starRating = Backpack.StarRating(size: .large)
starRating.rating = 2.5
// Position button with autolayout or other method
```

### Appearance attributes

`BPKStarRating`/`Backpack.StarRating` is displaying `BPKStarRating`/`Backpack.Star` views which have the following appearance attributes.

`(UIColor)starFilledColor`
