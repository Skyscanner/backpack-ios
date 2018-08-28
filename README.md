# Backpack

[![CI Status](http://img.shields.io/travis/Skyscanner/backpack-ios.svg?style=flat)](https://travis-ci.org/Skyscanner/backpack-ios)
[![Version](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](http://cocoapods.org/pods/Backpack)
[![License](https://img.shields.io/cocoapods/l/Backpack.svg?style=flat)](http://cocoapods.org/pods/Backpack)
[![Platform](https://img.shields.io/cocoapods/p/Backpack.svg?style=flat)](http://cocoapods.org/pods/Backpack)
[![Greenkeeper badge](https://badges.greenkeeper.io/Skyscanner/backpack-ios.svg)](https://greenkeeper.io/)

## Installation

Backpack is available through [CocoaPods](http://cocoapods.org). To install
all of it, simply add the following line to your Podfile:

```ruby
pod 'Backpack'
```

This will install all of Backpack. We use subspecs to subdivide the library so you might want to only install specific subspecs instead.

## Subspecs

### Backpack/Color

`Backpack/Color` contains our color palette contained in a single class `BPKColor`. Add `Backpack/Color` to your `Podfile` or `podspec` and then use it as follows.

```objective-c
#import <Backpack/Color.h>

[BPKColor blue500];
[BPKColor gray900];
```

### Backpack/Font

`Backpack/Font` contains the Backpack typography styles in a single class `BPKFont`. Add `Backpack/Font` to your `Podfile` or `podspec` and then use it as follows. This subspec also contains an enum defining all the text styles supported by Backpack, `BPKFontStyle` which can be used with `+fontWithStyle:`.

```objective-c
#import <Backpack/Font.h>

[BPKFont textXs];
[BPKFont textXsEmphasized];
```

We support a variety of sizes and an emphasized style for each.

### Backpack/Spacing

`Backpack/Spacing` contains the Backpack spacing values as `CGFloat` constants. Add `Backpack/Spacing` to your `Podfile` or `podspec` and then use it as follows.

```objective-c
#import <Backpack/Spacing.h>

CGFloat myAppSpacingSmall = BPKSpacingSm;
CGFloat myAppSpacingLarge = BPKSpacingLg;
```

### Backpack/Radii

`Backpack/Radii` contains the Backpack radii values as `CGFloat` constants. Add `Backpack/Radii` to your `Podfile` or `podspec` and then use it as follows.

```objective-c
#import <Backpack/Radii.h>

CGFloat myAppBorderRadiusSmall = BPKBorderRadiusSm;
CGFloat myAppBorderRadiusLarge = BPKBorderRadiusPill;
```

### Backpack/Shadow

`Backpack/Shadow` contains the Backpack shadow definitions in the class `BPKShadow`. Add `Backpack/Shadow` to your `Podfile` or `podspec` and then use it as follows.

```objective-c
#import <Backpack/Shadow.h>

BPKShadow *shadow = [BPKShadow shadowSm];
// BPKShadow *shadowLg = [BPKShadow shadowLg];
// BPKShadow *shadowXl = [BPKShadow shadowXl];

[shadow applyToLayer:myView.layer];
```

### Backpack/Gradient

`Backpack/Gradient` contains the Backpack gradient definitions in the class `BPKGradient`. `BPKGradient` has the two properties:

* `colors` of type `NSArray<UIColor *> *`
* `stops` encoded as `CGPoints` with components in the range 0-1 encoded as `NSValue * in NSArray<NSValue *> *`

Add `Backpack/Gradient` to your `Podfile` or `podspec` and then use it as follows.

```objective-c
#import <Backpack/Gradient.h>

BPKGradient *gradientDefault = [BPKGradient gradient];
BPKGradient *gradientTopRight =  [BPKGradient primaryWithDirection:BPKGradientDirectionTopRight];
```

### Backpack/Badge

`Backpack/Badge` contains the Backpack Badge component in the class `BPKBadge`. It has 6 different styles defined in `BPKBadgeType` and can contain a message.


```objective-c
#import <Backpack/Badge.h>

BPKBadge *badge = [[BPKBadge alloc] initWithType:BPKBadgeTypeSuccess message:@"Hello World"];
```

### Backpack/Label

`Backpack/Label` contains the Backpack Label component which is a subclass of `UILabel` with Skyscanner default styles. It accepts a Backpack font style to set the desired size. While the component doesn't currently support Dynamic Text the intention is to support this in the future.

```objective-c
#import <Backpack/Label.h>

BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
// Position label with autolayout or other method
```

### Backpack/Panel

`Backpack/Panel` contains the Backpack Panel component. The panel is a simple container view with a subtle shadow. It has a padded and non-padded variation. `BPKPanel` can only have 1 direct subview and will add the appropriate constraints automatically when calling `-addSubview:`.


```objective-c
#import <Backpack/Panel.h>

BPKPanel *panel = [[BPKPanel alloc] initWithPadded:YES];
[panel addSubview:myInnerView];
panel.padded = NO;
```

## Contributing to Backpack

Please see the [Contributing guide][0] for instructions on contributing to this project.

## License

Backpack is available under the Apache 2.0 license. See the LICENSE file for more info.

[0]: CONTRIBUTING.md
