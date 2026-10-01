# Backpack/Price

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKPrice.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Price)

## ExtraSmall

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-price___extraSmall_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-price___extraSmall_dm.png" alt="" width="375" /> |

## Small

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-price___small_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-price___small_dm.png" alt="" width="375" /> |

## Large

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-price___large_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-price___large_dm.png" alt="" width="375" /> |


## Usage

```swift
import Backpack

let priceView = BPKPrice(
    price: "£1830",
    leadingText: "App only deal",
    previousPrice: "£2033",
    trailingText: "per day",
    alignment: .leading,
    size: size
)

let priceViewWithLeadingIcon = BPKPrice(alignment: .leading, size: size)
priceViewWithLeadingIcon.price = "£50"
priceViewWithLeadingIcon.leadingText = "£10 cheaper"
priceViewWithLeadingIcon.leadingTextAccessibilityLabel = "£10 cheaper than usual, tap for more information"
priceViewWithLeadingIcon.leadingIcon = .informationCircle
priceViewWithLeadingIcon.trailingIcon = .informationCircle
priceViewWithLeadingIcon.onLeadingTextClicked = {
    // Respond to taps on the leading text or either of its icons
}
```

Setting `leadingIcon` and/or `trailingIcon` renders them either side of
`leadingText`. Setting `onLeadingTextClicked` makes `leadingText` and both
icons a single tappable target.

By default VoiceOver announces `leadingText` as-is. Set
`leadingTextAccessibilityLabel` to override that announcement with a custom
string instead.