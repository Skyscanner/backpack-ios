# Backpack-SwiftUI/ImageGallerySlideshow

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKImageGallerySlideshow.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/ImageGallerySlideshow)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_image-gallery-preview___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_image-gallery-preview___default_dm.png" alt="" width="375" /> |
 
## Usage

```swift
@State var currentIndex: Int = 0
    
BPKImageGallerySlideshow(
    images: [image("Paris"), image("Barcelona"), image("London")],
    currentIndex: $currentIndex,
    onImageClicked: { selectedIndex in
        print("User tapped on image number \(selectedIndex)")
    }
)

func image(_ name: String) -> Image {
    Image(name)
        .resizable()
        .aspectRatio(contentMode: .fill)
}
```