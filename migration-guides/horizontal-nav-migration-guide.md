# Horizontal Navigation Migration Guide

This guide explains how to migrate use of `BPKHorizontalNavigation` after its API revision and Swift migration.


## Key changes

* The component now uses the new [icon API](./icon-migration-guide.md)
* The component is now authored in Swift
* The `size` property has been removed. The size of the component is enforced via a generic parameter.
* The API provided in Objective-C has been drastically reduced and won't be a focus. Consider migrating to Swift to take full advantage of the component.


## Swift

### Before

```swift
import Backpack

let options = [
    BPKHorizontalNavigationOption(name: "Flights", iconName: .flight, tag: 0),
    BPKHorizontalNavigationOption(
        name: "Hotels", tag: 1,
        iconName: .hotels,
        showNotificationDot: showNotificationDot
    ),
    BPKHorizontalNavigationOption(name: "Car hire", iconName: .cars, tag: 2)
]
let horizontalNav = BPKHorizontalNavigation(options: options, selected: 0)
horizontalNav.size = .small
```

### After

```swift
import Backpack

// A typealias can help keep the length of type down as the new types 
// are a bit verbose.
typealias SmallNav = BPKHorizontalNavigation<BPKHorizontalNavigationSizeSmall>

let options = [
    .textAndIcon("Flights", icon: BPKSmallIconName.flight, tag: 0),
    .textAndIcon(
        "Hotels", 
        icon: BPKSmallIconName.hotels, 
        tag: 1, 
        showNotificationDot: showNotificationDot
    ),
    .textAndIcon("Car Hire", icon: BPKSmallIconName.cars, tag: 2)
]

let horizontalNav = SmallNav(options: options, selectedItemIndex: 0)
```

For the default size use `BPKHorizontalNavigationSizeDefault` instead of `BPKHorizontalNavigationSizeSmall` and `BPKLargeIconName` instead of `BPKSmallIconName`.

## Objective-C

### Before


```objc
NSArray<BPKHorizontalNavigationOption *> *options = @[
    [[BPKHorizontalNavigationOption alloc] initWithName:@"Flights" tag:0],
    [[BPKHorizontalNavigationOption alloc] initWithName:@"Hotels" tag:1],
    [[BPKHorizontalNavigationOption alloc] initWithName:@"Car hire" tag:2]
];
BPKHorizontalNavigation *horizontalNavigation = [[BPKHorizontalNavigation alloc] initWithOptions:options selected:0];
horizontalNavigation.showsSelectedBar = YES;
```

### After

**Note:** You might find that your use case can no longer be achieved in Objective-C. If so, consider migrating to Swift instead.

```objc
NSArray<id<BPKHorizontalNavigationOptionTypeObjc>> *options = @[
    [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Flights" tag:0 iconName:nil],
    [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Hotels" tag:1 iconName:nil],
    [[BPKHorizontalNavigationOptionObjc alloc] initWithName:@"Car hire" tag:2 iconName:nil]
];
BPKHorizontalNavigationObjc *horizontalNavigation = [[BPKHorizontalNavigationObjc alloc] initWithOptions:options selectedItemIndex:0];
horizontalNavigation.showsSelectedBar = YES;
```
