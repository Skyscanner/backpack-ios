// swift-tools-version: 5.9
import PackageDescription
import Foundation

func readmePaths(relativeTo path: String) -> [String] {
  guard let enumerator = FileManager.default.enumerator(atPath: path) else { return [] }
  return enumerator.compactMap { element in
    guard let element = element as? String else { return nil }
    return element.lowercased().hasSuffix("readme.md") ? element : nil
  }
}

let backpackCommonExcludedReadmes = readmePaths(relativeTo: "Backpack-Common")
let backpackSwiftUIExcludedReadmes = readmePaths(relativeTo: "Backpack-SwiftUI")
let backpackExcludedReadmes = readmePaths(relativeTo: "Backpack")

let backpackUIKitObjcSourceDirs = [
  "Appearance",
  "BorderWidth",
  "Button",
  "Card",
  "Color",
  "Dialog",
  "Duration",
  "FlareView",
  "Font",
  "Gradient",
  "Icon",
  "Label",
  "Map",
  "NavigationBar",
  "ProgressBar",
  "Radii",
  "RTLSupport",
  "Shadow",
  "Spacing",
  "Spinner",
  "StarRating",
  "Switch",
  "TappableLinkLabel",
  "TextField",
  "TextView",
  "Theme",
  "Toast"
]

let backpackUIKitSwiftSources = [
  "BackpackUIKitImports.swift",
  "Badge",
  "BarChart",
  "BottomSheet",
  "CardButton",
  "Carousel",
  "Chip",
  "FlightLeg",
  "FloatingNotification",
  "HorizontalNavigation",
  "Overlay",
  "PageIndicator",
  "Price",
  "Rating",
  "Skeleton",
  "TabBarController",
  "Card/Classes/BPKCardElevation.swift",
  "Card/Classes/BPKCardWrapper.swift",
  "Color/Classes/Generated/BPKInternalColors.swift",
  "StarRating/Classes/BPKHotelStarRating.swift"
]

let backpackObjcExcludedFiles = [
  "Card/Classes/BPKCardElevation.swift",
  "Card/Classes/BPKCardWrapper.swift",
  "Color/Classes/Generated/BPKInternalColors.swift",
  "StarRating/Classes/BPKHotelStarRating.swift"
]

let backpackSwiftUISourceDirs = [
  "AppSearchModal",
  "Badge",
  "BannerAlert",
  "Blur",
  "BottomSheet",
  "Button",
  "Calendar",
  "Card",
  "CardButton",
  "CardCarousel",
  "CardList",
  "Carousel",
  "CarouselCard",
  "Chip",
  "ChipGroup",
  "Color",
  "Dialog",
  "DynamicLayout",
  "FieldSet",
  "Flare",
  "FlowStackView",
  "Font",
  "GraphicPromo",
  "HorizontalNavigation",
  "Icons",
  "ImageGalleryGrid",
  "ImageGalleryPreview",
  "ImageGallerySlideshow",
  "InsetBanner",
  "Link",
  "MapMarker",
  "NavigationBar",
  "NavigationTab",
  "Nudger",
  "Overlay",
  "PageIndicator",
  "Panel",
  "Price",
  "PriceRange",
  "ProgressBar",
  "Radii",
  "Rating",
  "RatingBar",
  "SearchControlInput",
  "SearchInputSummary",
  "SectionHeader",
  "SegmentedControl",
  "Select",
  "Shadow",
  "Skeleton",
  "Slider",
  "Snippet",
  "Spacing",
  "Spinner",
  "StarRating",
  "Switch",
  "TappableContainer",
  "Text",
  "TextArea",
  "TextField",
  "Utils",
  "BackpackSwiftUIImports.swift"
]

let products: [Product] = [
  .library(name: "Backpack-Common", targets: ["Backpack_Common"]),
  .library(name: "Backpack-SwiftUI", targets: ["Backpack_SwiftUI"]),
  .library(name: "Backpack", targets: ["Backpack"])
]

let dependencies: [Package.Dependency] = [
  // Only needed for SwiftUI test target
  .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.9.0"),
  // Required for the UIKit BottomSheet component
  .package(url: "https://github.com/scenee/FloatingPanel", from: "2.8.6")
]

let targets: [Target] = [

    // MARK: - BackpackCommon (source-based)
    .target(
      name: "Backpack_Common",
      path: "Backpack-Common",
      exclude: [
        "Tests"
      ] + backpackCommonExcludedReadmes,
      sources: [
        // Common
        "BackpackCommonImports.swift",
        "BPKCommonBundle.swift",
        "BPKCommonRatingScale.swift",

        // Components
        "Carousel",
        "Configuration",
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
      ] + backpackSwiftUIExcludedReadmes,
      sources: backpackSwiftUISourceDirs,
      resources: [
        .process("Blur/Classes/VariableBlur.metal")
      ]
    ),

    // MARK: - Backpack Tokens (Objective-C generated tokens)
    .target(
      name: "BackpackTokens",
      path: "BackpackTokens",
      sources: [
        "Sources/BPKColor.m",
        "Sources/BPKSpacing.m",
        "Sources/BPKRadii.m",
        "Sources/BPKBorderWidth.m",
        "Sources/BPKDuration.m"
      ],
      publicHeadersPath: "include",
      cSettings: [
        .unsafeFlags(["-include", "BackpackTokensPrefix.h"]),
        .headerSearchPath("Sources"),
        .headerSearchPath("../Backpack/Color/Classes/Generated"),
        .headerSearchPath("../Backpack/Spacing/Classes/Generated"),
        .headerSearchPath("../Backpack/Radii/Classes/Generated"),
        .headerSearchPath("../Backpack/BorderWidth/Classes/Generated"),
        .headerSearchPath("../Backpack/Duration/Classes/Generated"),
        .headerSearchPath("../Backpack/DarkMode/Classes")
      ]
    ),

    // MARK: - Backpack UIKit ObjC core
    .target(
      name: "BackpackObjC",
      path: "Backpack",
      exclude: [
        "Tests"
      ] + backpackExcludedReadmes + backpackObjcExcludedFiles,
      sources: backpackUIKitObjcSourceDirs,
      publicHeadersPath: ".",
      cSettings: [
        .headerSearchPath(".")
      ]
    ),

    // MARK: - Backpack UIKit (Swift facade)
    .target(
      name: "Backpack",
      dependencies: [
        "Backpack_Common",
        "BackpackTokens",
        "BackpackObjC",
        .product(name: "FloatingPanel", package: "FloatingPanel")
      ],
      path: "Backpack",
      exclude: [
        "Tests"
      ] + backpackExcludedReadmes,
      sources: backpackUIKitSwiftSources
    ),

    // MARK: - Tests
    .testTarget(
      name: "BackpackCommonTests",
      dependencies: ["Backpack_Common"],
      path: "Backpack-Common/Tests"
    ),
    .testTarget(
      name: "BackpackTests",
      dependencies: [
        "Backpack",
        "BackpackTokens"
      ],
      path: "Backpack/Tests/UnitTests",
      exclude: [
        "Images.xcassets"
      ],
      sources: [
        "BPKSkeletonTests.swift"
      ]
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
]

let package = Package(
  name: "Backpack",
  platforms: [
    .iOS(.v16)
  ],
  products: products,
  dependencies: dependencies,
  targets: targets,
  swiftLanguageVersions: [.v5]
)
