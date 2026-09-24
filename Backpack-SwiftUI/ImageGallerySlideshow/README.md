# Backpack-SwiftUI/ImageGallerySlideshow

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKImageGallerySlideshow.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/ImageGallerySlideshow)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_image-gallery-slideshow___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_image-gallery-slideshow___default_dm.png" alt="" width="375" /> |
 
## Usage

```swift
@State var currentIndex: Int = 0
@State var isPresented: Bool = false

BPKButton("Show Slideshow") {
    currentIndex = 0
}.bpkImageGallerySlideshow(
    isPresented: $isPresented,
    images: [
        BPKImageGalleryImage(
            title: "London",
            description: "London is the capital and largest city of England and the UK.",
            credit: "John Doe",
        ) {
            image("London-brigde")
        },
    ],
    closeAccessibilityLabel: "Close",
    currentIndex: $currentIndex,
    onCloseTapped: {
        isPresented = false
    }
)

func image(_ name: String) -> some View {
    Image(name)
        .resizable()
        .aspectRatio(contentMode: .fill)
}
```

## Adapting to the window

The photo area takes the full width and as much of the height the header and footer leave as it can use, up to a square. Tall windows keep the square photo; short, wide windows such as the iPhone Duo's inner display in landscape get a wide photo area, and Close, the photo counter and the page dots stay on screen. VoiceOver users can also close the slideshow with the escape gesture, and Close accepts touches across Apple's 44 pt minimum touch target.
