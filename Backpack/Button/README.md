# Backpack/Button

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKButton.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Button)

## Primary

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primary_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primary_dm.png) |

## Primary On Light

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primaryOnLight_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primaryOnLight_dm.png) |

## Primary On Dark

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primaryOnDark_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___primaryOnDark_dm.png) |

## Secondary

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___secondary_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___secondary_dm.png) |

## Secondary On Dark

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___secondaryOnDark_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___secondaryOnDark_dm.png) |

## Destructive

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___destructive_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___destructive_dm.png) |

## Featured

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___featured_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___featured_dm.png) |

## Link

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___link_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___link_dm.png) |

## Link On Dark

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___linkOnDark_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-button___linkOnDark_dm.png) |

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
