# Backpack/Button

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKButton.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Button)

## Primary

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primary_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primary_dm.png" alt="" width="375" /> |

## Primaryonlight

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primaryOnLight_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primaryOnLight_dm.png" alt="" width="375" /> |

## Primaryondark

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primaryOnDark_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primaryOnDark_dm.png" alt="" width="375" /> |

## Secondary

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___secondary_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___secondary_dm.png" alt="" width="375" /> |

## Secondaryondark

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___secondaryOnDark_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___secondaryOnDark_dm.png" alt="" width="375" /> |

## Destructive

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___destructive_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___destructive_dm.png" alt="" width="375" /> |

## Featured

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___featured_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___featured_dm.png" alt="" width="375" /> |

## Link

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___link_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___link_dm.png" alt="" width="375" /> |

## Linkondark

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___linkOnDark_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___linkOnDark_dm.png" alt="" width="375" /> |

## Usage

`BPKButton` contains the Backpack Button component which is a subclass of `UIButton` with Skyscanner styles. It accepts a Backpack font style to set the desired size, style and positioning properties.
There's an `isLoading` property that if we set to `YES` will show an `ActivityIndicator`, also it will automatically set the `enabled` property to `NO` blocking the user interaction and it will change the style to a disable look and feel.
Setting the `isLoading` property to `NO` again will restore the predefined style.

### Objective-C

```objective-c
#import <Backpack/Button.h>

BPKButton *button = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
[button setTitle:@"My Button"];
// Position button with autolayout or other method
```

With Icon

```objective-c
#import <Backpack/Button.h>
#import <Backpack/Icon.h>

UIImage *icon = [BPKIcon templateIconNamed:@"long-arrow-right" size:BPKIconSizeSmall];
BPKButton *button = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
[button setTitle:@"My Button"];
[button setImage:icon];
// Position button with autolayout or other method
```

### Swift

```swift
import Backpack

let button = BPKButton(size: .default, style: .primary)
button.title = "My Button"
// Position button with autolayout or other method
```

With Icon

```swift
import Backpack

let icon = BPKIcon.makeTemplateIcon(name: .longArrowRight, size: .small)
let button = BPKButton(size: .default, style: .primary)
button.title = "My Button"
button.image = icon
// Position button with autolayout or other method
```

### Dynamic Text

`BPKButton` doesn't currently support **Dynamic Text**, but this is planned for a later release.

### Appearance attributes

- `(UIColor)primaryContentColor`
- `(UIColor)primaryGradientStartColor`
- `(UIColor)primaryGradientEndColor`

- `(UIColor)featuredContentColor`
- `(UIColor)featuredGradientStartColor`
- `(UIColor)featuredGradientEndColor`

- `(UIColor)linkContentColor`

- `(UIColor)secondaryContentColor`
- `(UIColor)secondaryBackgroundColor`
- `(UIColor)secondaryBorderColor`

- `(UIColor)destructiveContentColor`
- `(UIColor)destructiveBackgroundColor`
- `(UIColor)destructiveBorderColor`
