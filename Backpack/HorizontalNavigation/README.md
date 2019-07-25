# Backpack/HorizontalNavigation

## Usage

`BPKHorizontalNavigation`/`Backpack.HorizontalNavigation` is a component similar to [Segmented Control](https://developer.apple.com/design/human-interface-guidelines/ios/controls/segmented-controls/). It shows two or more segments, each being a distinct option for travellers to switch between. Each option is defined with a string, and optionally a `BPKIcon` name too.

### Objective-C

```objective-c
#import <Backpack/HorizontalNavigation.h>

NSArray<BPKHorizontalNavigationOption *> *options = @[
                                                      [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights"],
                                                      [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels"],
                                                      [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire"]
                                                      ];
BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options selected:0];
horizontalNavigation.showsSelectedBar = YES;
horizontalNavigation.size = BPKHorizontalNavigationSizeLarge;
```

### Swift

```swift
import Backpack

let options = [
    BPKHorizontalNavigationOption(name: "Flights", iconName: .flight),
    BPKHorizontalNavigationOption(name: "Hotels", iconName: .hotels),
    BPKHorizontalNavigationOption(name: "Car hire", iconName: .cars)
]
let horizontalNavigation = Backpack.HorizontalNavigation(options: options, selected:0)
horizontalNavigation.subview = myInnerView
horizontalNavigation.showsSelectedBar = false
```

### Appearance attributes
`(BPKFontMapping)fontMapping`
`(UIColor)contentColor`

