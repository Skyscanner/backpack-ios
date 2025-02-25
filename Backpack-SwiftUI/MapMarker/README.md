# Backpack-SwiftUI/MapMarker

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![Price Marker reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKPriceMapMarker.html)
[![Pointer Marker reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKPointerMapMarker.html)
[![Poi Marker reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKPoiMapMarker.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/MapMarker)

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_map-markers___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_map-markers___default_dm.png" alt="" width="375" /> |
 
## Usage

## Price Marker

The Price Marker receives a price string and a status. The status can be one of the following:

```swift
public enum BPKPriceMapMarkerStatus {
    case selected
    case unselected
    case previousSelected
}
```

### Selected Price Marker

```swift
BPKPriceMapMarker(status: .selected, price: "£123")
```

### Unselected Price Marker

```swift
BPKPriceMapMarker(status: .unselected, price: "£123")
```

### Previous Selected Price Marker

```swift
BPKPriceMapMarker(status: .previousSelected, price: "£123")
```

## Pointer Marker

```swift
BPKPointerMapMarker()
```

## Poi Marker

The Poi Marker receives an icon and a status. The status can be one of the following:

```swift
public enum BPKPoiMapMarkerStatus {
    case unselected
    case selected
}
```

### Unselected Poi Marker

```swift
BPKPoiMapMarker(status: .unselected, icon: .landmark)
```

### Selected Poi Marker

```swift
BPKPoiMapMarker(status: .selected, icon: .landmark)
```

## Hotel Marker

The Hotel Marker receives a status. The status can be one of the following:

```swift
public enum BPKHotelMapMarkerStatus {
    case unselected
    case selected
}
```

### Unselected Hotel Marker

```swift
BPKHotelMapMarker(status: .unselected)
```

### Selected Hotel Marker

```swift
BPKHotelMapMarker(status: .selected)
```
