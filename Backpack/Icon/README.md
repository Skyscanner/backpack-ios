# Backpack/Icon

## Default

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-icon___all_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-icon___all_dm.png) |

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
