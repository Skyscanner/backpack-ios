// swift-tools-version: 5.9
import PackageDescription
import Foundation

let backpackSwiftSources: [String] = [
    "BackpackExports.swift",
    "Badge/Classes/Badge.swift",
    "Badge/Classes/BadgeIcon.swift",
    "Badge/Classes/BadgeType.swift",
    "BarChart/Classes/BarChart.swift",
    "BarChart/Classes/BarChartBar.swift",
    "BarChart/Classes/BarChartCollectionView.swift",
    "BarChart/Classes/BarChartCollectionViewCell.swift",
    "BarChart/Classes/BarChartCollectionViewDataSource.swift",
    "BarChart/Classes/BarChartCollectionViewDelegate.swift",
    "BarChart/Classes/BarChartCollectionViewFlowLayout.swift",
    "BarChart/Classes/BarChartCollectionViewHeader.swift",
    "BarChart/Classes/BarChartKeyItem.swift",
    "BarChart/Classes/MiniFlareView.swift",
    "BottomSheet/Classes/BackpackFloatingPanelController.swift",
    "BottomSheet/Classes/BottomSheet.swift",
    "BottomSheet/Classes/BottomSheetInsets.swift",
    "BottomSheet/Classes/BPKFloatingPanelPosition.swift",
    "BottomSheet/Classes/IntrinsicBottomSheetLayout.swift",
    "BottomSheet/Classes/ModalBottomSheetLayout.swift",
    "BottomSheet/Classes/PersistentBottomSheetLayout.swift",
    "Card/Classes/BPKCardElevation.swift",
    "Card/Classes/BPKCardWrapper.swift",
    "CardButton/Classes/CardButtonBackgroundView.swift",
    "CardButton/Classes/CardButtonSize.swift",
    "CardButton/Classes/CardButtonStyle.swift",
    "CardButton/Classes/SaveCardButton+Style.swift",
    "CardButton/Classes/SaveCardButton.swift",
    "CardButton/Classes/ShareCardButton.swift",
    "Carousel/Classes/BPKCarousel.swift",
    "Chip/Classes/BPKChip.swift",
    "Chip/Classes/BPKChipColors.swift",
    "Chip/Classes/BPKChipStyle.swift",
    "Chip/Classes/BPKChipType.swift",
    "Color/Classes/Generated/BPKInternalColors.swift",
    "FlightLeg/Classes/BPKFlightLeg.swift",
    "FloatingNotification/Classes/BPKFloatingNotification.swift",
    "FloatingNotification/Classes/FloatingNotificationAnimator.swift",
    "FloatingNotification/Classes/FloatingNotificationView.swift",
    "FloatingNotification/Classes/FloatingNotificationViewModel.swift",
    "HorizontalNavigation/Classes/BPKHorizontalNavigation.swift",
    "HorizontalNavigation/Classes/BPKHorizontalNavigationItemDefault.swift",
    "HorizontalNavigation/Classes/BPKHorizontalNavigationObjcShim.swift",
    "HorizontalNavigation/Classes/BPKHorizontalNavigationTypes.swift",
    "Overlay/Classes/BPKOverlay.swift",
    "Overlay/Classes/BPKOverlayType.swift",
    "Overlay/Classes/GradientOverlay.swift",
    "Overlay/Classes/VignetteOverlay.swift",
    "PageIndicator/Classes/BPKPageIndicator.swift",
    "Price/Classes/BPKPrice.swift",
    "Rating/Classes/BPKRating.swift",
    "Rating/Classes/BPKRatingScale.swift",
    "Rating/Classes/BPKRatingSize.swift",
    "Skeleton/Classes/BPKCommonSkeleton.swift",
    "Skeleton/Classes/BPKShimmerOverlayView.swift",
    "Skeleton/Classes/BPKSkeleton.swift",
    "Skeleton/Classes/BPKSkeletonSize.swift",
    "Skeleton/Classes/BPKSkeletonStyle.swift",
    "Skeleton/Classes/BPKSkeletonType.swift",
    "Skeleton/Classes/BPKTextSkeleton.swift",
    "StarRating/Classes/BPKHotelStarRating.swift",
    "TabBarController/Classes/BPKTabBarController.swift",
    "TabBarController/Classes/BPKTabBarDotImageDefinition.swift",
    "TabBarController/Classes/BPKTabBarItem.swift"
]

let backpackSwiftTestSources: [String] = [
    "SnapshotTests/BPKBadgeSnapshotTest.swift",
    "SnapshotTests/BPKBarChartBarSnapshotTest.swift",
    "SnapshotTests/BPKBarChartSnapshotTest.swift",
    "SnapshotTests/BPKBottomSheetTest.swift",
    "SnapshotTests/BPKButtonSnapshotTests.swift",
    "SnapshotTests/BPKCardSnapshotTest.swift",
    "SnapshotTests/BPKCardWrapperSnapshotTests.swift",
    "SnapshotTests/BPKCarouselSnapshotTest.swift",
    "SnapshotTests/BPKChipSnapshotTest.swift",
    "SnapshotTests/BPKDialogViewSnapshotTest.swift",
    "SnapshotTests/BPKDividedCardSnapshotTest.swift",
    "SnapshotTests/BPKFlareViewSnapshotTest.swift",
    "SnapshotTests/BPKFlightLegSnapshotTest.swift",
    "SnapshotTests/BPKFloatingNotificationSnapshotTests.swift",
    "SnapshotTests/BPKGradientSnapshotTests.swift",
    "SnapshotTests/BPKHorizontalNavigationSnapshotTests.swift",
    "SnapshotTests/BPKHotelStarRatingSnapshotTests.swift",
    "SnapshotTests/BPKIconSnapshotTest.swift",
    "SnapshotTests/BPKIconViewSnapshotTest.swift",
    "SnapshotTests/BPKLabelSnapshotTest.swift",
    "SnapshotTests/BPKMapAnnotationSnapshotTest.swift",
    "SnapshotTests/BPKNavigationBarSnapshotTest.swift",
    "SnapshotTests/BPKOverlaySnapshotTest.swift",
    "SnapshotTests/BPKPageIndicatorSnapshotTest.swift",
    "SnapshotTests/BPKPriceSnapshotTest.swift",
    "SnapshotTests/BPKPrimaryGradientSnapshotTests.swift",
    "SnapshotTests/BPKProgressBarSnapshotTest.swift",
    "SnapshotTests/BPKRatingSnapshotTest.swift",
    "SnapshotTests/BPKSaveCardButtonSnapshotTest.swift",
    "SnapshotTests/BPKShareCardButtonSnapshotTest.swift",
    "SnapshotTests/BPKSkeletonSnapshotTests.swift",
    "SnapshotTests/BPKSpinnerSnapshotTest.swift",
    "SnapshotTests/BPKStarRatingSnapshotTest.swift",
    "SnapshotTests/BPKSwitchSnapshotTest.swift",
    "SnapshotTests/BPKTabBarControllerSnapshotTest.swift",
    "SnapshotTests/BPKTappableLinkLabelSnapshotTest.swift",
    "SnapshotTests/BPKTextFieldSnapshotTest.swift",
    "SnapshotTests/BPKTextViewSnapshotTests.swift",
    "SnapshotTests/BPKToastSnapshotTest.swift",
    "SnapshotTests/Helpers/BottomSheetTestListViewController.swift",
    "SnapshotTests/Helpers/BottomSheetTestViewController.swift",
    "SnapshotTests/Utils/AssertSnapshot.swift",
    "SnapshotTests/Utils/BPKIconsTestsUtils.swift",
    "SnapshotTests/Utils/FontStylesUtil.swift",
    "UnitTests/BPKBadgeTest.swift",
    "UnitTests/BPKButtonTest.swift",
    "UnitTests/BPKHorizontalNavigationTest.swift",
    "UnitTests/BPKSaveCardButtonTest.swift",
    "UnitTests/BPKShareCardButtonTest.swift",
    "UnitTests/BPKSkeletonTests.swift",
    "UnitTests/BPKTappableLinkLabelTest.swift",
    "UnitTests/BPKTextFieldTest.swift",
    "UnitTests/IconSwiftTest.swift"
]

let backpackObjCSources: [String] = [
    "Appearance/Classes",
    "BorderWidth/Classes",
    "Button/Classes",
    "Card/Classes",
    "Color/Classes",
    "DarkMode/Classes",
    "Dialog/Classes",
    "Duration/Classes",
    "FlareView/Classes",
    "Font/Classes",
    "Gradient/Classes",
    "Icon/Classes",
    "Label/Classes",
    "Map/Classes",
    "NavigationBar/Classes",
    "ProgressBar/Classes",
    "RTLSupport/Classes",
    "Radii/Classes",
    "Shadow/Classes",
    "Spacing/Classes",
    "Spinner/Classes",
    "StarRating/Classes",
    "Switch/Classes",
    "TappableLinkLabel/Classes",
    "TextField/Classes",
    "TextView/Classes",
    "Theme/Classes",
    "Toast/Classes",
    "Backpack.h",
    "Common.h"
]

let backpackSwiftUISources: [String] = [
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
    "Utils/Classes"
]

let backpackSwiftUIReadmes: [String] = {
    let targetRoot = "Backpack-SwiftUI"
    guard let subpaths = try? FileManager.default.subpathsOfDirectory(atPath: targetRoot) else {
        return []
    }
    return subpaths.filter { $0.hasSuffix("README.md") }
}()

let backpackSwiftUIExcludes = ["Blur/Classes/VariableBlur.metal"] + backpackSwiftUIReadmes

let backpackTargetExcludes = [
    "Tests"
]

let backpackObjCHeaderSearchPaths: [CSetting] = {
    let targetRoot = "Backpack"
    let fileManager = FileManager.default
    var directories = Set(
        backpackObjCSources.compactMap { relativePath -> String? in
            let absolutePath = targetRoot + "/" + relativePath
            var isDirectory: ObjCBool = false
            guard fileManager.fileExists(atPath: absolutePath, isDirectory: &isDirectory), isDirectory.boolValue else {
                return nil
            }
            return relativePath
        }
    )

    for path in directories where path.hasSuffix("/Classes") {
        let generatedPath = path + "/Generated"
        if fileManager.fileExists(atPath: targetRoot + "/" + generatedPath) {
            directories.insert(generatedPath)
        }
    }

    directories.insert(".")
    directories.insert("..")
    directories.insert("../.build/debug/Backpack_Common.build/include")
    directories.insert("../.build/release/Backpack_Common.build/include")
    directories.insert("../.build/arm64-apple-ios-simulator/debug/Backpack_Common.build/include")
    directories.insert("../.build/arm64-apple-ios-simulator/release/Backpack_Common.build/include")
    directories.insert("../.build/debug/Backpack.build/include")
    directories.insert("../.build/release/Backpack.build/include")
    directories.insert("../.build/arm64-apple-ios-simulator/debug/Backpack.build/include")
    directories.insert("../.build/arm64-apple-ios-simulator/release/Backpack.build/include")

    return directories.sorted().map { .headerSearchPath($0) } + [.define("BPK_SWIFT_PACKAGE")]
}()

let package = Package(
    name: "Backpack",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "Backpack", targets: ["Backpack"]),
        .library(name: "Backpack_Common", targets: ["Backpack_Common"]),
        .library(name: "Backpack_SwiftUI", targets: ["Backpack_SwiftUI"]),
        .library(name: "Backpack_Fonts", targets: ["Backpack_Fonts"])
    ],
    dependencies: [
        .package(url: "https://github.com/scenee/FloatingPanel", exact: "2.8.6"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.9.0")
    ],
    targets: [
        .target(
            name: "Backpack_Common",
            path: "Backpack-Common",
            exclude: [
                "Tests",
                "Icons/.DS_Store"
            ],
            resources: [
                .process("Icons/Assets")
            ]
        ),
        .target(
            name: "BackpackObjC",
            dependencies: [
                "Backpack_Common"
            ],
            path: "Backpack",
            exclude: backpackSwiftSources + backpackTargetExcludes,
            sources: backpackObjCSources,
            publicHeadersPath: ".",
            cSettings: backpackObjCHeaderSearchPaths,
            linkerSettings: [
                .linkedFramework("UIKit"),
                .linkedFramework("Foundation"),
                .linkedFramework("CoreText"),
                .linkedFramework("MapKit"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("CoreGraphics")
            ]
        ),
        .target(
            name: "Backpack",
            dependencies: [
                "BackpackObjC",
                "Backpack_Common",
                .product(name: "FloatingPanel", package: "FloatingPanel")
            ],
            path: "Backpack",
            exclude: backpackTargetExcludes,
            sources: backpackSwiftSources
        ),
        .target(
            name: "Backpack_SwiftUI",
            dependencies: [
                "Backpack_Common"
            ],
            path: "Backpack-SwiftUI",
            exclude: backpackSwiftUIExcludes,
            sources: backpackSwiftUISources,
            resources: [
                .process("Blur/Classes/VariableBlur.metal")
            ],
            linkerSettings: [
                .linkedFramework("SwiftUI")
            ]
        ),
        .target(
            name: "Backpack_Fonts",
            path: "Backpack-Fonts",
            exclude: [
                "Backpack-Fonts.podspec",
                "Scripts"
            ],
            sources: [
                "Sources"
            ],
            resources: [
                .process("Assets")
            ]
        ),
        .testTarget(
            name: "BackpackTests",
            dependencies: [
                "Backpack",
                "Backpack_Common",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            path: "Backpack/Tests",
            exclude: [
                "SnapshotTests/__Snapshots__"
            ],
            sources: backpackSwiftTestSources,
            resources: [
                .process("SnapshotTests/Images.xcassets")
            ]
        ),
        .testTarget(
            name: "BackpackCommonTests",
            dependencies: [
                "Backpack_Common"
            ],
            path: "Backpack-Common/Tests"
        ),
        .testTarget(
            name: "BackpackSwiftUITests",
            dependencies: [
                "Backpack_SwiftUI",
                "Backpack_Common",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            path: "Backpack-SwiftUI/Tests",
            resources: [
                .process("Images.xcassets")
            ]
        )
    ]
)
