# Backpack/Rating

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKRating.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Rating)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___default_dm.png" alt="" width="375" /> |

## Subtitles

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___subtitles_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___subtitles_dm.png" alt="" width="375" /> |

## Vertical

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___vertical_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___vertical_dm.png" alt="" width="375" /> |


## Pill

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___pill_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___pill_dm.png" alt="" width="375" /> |

## Sizes

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___sizes_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-rating___sizes_dm.png" alt="" width="375" /> |

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
