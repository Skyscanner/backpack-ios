# Backpack-SwiftUI/ImageGalleryGrid

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKImageGalleryGrid.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/ImageGalleryGrid)
 
## Usage

You can use the grid with categories as BPKChips or Images, this style is set by the `style` parameter.

### With Images

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_image-gallery-grid___images_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_image-gallery-grid___images_dm.png" alt="" width="375" /> |

```swift
@State var selectedCategory: Int = 0
@State var isPresented: Bool = false

BPKButton("Show Chips Image Grid") {
    isPresented.toggle()
}.bpkImageGalleryGrid(
    isPresented: $isPresented,
    selectedCategory: $selectedCategory,
    style: .image(categories)
    closeAccessibilityLabel: "Close Gallery",
    onImageTapped: { category, image in
        print("Image tapped: \(category) - \(image)")
    },
    onCloseTapped: {
        isPresented.toggle()
    },
)

var categories: [BPKImageGalleryImageGridStyle.ImageCategory] {
    [
        .init(
            title: "category 1",
            images: [
                .init(
                    title: "Image 1",
                    content: image("image1")
                ),
            ],
            categoryImage: {
                image("cateogory image 1")
            }
        )
    ]
}

func image(_ name: String) -> some View {
    Image(name)
        .resizable()
        .aspectRatio(contentMode: .fill)
}
```

### With BPKChips

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_image-gallery-grid___chips_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_image-gallery-grid___chips_dm.png" alt="" width="375" /> |

```swift
@State var selectedCategory: Int = 0
@State var isPresented: Bool = false

BPKButton("Show Chips Image Grid") {
    isPresented.toggle()
}.bpkImageGalleryGrid(
    isPresented: $isPresented,
    selectedCategory: $selectedCategory,
    style: .chip(categories)
    closeAccessibilityLabel: "Close Gallery",
    onImageTapped: { category, image in
        print("Image tapped: \(category) - \(image)")
    },
    onCloseTapped: {
        isPresented.toggle()
    },
)

var categories: [BPKImageGalleryImageGridStyle.ChipCategory] {
    [
        .init(
            title: "category 1",
            images: [
                .init(
                    title: "Image 1",
                    content: image("image1")
                ),
            ]
        )
    ]
}

func image(_ name: String) -> some View {
    Image(name)
        .resizable()
        .aspectRatio(contentMode: .fill)
}
```
