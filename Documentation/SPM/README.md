# Swift Package Manager

Backpack is built, tested, documented and released as a Swift package. This directory holds the
documentation for that setup.

- [CI performance](ci-performance.md) — what removing the CocoaPods pipeline changed, measured.

## Layout

The package manifest is [`Package.swift`](../../Package.swift) at the repository root. It exposes
four products:

| Product | Target | Source |
| --- | --- | --- |
| `Backpack` | `Backpack` | UIKit components (Swift), on top of `Backpack_ObjC` |
| `Backpack-SwiftUI` | `Backpack_SwiftUI` | SwiftUI components |
| `Backpack-Common` | `Backpack_Common` | Shared configuration, icons, carousel |
| `Backpack-Fonts` | `Backpack_Fonts` | Resource-only target for the Relative fonts |

Two internal targets support them: `Backpack_ObjC` (the Objective-C components) and
`Backpack_Tokens` (generated design tokens).

## Working locally

```bash
./fullsetup
open Example/Backpack-SPM.xcworkspace
```

The Example app's `Backpack-Native` target downloads the proprietary Relative fonts as a build
phase, so Skyscanner employees on the VPN get them on first build. Everyone else gets the system
font, and the app still works.

To work on the package itself rather than the Example app, open `Package.swift` directly.

## Tests

Five test targets, all run by the `Backpack-Package` scheme:

| Target | Path | Covers |
| --- | --- | --- |
| `BackpackTests` | `Backpack/Tests/UnitTests` | UIKit unit tests (Swift) |
| `BackpackObjCTests` | `Backpack/Tests/UnitTests/ObjC` | UIKit unit tests (Objective-C) |
| `BackpackSnapshotTests` | `Backpack/Tests/SnapshotTests` | UIKit snapshot tests |
| `BackpackSwiftUITests` | `Backpack-SwiftUI/Tests` | SwiftUI unit and snapshot tests |
| `BackpackCommonTests` | `Backpack-Common/Tests` | Shared code |

The Objective-C unit tests live in their own directory because SwiftPM targets are single-language:
a directory holding both `.swift` and `.m` fails to build.

The build, unit test, and snapshot jobs use **Xcode 26.2** and an **iPhone 12 mini
running iOS 26.2** on an arm64 macOS runner. This matches the Skyscanner app's
`ios-tests` job on `develop`. Update [`scripts/ios-ci-config`](../../scripts/ios-ci-config)
when that test environment moves.

For a local run, select Xcode 26.2, then run the following from the repository root
with `jq` installed:

```bash
simulator_id=$(./scripts/install-sim)
mkdir -p .swiftpm/xcode/package.xcworkspace
printf '%s\n' '<Workspace version="1.0"><FileRef location="self:"/></Workspace>' \
  > .swiftpm/xcode/package.xcworkspace/contents.xcworkspacedata
./scripts/test-ios --destination "platform=iOS Simulator,arch=arm64,id=$simulator_id"
```

`.swiftpm/xcode/package.xcworkspace` is generated, not committed. The
[`ios-setup`](../../.github/actions/ios-setup/action.yml) action creates it for
the package build and tests. `scripts/build-docs` also creates it when needed.

### Snapshots

Reference images live in `__Snapshots__` directories next to the tests.
[swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) resolves them from
the source tree via `#file`, so they are deliberately **not** bundled as target resources.

The test script supplies a small app host for snapshots of switches and the UIKit tab bar.
On iOS 26, these controls need a window to capture the switch thumb and tab contents.
Xcode's standalone package test run skips these snapshots. Use the script to run the full suite.

The simulator runtime, device, and Xcode SDK all affect rendering. To refresh
references on the canonical environment, push a commit titled `Record snapshots`
to an open Backpack PR. An empty commit is enough. The
[snapshot workflow](../../.github/workflows/snapshot.yml) records the UIKit and
SwiftUI PNGs and pushes them to the PR branch. Review the generated changes and
check that the normal test run on the new commit passes.

## CI

| Workflow | Job | Does |
| --- | --- | --- |
| `_build.yml` | `Setup` | Installs node and ruby via asdf |
| | `Lint` | npm build, clang-format, SwiftLint, Danger |
| | `BuildSwiftPackage` | Builds the package (`_spm-build.yml`) |
| | `BuildExampleApp` | Builds the Example app (`scripts/ci`) |
| | `Test` | Runs the package tests (`_test.yml`) |
| `_build-docs.yml` | `BuildDocs` | sourcekitten + jazzy against the package |

The SwiftPM jobs deliberately do not declare `needs: [Setup]` — they need neither node nor ruby, so
making them wait would put the Setup job on the critical path for no reason.

## CocoaPods

CocoaPods support has been removed. `92.1.0` was the last version published to the trunk; the
podspecs and the publishing jobs are gone. Versions already on the trunk stay installable, so
existing Podfiles keep working, they just stop receiving updates. See the
[README](../../README.md#cocoapods-removed) for what consumers should do.

There is no longer a `#if SWIFT_PACKAGE` branch anywhere in the sources: resources resolve through
`Bundle.module`, and headers import through the package's own module paths.
