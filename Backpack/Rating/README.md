# Backpack/Rating

## Installation

In `Podfile` add

```
pod 'Backpack/Rating'
```

and then run `pod install`.

## Usage

`Backpack/Rating` contains a Backpack Rating component in the class `BPKRating`. It can display a rating value between 0.0 and 10.0.


```objective-c
#import <Backpack/Rating.h>

BPKRating *rating = [[BPKRating alloc] init];
rating.title = @"Some title";
rating.subtitle = @"Some subtitle";
rating.ratingValue = 9.7;
rating.size = BPKRatingSizeSmall;
```

### Appearance attributes
`(UIColor)lowRatingColor`
`(UIColor)mediumRatingColor`
`(UIColor)highRatingColor`
