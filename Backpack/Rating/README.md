# Backpack/Rating

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKRating.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Rating)

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___default_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___default_dm.png) |

## Subtitles

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___subtitles_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___subtitles_dm.png) |

## Vertical

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___vertical_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___vertical_dm.png) |


## Pill

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___pill_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___pill_dm.png) |

## Sizes

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___sizes_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___sizes_dm.png) |

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
```

### Appearance attributes

- `(UIColor)lowRatingColor`
- `(UIColor)mediumRatingColor`
- `(UIColor)highRatingColor`
