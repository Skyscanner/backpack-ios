# Backpack/Label

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKLabel.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Label)

## Body

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-label___body_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-label___body_dm.png" alt="" width="375" /> |

## Heading

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-label___heading_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-label___heading_dm.png" alt="" width="375" /> |

## Hero

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-label___hero_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-label___hero_dm.png" alt="" width="375" /> |

## Usage

`BPKLabel` contains the Backpack Label component which is a subclass of `UILabel` with Skyscanner styles. It accepts a Backpack font style to set the desired size.


### Swift
Example of a `BPKLabel` with `label1` style and `textSecondary` color.

```swift
import Backpack

let label = BPKLabel(fontStyle: .textLabel1)
label.textColor = BPKColor.textSecondaryColor
label.text = "Label 1"
```

Example of a `BPKLabel` with multiple font styles
```swift
let label = BPKLabel(fontStyle: .textLabel1)
label.textColor = BPKColor.textSecondaryColor
label.text = "Label 1, example multiple text styles"

// Set font style for a specific range
label.setFontStyle(.textLg, range: NSRange(location: 12, length: 10))
```

## Dynamic Text

`BPKLabel` doesn't currently support **Dynamic Text**, but this is planned for a later release.

