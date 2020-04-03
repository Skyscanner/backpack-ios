# Backpack/HorizontalNavigation

## Usage

`BPKHorizontalNavigation`/`Backpack.HorizontalNavigation` is a component similar to [Segmented Control](https://developer.apple.com/design/human-interface-guidelines/ios/controls/segmented-controls/). It shows two or more segments, each being a distinct option for travellers to switch between. Each option is defined with a string, and optionally a `BPKIcon` name too.

### Objective-C

```objective-c
#import <Backpack/HorizontalNavigation.h>

NSArray<BPKHorizontalNavigationOption *> *options = @[
                                                      [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
                                                      [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
                                                      [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
                                                      ];
BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options selected:0];
horizontalNavigation.showsSelectedBar = YES;
horizontalNavigation.size = BPKHorizontalNavigationSizeLarge;
horizontalNavigation.appearance = BPKHorizontalNavigationAppearanceNormal;
```

### Swift

```swift
import Backpack

let options = [
    BPKHorizontalNavigationOption(name: "Flights", iconName: .flight, tag:0),
    BPKHorizontalNavigationOption(name: "Hotels", iconName: .hotels, tag:1),
    BPKHorizontalNavigationOption(name: "Car hire", iconName: .cars, tag:2)
]
let horizontalNavigation = Backpack.HorizontalNavigation(options: options, selected:0)
horizontalNavigation.showsSelectedBar = false
horizontalNavigation.appearance = .normal
```

## Custom Horizontal Navigation Segments

Horizontal Navigation can use custom segments. To achieve this, implement a custom type that conforms to `BPKHorizontalNavigationOptionType` and return your own view (a subclass of `UIControl` that implements the protocol `BPKHorizontalNavigationItem`) for `makeItem`. Ensure the height of your view is similar to that of those rendered when `BPKHorizontalNavigationOption` is used directly for all the sizes that the component supports.

### Appearance attributes
`(UIColor)contentColor`
