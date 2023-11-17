# AppSearchModal

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKBadge.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Badge)

## Content

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_app-search-modal___content_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_app-search-modal___content_dm.png" alt="" width="375" /> |


## Loading

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_app-search-modal___loading_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_app-search-modal___loading_dm.png" alt="" width="375" /> |


## Error

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_app-search-modal___error_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_app-search-modal___error_dm.png" alt="" width="375" /> |

## Usage

Example of a AppSearchModal in Content state:

```swift
import Backpack_SwiftUI
BPKAppSearchModal(
    title: "Search Modal",
    inputText:  $myText,
    inputHint: "Search",
    results: .content(.init(
        sections: [ /* sections */ ],
        shortcuts: [ /*  shortcuts */ ]
    )),
    closeAccessibilityLabel: "Close",
    onClose: { }
)
```

Example of a AppSearchModal in Loading state:

```swift
import Backpack_SwiftUI

BPKAppSearchModal(
    title: "Search Modal",
    inputText: $myText,
    inputHint: "Search",
    results: .loading(.init(accessibilityLabel: "Loading")),
    closeAccessibilityLabel: "Close",
    onClose: { /* close modal*/ }
)
```

Example of a AppSearchModal in Error state:

```swift
import Backpack_SwiftUI

BPKAppSearchModal(
    title: "Search Modal",
    inputText: $myText,
    inputHint: "Search",
    results: .error( .init(
        title: "Title",
        description: "This is the subtitle",
        action: .init( text: "Title for button", onActionSelected: { /* action on button Tapped */ }),
        image: Image("photo")

    )),
    closeAccessibilityLabel: "Close",
    onClose: { /* close modal*/ }
)
```
