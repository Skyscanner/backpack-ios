# Backpack/Icon

## Usage

`BPKIcon`/`Backpack.Icon` contains the Backpack Icon component. It supports rendering any Backpack icon to `UIImage`s using a caching mechanism to reduce performance impact. A UI component `IconView`/`BPKIconView` is also available for simple icon case where an icon is to be displayed with a tint color.

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

UIImage *renderedIcon = [BPKIcon iconNamed:@"flight" color:[BPKolor skyGray] size:BPKIconSizeSmall];
```

### Swift

#### Using `IconView`

```swift
import Backpack

let iconView = Backpack.IconView(iconName: .accessibility, size: .small)
iconView.tintColor = Backpack.Color.blue500
```

##### Flip icons with a horizontal direction when layout direction is right to left

```swift
import Backpack

let iconView = Backpack.IconView(iconName: .arrowLeft, size: .small)
iconView.flipsForRightToLeft = true
```

#### Render icon to `UIImage`

```swift
import Backpack

let renderedIcon = Backpack.Icon.makeIcon(name: .flight, color: Backpack.Color.skyGray, size:.small)
``

