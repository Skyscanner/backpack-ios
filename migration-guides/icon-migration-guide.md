# Icon Migration Guide

This guide explains how to migrate use of `BPKIcon` and `BPKIconView`.

## BPKIcon - makeIcon

There are now 3 separate methods for creating an icon as a UIImage.

The original method which accepts a `size` argument will be deprecated soon.

### Before

```swift
let smallImage = BPKIcon.makeIcon(name: .flight, color: BPKColor.skyGray, size: .small)
let largeImage = BPKIcon.makeIcon(name: .flight, color: BPKColor.skyGray, size: .large)
let xlImage = BPKIcon.makeIcon(name: .flight, color: BPKColor.skyGray, size: .xLarge)
```

### After

```swift
let smallImage = BPKIcon.makeSmallIcon(name: .flight, color: BPKColor.skyGray)
let largeImage = BPKIcon.makeLargeIcon(name: .flight, color: BPKColor.skyGray)
let xlImage = BPKIcon.makeXlIcon(name: .flight, color: BPKColor.skyGray)
```

## BPKIcon - makeTemplateIcon

There are now 3 separate methods for creating an icon as a template UIImage.

The original method which accepts a `size` argument will be deprecated soon.

### Before

```swift
let smallImage = BPKIcon.makeTemplateIcon(name: .flight, color: BPKColor.skyGray, size: .small)
let largeImage = BPKIcon.makeTemplateIcon(name: .flight, color: BPKColor.skyGray, size: .large)
let xlImage = BPKIcon.makeTemplateIcon(name: .flight, color: BPKColor.skyGray, size: .xLarge)
```

### After

```swift
let smallImage = BPKIcon.makeSmallTemplateIcon(name: .flight, color: BPKColor.skyGray)
let largeImage = BPKIcon.makeLargeTemplateIcon(name: .flight, color: BPKColor.skyGray)
let xlImage = BPKIcon.makeXlTemplateIcon(name: .flight, color: BPKColor.skyGray)
```

## BPKIconView

There are now 3 separate components for creating an icon as a UIImageView.

The original component which accepts a `size` argument will be deprecated soon.

### Before

```swift
let smallIconView = BPKIconView(iconName: .arrowLeft, size: .small)
let largeIconView = BPKIconView(iconName: .arrowLeft, size: .large)
let xlIconView = BPKIconView(iconName: .arrowLeft, size: .xLarge)
```

### After

```swift
let smallIconView = BPKSmallIconView(iconName: .arrowLeft)
let largeIconView = BPKLargeIconView(iconName: .arrowLeft)
let xlIconView = BPKXlIconView(iconName: .arrowLeft)
```
