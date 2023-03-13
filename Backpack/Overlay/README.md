# Backpack/Overlay

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKOverlay.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Overlay)

## Solid

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-overlay___solid_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-overlay___solid_dm.png" alt="" width="375" /> |

## Top

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-overlay___top_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-overlay___top_dm.png" alt="" width="375" /> |

## Bottom

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-overlay___bottom_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-overlay___bottom_dm.png" alt="" width="375" /> |

## Left

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-overlay___left_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-overlay___left_dm.png" alt="" width="375" /> |

## Right

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-overlay___right_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-overlay___right_dm.png" alt="" width="375" /> |

## Usage

`BPKOverlay` provides an easy way to place content either in-front or behind a tint layer. It ensures that, when placing text on a graphic, the text will be legible and accessible.

### Swift

```swift
import Backpack

// This is the content that will receive the 'overlay'
let content = UIImageView(image: UIImage(named: "overlay_example"))

// Foreground content that will display on top of the overlay
let foregroundContent = BPKLabel(fontStyle: .textHero5)
foregroundContent.text = "Barcelona"
foregroundContent.textColor = BPKColor.white
foregroundContent.translatesAutoresizingMaskIntoConstraints = false

// Overlay view, this receives your content you want to be overlaid, the type of overlay and the content on top
// of the overlay
let overlay = BPKOverlay(content: content, overlayType: .bottomMedium, foregroundContent: foregroundContent)
overlay.translatesAutoresizingMaskIntoConstraints = false

// Optionally, give the view a corner radius
overlay.clipsToBounds = true
overlay.layer.cornerRadius = BPKCornerRadiusLg

view.addSubview(overlay)

NSLayoutConstraint.activate([
    // Position the overlay yourself.
    // The 'content' inside the overlay will match the overlay constraints.
    overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: BPKSpacingBase),
    overlay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: BPKSpacingBase),
    view.trailingAnchor.constraint(equalTo: overlay.trailingAnchor, constant: BPKSpacingBase),
    view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: overlay.bottomAnchor, constant: BPKSpacingBase),
    
    // Position the foreground content yourself.
    foregroundContent.leadingAnchor.constraint(equalTo: overlay.leadingAnchor, constant: BPKSpacingLg),
    overlay.bottomAnchor.constraint(equalTo: foregroundContent.bottomAnchor, constant: BPKSpacingLg)
])
```
