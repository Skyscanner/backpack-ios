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
rating.title = [[BPKRatingTextDefinition alloc] initWithHighRatingText:@"Some title to display when the value is high"
                                  mediumRatingText:@"Some title to display when the value is medium"
                                  lowRatingText:@"Some title to display when the value is low"];

// rating.subtitle property is nullable
rating.subtitle = [[BPKRatingTextDefinition alloc] initWithHighRatingText:@"Some subtitle to display when the value is high"
                                  mediumRatingText:@"Some subtitle to display when the value is medium"
                                  lowRatingText:@"Some subtitle to display when the value is low"];
rating.ratingValue = 9.7;
rating.size = BPKRatingSizeSmall;
rating.accessibilityLabel = "Rated 5 out of 10. Exceptional hotel."

// Alternate rating scale
// rating.ratingScale = BPKRatingScale0to5
// rating.ratingValue = 4.2
```

### Appearance attributes

- `(UIColor)lowRatingColor`
- `(UIColor)mediumRatingColor`
- `(UIColor)highRatingColor`
