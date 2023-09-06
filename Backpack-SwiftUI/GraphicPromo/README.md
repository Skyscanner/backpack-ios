# Backpack-SwiftUI/GraphicPromo

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKGraphicPromo.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/BPKGraphicPromo)

## Top aligned

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_graphic-promo___top-aligned_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_graphic-promo___top-aligned_dm.png" alt="" width="375" /> |

## Bottom aligned

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_graphic-promo___bottom-aligned_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_graphic-promo___bottom-aligned_dm.png" alt="" width="375" /> |

## Top aligned - Sponsored

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_graphic-promo___top-aligned-sponsored_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_graphic-promo___top-aligned-sponsored_dm.png" alt="" width="375" /> |

## Bottom aligned - Sponsored

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_graphic-promo___bottom-aligned-sponsored_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_graphic-promo___bottom-aligned-sponsored_dm.png" alt="" width="375" /> |

# Usage

A component that allows for setting a kicker, headline and subheadline. Optionally, add the `.sponsored` ViewModifier to setup the sponsor logo and text. Set a `.fallbackColor` for when the image is still loading, this can be any `Color` and does not need to use `BPKColor`

```swift
struct GraphicPromoExampleView: View {    
    var body: some View {
        ScrollView {
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the climb in 3 days",
                image: Image(decorative: "canadian_rockies_canada"),
                overlay: .solid(.medium),
                verticalAlignment: verticalAlignment
            )
            .onTapGesture {
                print("Tap on graphic promo")
            }
            .fallbackColor(Color(.surfaceHighlightColor))
            .sponsor(
                title: "Sponsored",
                logo: Image(decorative: "skyland"),
                accessibilityLabel: "Sponsored by Skyland"
            )
        }
    }
}
```
