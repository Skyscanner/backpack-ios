// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "Backpack",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(name: "Backpack-Common", targets: ["BackpackCommon"]),
    .library(name: "Backpack-SwiftUI", targets: ["BackpackSwiftUI"]),
  ],
  dependencies: [
    // Only needed for SwiftUI test target
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.9.0")
  ],
  targets: [

    // MARK: - BackpackCommon (source-based)
    .target(
      name: "BackpackCommon",
      path: "Backpack-Common",
      exclude: [
        "Tests"
      ],
      sources: [
        "BackpackCommonImports.swift",
        "BPKCommonBundle.swift",
        "BPKCommonRatingScale.swift",

        "Carousel/Classes",
        "Configuration/Classes",
        "Icons/Generated"
      ],
      resources: [
        .process("Icons/Assets")
      ]
    ),

    // MARK: - BackpackSwiftUI (depends on BackpackCommon)
    .target(
      name: "BackpackSwiftUI",
      dependencies: ["BackpackCommon"],
      path: "Backpack-SwiftUI",
      exclude: [
        "Tests"
      ],
      sources: [
        "BackpackSwiftUIImports.swift",
        "Color/Classes",
      ]
    ),

    // MARK: - Tests
    .testTarget(
      name: "BackpackCommonTests",
      dependencies: ["BackpackCommon"],
      path: "Backpack-Common/Tests"
    ),

  ],
  swiftLanguageVersions: [.v5]
)
