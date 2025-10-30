// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "Backpack",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(name: "Backpack-Common", targets: ["Backpack_Common"]),
    .library(name: "Backpack-SwiftUI", targets: ["Backpack_SwiftUI"]),
  ],
  dependencies: [
    // Only needed for SwiftUI test target
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.9.0")
  ],
  targets: [

    // MARK: - BackpackCommon (source-based)
    .target(
      name: "Backpack_Common",
      path: "Backpack-Common",
      exclude: [
        "Tests"
      ],
      sources: [
        // Common
        "BackpackCommonImports.swift",
        "BPKCommonBundle.swift",
        "BPKCommonRatingScale.swift",

        // Components
        "Carousel/Classes",
        "Configuration/Classes",
        "Configuration/Fonts",
        "Icons/Generated"
      ],
      resources: [
        .process("Icons/Assets")
      ]
    ),

    // MARK: - BackpackSwiftUI (depends on BackpackCommon)
    .target(
      name: "Backpack_SwiftUI",
      dependencies: ["Backpack_Common"],
      path: "Backpack-SwiftUI",
      exclude: [
        "Tests",
        "Blur/Classes/VariableBlur.metal"
      ],
      sources: [
        "AppSearchModal/Classes",
        "Badge/Classes",
        "BannerAlert/Classes",
        "Blur/Classes",
        "BottomSheet/Classes",
        "Button/Classes",
        "Calendar/Classes",
        "Card/Classes",
        "CardButton/Classes",
        "CardCarousel/Classes",
        "CardList/Classes",
        "Carousel/Classes",
        "CarouselCard/Classes",
        "Chip/Classes",
        "ChipGroup/Classes",
        "Color/Classes",
        "Dialog/Classes",
        "DynamicLayout/Classes",
        "FieldSet/Classes",
        "Flare/Classes",
        "FlowStackView/Classes",
        "Font/Classes",
        "GraphicPromo/Classes",
        "HorizontalNavigation/Classes",
        "Icons/Classes",
        "ImageGalleryGrid/Classes",
        "ImageGalleryPreview/Classes",
        "ImageGallerySlideshow/Classes",
        "InsetBanner/Classes",
        "Link/Classes",
        "MapMarker/Classes",
        "NavigationBar/Classes",
        "NavigationTab/Classes",
        "Nudger/Classes",
        "Overlay/Classes",
        "PageIndicator/Classes",
        "Panel/Classes",
        "Price/Classes",
        "PriceRange/Classes",
        "ProgressBar/Classes",
        "Radii/Classes",
        "Rating/Classes",
        "RatingBar/Classes",
        "SearchControlInput/Classes",
        "SearchInputSummary/Classes",
        "SectionHeader/Classes",
        "SegmentedControl/Classes",
        "Select/Classes",
        "Shadow/Classes",
        "Skeleton/Classes",
        "Slider/Classes",
        "Snippet/Classes",
        "Spacing/Classes",
        "Spinner/Classes",
        "StarRating/Classes",
        "Switch/Classes",
        "TappableContainer/Classes",
        "Text/Classes",
        "TextArea/Classes",
        "TextField/Classes",
        "Utils/Classes",

        "BackpackSwiftUIImports.swift",
      ],
      resources: [
        .process("Blur/Classes/VariableBlur.metal")
      ]
    ),

    // MARK: - Tests
    .testTarget(
      name: "BackpackCommonTests",
      dependencies: ["Backpack_Common"],
      path: "Backpack-Common/Tests"
    ),
    .testTarget(
        name: "BackpackSwiftUITests",
        dependencies: [
            "Backpack_SwiftUI",
            .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
        ],
        path: "Backpack-SwiftUI/Tests",
        resources: [
            .process("Images.xcassets")
        ]
    ),
  ],
  swiftLanguageVersions: [.v5]
)
