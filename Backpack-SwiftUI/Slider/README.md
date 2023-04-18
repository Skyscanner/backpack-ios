# Backpack-SwiftUI/Slider

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKSlider.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Slider)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_slider___all_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_slider___all_dm.png" alt="" width="375" /> |

## Usage

### Regular Slider
```swift
@State var value: Float = 0.5

BPKSlider(value: $value, sliderBounds: 0...1)
```

### Range Slider
```swift
@State var value: ClosedRange<Float> = 0.25...0.75

BPKRangeSlider(selectedRange: $value, sliderBounds: 0...1)
```

### Changing the step size
```swift
@State var value: Float = 50
@State var rangeValue: ClosedRange<Float> = 25...75

BPKSlider(
    value: $value,
    sliderBounds: 0...100,
    step: 10
)
BPKRangeSlider(
    selectedRange: $rangeValue,
    sliderBounds: 0...100,
    step: 10
)
```

### Setting a minimum distance between the two thumbs
```swift
@State var value: ClosedRange<Float> = 0...100

BPKRangeSlider(
    selectedRange: $value,
    sliderBounds: 0...100,
    minDistance: 20
)
```

### Accessibility labels for the thumbs
```swift
@State var value: Float = 0
@State var rangeValue: ClosedRange<Float> = 0...100

BPKSlider(value: $value, sliderBounds: 0...100)
    .accessibilityLabel("Volume")

BPKRangeSlider(selectedRange: $rangeValue, sliderBounds: 0...100)
    .leadingAccessibilityLabel("Min temperature")
    .trailingAccessibilityLabel("Max temperature")
```