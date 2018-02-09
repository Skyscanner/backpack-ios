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

[BPKColor colorBlue500];
[BPKColor colorGray900];
```

### Backpack/Font

`Backpack/Font` contains the Backpack typography styles in a single class `BPKFont`. Add `Backpack/Font` to your `Podfile` or `podspec` and then use it as follows.

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

`Backpack/Radii` contains the Backpack radiu values as `CGFloat` constants. Add `Backpack/Radii` to your `Podfile` or `podspec` and then use it as follows.

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

## Contributing to Backpack

Please see the [Contributing guide][0] for instructions on contributing to this project.

## License

Backpack is available under the Apache 2.0 license. See the LICENSE file for more info.

[0]: CONTRIBUTING.md
