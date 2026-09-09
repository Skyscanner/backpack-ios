# Backpack iOS

> Backpack is a collection of design resources, reusable components and guidelines for creating Skyscanner's products.

[![release](https://github.com/Skyscanner/backpack-ios/actions/workflows/release.yml/badge.svg)](https://github.com/Skyscanner/backpack-ios/actions/workflows/release.yml)
[![main](https://github.com/Skyscanner/backpack-ios/actions/workflows/main.yml/badge.svg)](https://github.com/Skyscanner/backpack-ios/actions/workflows/main.yml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://github.com/Skyscanner/backpack-ios)
[![Swift Package Manager](https://img.shields.io/badge/SPM-supported-brightgreen.svg)](https://swift.org/package-manager/)


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

### CocoaPods (removed)

> [!IMPORTANT]
> **CocoaPods support has been removed.** `92.1.0` is the last version published to the CocoaPods
> trunk. The podspecs and the publishing pipeline are gone, so there will be no further pod releases.
> Swift Package Manager is the only supported way to depend on Backpack.

**Existing Podfiles keep working.** Every version already published to the trunk stays installable,
so nothing breaks if you do nothing. You simply stop receiving new Backpack versions.

If you need to stay on CocoaPods for now, pin to a released tag:

```ruby
# The last published pod version
pod 'Backpack', '~> 92.1'

# Or point directly at a tag that still contains the podspecs
pod 'Backpack', :git => 'https://github.com/Skyscanner/backpack-ios.git', :tag => '92.1.0'
```

To keep receiving updates, move to Swift Package Manager using the instructions above.

CocoaPods [entered maintenance mode](https://blog.cocoapods.org/CocoaPods-Support-Plans/) in
August 2024 and its [trunk stops accepting new versions](https://blog.cocoapods.org/CocoaPods-Specs-Repo/)
permanently on 2 December 2026. Swift Package Manager is the actively developed, Xcode-native path.
See [Documentation/SPM](Documentation/SPM/README.md) for how Backpack builds and ships today.

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
