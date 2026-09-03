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

let backpackUIKitSourceDirs = [
  "BottomSheet",
  "Chip",
  "CardButton",
  "FlightLeg",
  "FloatingNotification",
  "BarChart",
  "Badge",
  "Carousel",
  "Price",
  "Rating",
  "HorizontalNavigation",
  "Overlay",
  "PageIndicator",
  "Skeleton",
  "StarRating/Classes/BPKHotelStarRating.swift",
  "TabBarController",
  "BackpackUIKitImports.swift",
  "Color/Classes/Generated/BPKInternalColors.swift",
  "Card/Classes/BPKCardElevation.swift",
  "Card/Classes/BPKCardWrapper.swift",
  "TextView/Classes/BPKTextView.swift"
]
let backpackObjCSourceDirs = [
  "Switch/Classes",
  "TextField/Classes",
  "TappableLinkLabel/Classes",
  "Font/Classes",
  "FlareView/Classes",
  "Button/Classes",
  "Dialog/Classes",
  "Icon/Classes",
  "Label/Classes",
  // Color is listed file-by-file rather than as "Color/Classes" because
  // Backpack-Tokens/Sources/BPKColor.m is a symlink to
  // Color/Classes/Generated/BPKColor.m, which Backpack_Tokens already compiles.
  // Globbing the directory would compile it twice and produce duplicate symbols.
  "Color/Classes/Generated/UIColor+Backpack.m",
  "Color/Classes/Generated/BPKColor+Internal.m",
  "Card/Classes",
  "Map/Classes",
  "NavigationBar/Classes",
  "ProgressBar/Classes",
  "Toast/Classes",
  "StarRating/Classes",
  "Theme/Classes",
  "RTLSupport/Classes",
  "Gradient/Classes",
  "Shadow/Classes",
  "Spinner/Classes",
  "Appearance/Classes"
]
let backpackCommonSourceDirs = [
  "BackpackCommonImports.swift",
  "BPKCommonBundle.swift",
  "BPKCommonRatingScale.swift",
  "Carousel",
  "Configuration",
  "Icons/Generated"
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
  "CellItem",
  "Checkbox",
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
  "Radio",
  "Radii",
  "Rating",
  "RatingBar",
  "SearchInputControl",
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
  "Swap",
  "Switch",
  "TappableContainer",
  "Text",
  "TextArea",
  "TextField",
  "Utils",
  "VideoPlayer",

  "BackpackSwiftUIImports.swift",
]
let backpackTokensSourceFiles = [
  "Sources/BPKColor.m",
  "Sources/BPKSpacing.m",
  "Sources/BPKRadii.m",
  "Sources/BPKBorderWidth.m",
  "Sources/BPKDuration.m"
]
let products: [Product] = [
  .library(name: "Backpack-Common", targets: ["Backpack_Common"]),
  .library(name: "Backpack-SwiftUI", targets: ["Backpack_SwiftUI"]),
  .library(name: "Backpack", targets: ["Backpack"]),
  .library(name: "Backpack-Fonts", targets: ["Backpack_Fonts"])
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
      sources: backpackCommonSourceDirs,
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
        "Tests"
      ] + backpackSwiftUIExcludedReadmes,
      sources: backpackSwiftUISourceDirs,
      // VariableBlur.metal lives under "Shaders", which is deliberately NOT in
      // backpackSwiftUISourceDirs. That matters: if a .metal file sits inside a
      // declared source directory, SwiftPM claims it as a source and also listing it
      // here is a "duplicate rule" error. Keeping it outside `sources` lets `.process`
      // compile it into default.metallib inside this target's resource bundle, which
      // is what BackpackShaderLibrary loads via Bundle.module.
      //
      // It previously sat in Blur/Classes and was listed in BOTH `exclude` and
      // `resources`. `exclude` is applied first, so it won: the shader was dropped,
      // the target produced no resource bundle at all, and bpkProgressiveBlur() could
      // never resolve its shader under SPM.
      //
      // The path still matches the CocoaPods glob 'Backpack-SwiftUI/*/Classes/**/*.metal'
      // in Backpack-SwiftUI.podspec, so the CocoaPods build is unaffected.
      resources: [
        .process("Shaders/Classes/VariableBlur.metal")
      ]
    ),

    // MARK: - Backpack Tokens (Objective-C generated tokens)
    .target(
      name: "Backpack_Tokens",
      path: "Backpack-Tokens",
      sources: backpackTokensSourceFiles,
      publicHeadersPath: "include",
      cSettings: [
        .unsafeFlags(["-include", "Backpack_TokensPrefix.h"]),
        .headerSearchPath("Sources"),
        .headerSearchPath("../Backpack/Color/Classes/Generated"),
        .headerSearchPath("../Backpack/Spacing/Classes/Generated"),
        .headerSearchPath("../Backpack/Radii/Classes/Generated"),
        .headerSearchPath("../Backpack/BorderWidth/Classes/Generated"),
        .headerSearchPath("../Backpack/Duration/Classes/Generated"),
        .headerSearchPath("../Backpack/DarkMode/Classes")
      ]
    ),

    // MARK: - Backpack Objective-C (expanded subset)
    .target(
      name: "Backpack_ObjC",
      dependencies: [
        "Backpack_Tokens",
        "Backpack_Common"
      ],
      path: "Backpack",
      exclude: [
        "Tests",
        "Backpack.h",
        "Color/Classes/Generated/BPKInternalColors.swift",
        "StarRating/Classes/BPKHotelStarRating.swift",
        "Card/Classes/BPKCardElevation.swift",
        "Card/Classes/BPKCardWrapper.swift"
      ] + backpackExcludedReadmes,
      sources: backpackObjCSourceDirs,
      publicHeadersPath: "SPMObjCHeaders",
      cSettings: [
        .headerSearchPath(".."),
        .headerSearchPath("Color/Classes/Generated"),
        .headerSearchPath("Spacing/Classes/Generated"),
        .headerSearchPath("Spacing/Classes"),
        .headerSearchPath("Button/Classes"),
        .headerSearchPath("Icon/Classes"),
        .headerSearchPath("Icon/Classes/Generated"),
        .headerSearchPath("NavigationBar/Classes"),
        .headerSearchPath("Label/Classes"),
        .headerSearchPath("Dialog/Classes"),
        .headerSearchPath("Theme/Classes"),
        .headerSearchPath("ProgressBar/Classes"),
        .headerSearchPath("Font/Classes"),
        .headerSearchPath("FlareView/Classes"),
        .headerSearchPath("Map/Classes"),
        .headerSearchPath("TappableLinkLabel/Classes"),
        .headerSearchPath("RTLSupport/Classes"),
        .headerSearchPath("StarRating/Classes"),
        .headerSearchPath("Gradient/Classes"),
        .headerSearchPath("Shadow/Classes/Generated"),
        .headerSearchPath("Appearance/Classes"),
        .headerSearchPath("Radii/Classes/Generated"),
        .headerSearchPath("BorderWidth/Classes/Generated"),
        .headerSearchPath("Duration/Classes/Generated"),
        .headerSearchPath("Font/Classes/Generated"),
        .headerSearchPath("DarkMode/Classes"),
        .headerSearchPath("SPMObjCHeaders/Backpack"),
        .headerSearchPath("SPMObjCHeaders"),
        .headerSearchPath("TappableLinkLabel/Classes/TTTAttributedLabel")
      ]
    ),

    // MARK: - Backpack UIKit (subset of Swift components)
    .target(
      name: "Backpack",
      dependencies: [
        "Backpack_Common",
        "Backpack_Tokens",
        "Backpack_ObjC",
        .product(name: "FloatingPanel", package: "FloatingPanel")
      ],
      path: "Backpack",
      exclude: [
        "Tests"
      ] + backpackExcludedReadmes,
      sources: backpackUIKitSourceDirs
    ),

    // MARK: - Backpack Fonts (resource-only target)
    //
    // The proprietary Skyscanner Relative fonts are NOT committed (public repo);
    // they are downloaded into Assets by Scripts/download-relative-fonts.rb.
    // Assets/README.md is committed so the directory exists in every checkout —
    // git does not track empty directories, and a missing directory made
    // `.process("Assets")` emit "Invalid Resource 'Assets': File not found" for
    // every remote SPM consumer. Directory resources are globbed at build time,
    // so fonts downloaded after dependency resolution are still bundled.
    //
    // The define makes BackpackFontsBundle's `#if ... SWIFT_MODULE_RESOURCE_BUNDLE_AVAILABLE`
    // branch real: the resource is always declared, so Bundle.module always exists.
    .target(
      name: "Backpack_Fonts",
      path: "Backpack-Fonts",
      exclude: [
        "Scripts",
        "Backpack-Fonts.podspec"
      ],
      sources: [
        "Sources"
      ],
      resources: [
        .process("Assets")
      ],
      swiftSettings: [
        .define("SWIFT_MODULE_RESOURCE_BUNDLE_AVAILABLE")
      ]
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
        "Backpack_Tokens"
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
        .process("Images.xcassets"),
        .process("skyscanner_test.mp4")
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
