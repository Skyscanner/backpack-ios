# Backpack/Page Indicator

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKPageIndicator.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/PageIndicator)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-page-indicator___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-page-indicator___default_dm.png" alt="" width="375" /> 

## Usage

The `BPKPageIndicator` is a component that shows the current page and the total number of pages.

You can set a `variant`, `currentIndex` and `totalIndicators` to configure the component.

```swift
let pageIndicator = BPKPageIndicator(
    variant: .overImage,
    currentIndex: 1,
    totalIndicators: 3
)
```

You can also set the `currentIndex` and `totalIndicators` properties to update the component.

```swift
pageIndicator.totalIndicators = 5
pageIndicator.currentIndex = 2
```
