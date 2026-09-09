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

Run them with:

```bash
xcodebuild test \
  -workspace .swiftpm/xcode/package.xcworkspace \
  -scheme Backpack-Package \
  -destination 'platform=iOS Simulator,name=iPhone SE (3rd generation),OS=18.5'
```

`.swiftpm/xcode/package.xcworkspace` is generated, not committed. The
[`spm-setup`](../../.github/actions/spm-setup/action.yml) action creates it in CI;
`scripts/build-docs` creates it too.

### Snapshots

Reference images live in `__Snapshots__` directories next to the tests.
[swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) resolves them from
the source tree via `#file`, so they are deliberately **not** bundled as target resources.

Snapshots are sensitive to both the simulator runtime and the SDK the tests are compiled against.
CI pins Xcode 16.4 and iOS 18.5; a local run on a different Xcode can produce differences that are
not real regressions. To re-record, push a commit titled `Record snapshots` and the
[snapshot workflow](../../.github/workflows/snapshot.yml) will update and commit them.

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
