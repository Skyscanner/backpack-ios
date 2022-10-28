# Backpack/Icon

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKIcon.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Icon)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-icon___all_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-icon___all_dm.png" alt="" width="375" /> |

## Usage

`BPKIcon` contains the Backpack Icon component. It supports rendering any Backpack icon to `UIImage`s using a caching mechanism to reduce performance impact. A UI component `IconView`/`BPKIconView` is also available for simple icon case where an icon is to be displayed with a tint color.

\*\*Note: Some icons are only available in small or large, whilst others are available at both sizes. Check our [design docs](https://backpack.github.io/components/icon?platform=design) to see which are available.\*\*

### Objective-C

#### Using `BPKIconView`

```objective-c
#import <Backpack/Color.h>
#import <Backpack/Icon.h>


BPKIconView *iconView = [[BPKIconView alloc] initWithIconName:BPKIconNameAccessibility size:BPKIconSizeLarge];
iconView.tintColor = BPKColor.blue500;
```

#### Render icon to `UIImage`

```objective-c
#import <Backpack/Color.h>
#import <Backpack/Icon.h>

UIImage *renderedIcon = [BPKIcon smallIconNamed:BPKSmallIconNameFlight color:BPKColor.skyGray];
```

### Swift

#### Using `IconView`

```swift
import Backpack

let iconView = BPKSmallIconView(iconName: .accessibility)
iconView.tintColor = BPKColor.blue500
```

##### Flip icons with a horizontal direction when layout direction is right to left

```swift
import Backpack

let iconView = BPKSmallIconView(iconName: .arrowLeft)
iconView.flipsForRightToLeft = true
```

#### Render icon to `UIImage`

```swift
import Backpack

let renderedIcon = BPKIcon.makeSmallIcon(name: .flight, color: BPKColor.skyGray)
```
