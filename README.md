# Backpack iOS

> Backpack is a collection of design resources, reusable components and guidelines for creating Skyscanner's products.

[![release](https://github.com/Skyscanner/backpack-ios/actions/workflows/release.yml/badge.svg)](https://github.com/Skyscanner/backpack-ios/actions/workflows/release.yml)
[![main](https://github.com/Skyscanner/backpack-ios/actions/workflows/main.yml/badge.svg)](https://github.com/Skyscanner/backpack-ios/actions/workflows/main.yml)
[![License](https://img.shields.io/cocoapods/l/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![Platform](https://img.shields.io/cocoapods/p/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)

| Pod | Version |
| --- | --- |
| Backpack-Common | [![Version](https://img.shields.io/cocoapods/v/Backpack-Common.svg?style=flat)](https://cocoapods.org/pods/Backpack-Common) |
| Backpack | [![Version](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack) |
| Backpack-SwiftUI | [![Version](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI) |



## Installation

Backpack is distributed through [Swift Package Manager](https://swift.org/package-manager/).

In Xcode, choose **File → Add Package Dependencies** and enter:

```
https://github.com/Skyscanner/backpack-ios
```

Or add it to a `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/Skyscanner/backpack-ios", from: "92.1.0")
]
```

Four products are available: `Backpack` (UIKit), `Backpack-SwiftUI`, `Backpack-Common` and
`Backpack-Fonts`. Depend on the ones you need:

```swift
.target(
  name: "YourApp",
  dependencies: [
    .product(name: "Backpack", package: "backpack-ios"),
    .product(name: "Backpack-SwiftUI", package: "backpack-ios")
  ]
)
```

### CocoaPods (deprecated)

> [!WARNING]
> CocoaPods support is deprecated. The `Backpack`, `Backpack-Common` and `Backpack-SwiftUI` pods are
> still published, and existing Podfiles keep working for now, but the pods will stop being published
> once the deprecation window closes. The date is being agreed with the Backpack maintainers and will
> be announced here and in the release notes before anything is removed. New integrations should use
> Swift Package Manager.

CocoaPods [entered maintenance mode](https://blog.cocoapods.org/CocoaPods-Support-Plans/) in
August 2024, and Swift Package Manager is the actively developed, Xcode-native way to depend on
Backpack. Backpack is no longer built, tested or documented through CocoaPods: CI, the Example app
and the reference documentation all run on Swift Package Manager. See
[Documentation/SPM](Documentation/SPM/README.md) for the details of that move.

## Documentation

To learn more about the available Backpack components on iOS head over the [Backpack documentation site](https://skyscanner.design/) or check out the [reference documentation](https://backpack.github.io/ios).

## Contributing to Backpack

Please see the [Contributing guide][0] for instructions on contributing to this project.

## Our Principles

We follow a set of principles that are stated in the [Backpack documentation site](https://skyscanner.design/latest/getting-started/backpack-in-code/principles.html)

## License

Backpack is available under the Apache 2.0 license. See the LICENSE file for more info.

[0]: CONTRIBUTING.md

## Contact
- backpack@skyscanner.net
