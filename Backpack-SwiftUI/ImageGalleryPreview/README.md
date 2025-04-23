# Backpack-SwiftUI/ImageGalleryPreview

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKImageGalleryPreview.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/ImageGalleryPreview)

## Default

| Day | Night |
| --- | --- |
| <img src="https://github.com/user-attachments/assets/f99fb72b-710a-4281-9a52-6e45483246b1" alt="" width="375" /> |<img src="https://github.com/user-attachments/assets/7b9aa0cf-937c-414d-9a88-3a8b5b0a6159" alt="" width="375" /> |


## Usage

You can pass in an array of Images to the `BPKImageGalleryPreview` and it will display them in a carousel. You can also pass in a `currentIndex` to control which image is displayed and an `onImageClicked` closure to be notified when an image is clicked.

```swift
BPKImageGalleryPreview(
    image: image("London"),
    buttonText: "View Photos",
    onButtonClicked: {
        print("User tapped on image")
    }
)

func image(_ name: String) -> Image {
    Image(name)
        .resizable()
        .aspectRatio(contentMode: .fill)
}
```

## Hero

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_image-gallery-preview___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_image-gallery-preview___default_dm.png" alt="" width="375" /> |
 
## Usage

You can pass in an array of Images to the `BPKImageGalleryPreview` and it will display them in a carousel. You can also pass in a `currentIndex` to control which image is displayed and an `onImageClicked` closure to be notified when an image is clicked.

```swift
@State var currentIndex: Int = 0
    
BPKImageGalleryPreview(
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
