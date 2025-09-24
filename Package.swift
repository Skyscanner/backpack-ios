// swift-tools-version: 5.9
import PackageDescription

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
    "Button/Classes/BPKButtonAppearanceSets.swift",
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

let backpackObjCExcludes = ["Tests"] + backpackSwiftSources

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
            path: "Backpack",
            exclude: backpackObjCExcludes,
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath(".")
            ],
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
            sources: backpackSwiftSources
        ),
        .target(
            name: "Backpack_SwiftUI",
            dependencies: [
                "Backpack_Common"
            ],
            path: "Backpack-SwiftUI",
            exclude: [
                "Tests"
            ],
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
