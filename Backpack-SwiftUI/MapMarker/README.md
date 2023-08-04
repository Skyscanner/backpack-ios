# Backpack-SwiftUI/MapMarker

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue) Price Marker](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKPriceMapMarker.html)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue) Pointer Marker](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKPointerMapMarker.html)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue) Poi Marker](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKPoiMapMarker.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/MapMarker)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_map-markers___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_map-markers___default_dm.png" alt="" width="375" /> |
 
## Usage

## Price Marker

The Price Marker receives a price string and a status. The status can be one of the following:

```swift
public enum BPKPriceMapMarkerStatus {
    case `default`
    case focused
    case viewed
    case disabled
}
```

### Default Price Marker

```swift
BPKPriceMapMarker(status: .default, price: "£123")
```

### Focused Price Marker

```swift
BPKPriceMapMarker(status: .focused, price: "£123")
```

### Viewed Price Marker

```swift
BPKPriceMapMarker(status: .viewed, price: "£123")
```

### Disabled Price Marker

```swift
BPKPriceMapMarker(status: .disabled, price: "Sold out")
```

## Pointer Marker

```swift
BPKPointerMapMarker()
```

## Poi Marker

The Poi Marker receives an icon and a status. The status can be one of the following:

```swift
public enum BPKPoiMapMarkerStatus {
    case `default`
    case focused
    case disabled
}
```

### Default Poi Marker

```swift
BPKPoiMapMarker(status: .default, icon: .landmark)
```

### Focused Poi Marker

```swift
BPKPoiMapMarker(status: .focused, icon: .landmark)
```

### Disabled Poi Marker

```swift
BPKPoiMapMarker(status: .disabled, icon: .landmark)
```
