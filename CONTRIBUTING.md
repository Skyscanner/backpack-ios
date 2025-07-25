# Contributing to Backpack
You want to help us enable Skyscanner to create beautiful, coherent products at scale? That's awesome! ❤️

## Table of contents

* [Prerequisites](#prerequisites)
* [Getting started](#getting-started)
* [Adding a new component](#adding-a-new-component)
* [How we review Backpack contributions](#how-we-review-backpack-contributions)
* [How to](#how-to)

## Prerequisites

### Licence
By contributing your code, you agree to license your contribution under the terms of the [APLv2](./LICENSE).

All files are released with the Apache 2.0 licence.

### Environment

We use asdf to manage our language runtimes. This will be installed when you run `./fullsetup`. All dependency versions are managed in `.tool-versions`
Use the version of Xcode specified in [our build pipeline](https://github.com/Skyscanner/backpack-ios/blob/main/.github/workflows/_build.yml#L136), however the project should work with old versions of the same major. 

### Code style

1. All new components are written in SwiftUI
1. We sparingly update Objective-c components to Swift (SwiftUI) version

Please follow the [Swift Style Guide](https://google.github.io/swift/) when writing Swift. Follow other conventions and patterns established in the source code already when the style-guide cannot help you. The goal is that the codebase should look like it was written by a single author.

## Getting started
Run the following commands from your terminal, these should be run from the root of the project. 

- `./fullsetup` to install all dependencies
- `open Example/Backpack.xcworkspace` to open the example project

## Adding a new component
If you want to add a new component, we will need the following:

- Design (Figma file)
- SwiftUI component
- Accessibility
- Stories
- Tests (unit & snapshot)
- Documentation (Including main `REAMDE.md`)

### Design

Figma is the preferred format for non-technical folks. We’d appreciate if you could provide an exact match of your component in Figma format together with examples for each state e.g. disabled, expanded etc.

### SwiftUI component

A component folder structure is setup as follows. Please take a look at the setup of existing components for examples. 

* Backpack-SwiftUI
    - {ComponentName}
        - Classes
            - BPK{ComponentName.swift}
            - {Any supporting swift files}
        - README.md
        
<details>
<summary>Example: Creating a new Badge component</summary>
        
```swift
/// A view that displays one line of text with an optional icon
/// By default the style of BPKBadge is set to `.normal`
///
/// Use `badgeStyle(_ style: BPKBadge.Style)` to change the style of the badge
///
public struct BPKBadge: View {
    private let title: String
    private let icon: BPKIcon?
    private var style: BPKBadge.Style = .normal
    
    public init(_ title: String, icon: BPKIcon? = nil) {
        self.title = title
        self.icon = icon
    }
    
    public var body: some View {
        content
            .padding([.leading, .trailing], .md)
            .padding([.top, .bottom], .sm)
            .frame(minHeight: 24)
            .background(style.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: .xs))
            .outline(style.borderColor, cornerRadius: .xs)
            .accessibilityElement()
            .accessibilityLabel(title)
            .if(!BPKFont.enableDynamicType, transform: {
                $0.sizeCategory(.large)
            })
    }
    
    /// Sets the style of the badge
    ///
    /// - Parameter style: The `BPKBadge.Style` to change the appearance
    ///   view.
    ///
    /// - Returns: A BPKBadge that uses the style you supply.
    public func badgeStyle(_ style: BPKBadge.Style) -> BPKBadge {
        var result = self
        result.style = style
        return result
    }
    
    public func createBadgeIconView(icon: BPKIcon?) -> BPKIconView? {
        guard let badgeIcon = icon else {
            switch style {
            case .success:
                return BPKIconView(BPKIcon.tickCircle, size: .small)
            case .warning:
                return BPKIconView(BPKIcon.informationCircle, size: .small)
            case .destructive:
                return BPKIconView(BPKIcon.exclamation, size: .small)
            default:
                return nil
            }
        }
        return BPKIconView(badgeIcon, size: .small)
    }
    
    private var content: some View {
        HStack(spacing: .sm) {
            if let badgeIconView = createBadgeIconView(icon: icon) {
                badgeIconView.foregroundColor(style.iconColor)
            }
            BPKText(title, style: .footnote)
                .foregroundColor(style.foregroundColor)
        }
    }
    public enum Style {
        case normal, strong, success, warning, destructive, inverse, outline, brand
    }
}


```
</details>
        

### Accessibility
All of our components must be accessible. 

The easiest way to achieve this is to consider different accessibility needs in the design stage. We follow WCAG 2.2 AA as a guiding standard and apply this to all of our components. 

At a mimimum you should make sure your component meets the following criteria:

* Colour contrast meets AA standard
* Required accessibility labels are passed to the component
* Screen readers can interact with the component
* The component can scale when the font-size increases

In SwiftUI, you must create at least one Accessibility snapshot that tests Dynamic Type, you can do this by adding a new test for your component. Below we included an example accessibility test.

<details>
<summary>Example: Creating an accessibility test for a Badge component</summary>

Here's an example of a simple accessibility test for the Badge component:

```swift
func test_accessibility() {
    let badge = BPKBadge("Test badge", icon: .accessibility)
    assertA11ySnapshot(badge)
}
```
</details>

### Stories
Each component needs to be visually documented in our example app. Make sure to add a new entry and showcase your component in each of its different states and variants.

<details>
<summary>Example: Creating a story for a Badge component</summary>

Here's an example of a complete story for the Badge component with multiple variants:

 ```swift
 struct BadgeExampleVIew: View {
    var body: some View {
        ZStack {
            Color(.canvasColor)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                makeBadgeRow(text: "Normal", icon: .tickCircle, style: .normal)
                makeBadgeRow(text: "Strong", icon: .tickCircle, style: .strong)
                makeBadgeRow(text: "Success", icon: .tickCircle, style: .success)
                makeBadgeRow(text: "Warning", icon: .informationCircle, style: .warning)
                makeBadgeRow(text: "Critical", icon: .exclamation, style: .destructive)
                makeBadgeRow(text: "Inverse", icon: .tickCircle, style: .inverse, background: .corePrimaryColor)
                makeBadgeRow(text: "Outline", icon: .tickCircle, style: .outline, background: .corePrimaryColor)
                makeBadgeRow(text: "Brand", icon: .priceTag, style: .brand)
                Spacer()
            }
        }
    }
    
    private func makeBadgeRow(
        text: String,
        icon: Backpack_SwiftUI.BPKIcon,
        style: Backpack_SwiftUI.BPKBadge.Style,
        background: Backpack_SwiftUI.BPKColor = .canvasColor
    ) -> some View {
        HStack {
            Spacer()
            if ![BPKBadge.Style.success, BPKBadge.Style.warning, BPKBadge.Style.destructive].contains(style) {
                BPKBadge(text)
                    .badgeStyle(style)
            } else {
                Spacer()
            }
            Spacer()
            BPKBadge(text, icon: icon)
                .badgeStyle(style)
            Spacer()
        }
        .padding()
        .background(background)
    }
}
 ```
 
 This story will need to be added to the ComponentCellsProvider struct
 
 ```swift
     private func badge() -> CellDataSource {
        ComponentCellDataSource(
            title: "Badges",
            tabs: [
                .swiftui(presentable: CustomPresentable(generateViewController: {
                    ContentUIHostingController(BadgeExampleVIew())
                }))
            ],
            showChildren: { showComponent(title: "Badges", tabs: $0) }
        )
    }
 ```
 
 Don't forget to add it to the cells' datasources
  
 ```swift
     func cells() -> [Components.Cell] {
        let dataSources: [CellDataSource] = [
            ...
            badge(),
            ...
            ]
        return dataSources.map(\.cell)
    }
 ```
 
</details>

### Tests
Our components need to be well tested. We require all business logic to be covered by unit tests. The component and all of its types and states need to be captured in Snapshot tests. Please review existing components to learn how we set up these tests.

Our CI runs on Intel hardware, so you might find your snapshots failing when recording them with an M1 Mac. If you have access to an Intel Mac, you can run the tests locally on that machine to avoid this issue.
Otherwise, please create a commit on your pull request with `Record snapshots` to trigger a Github Action that will re-record your snapshots. 

Once your snapshots are generated, please manually verify that they are correct before merging your pull request.

<details>
<summary>Example: Creating a snapshot test for a Badge component</summary>

Here's an example of a simple snapshot test for the Badge component:

 ```swift
     func test_badgeWithoutIcon() {
        // Then
        assertSnapshot(
                BPKBadge("Test badge", icon: nil)
            }
        )
    }
     
     func test_badgeWithIcon() {
        // Then
        assertSnapshot(
                BPKBadge("Test badge", icon: .tickCircle)
            }
        )
    }
 ```
For components with many variants, you can use parameterized tests:

```swift
       let styles: [(BPKBadge.Style, BPKColor)] = [
        (.normal, .surfaceDefaultColor),
        (.strong, .surfaceDefaultColor),
        (.success, .surfaceDefaultColor),
        (.warning, .surfaceDefaultColor),
        (.destructive, .surfaceDefaultColor),
        (.inverse, .surfaceHighlightColor),
        (.outline, .surfaceHighlightColor),
        (.brand, .surfaceDefaultColor)
    ]
    
    private func testView(icon: BPKIcon? = nil) -> some View {
        VStack(spacing: 0) {
            ForEach(styles, id: \.0) {
                BPKBadge("Test badge", icon: icon)
                    .badgeStyle($0.0)
                    .padding(4)
                    .background($0.1)
            }
        }
    }

    func test_allBadgesWithoutIcon() {
        // Then
        assertSnapshot(testView())
    }
    
    func test_allBadgesWithIcon() {
        // Then
        assertSnapshot(testView(icon: .tickCircle))
    }
 ```
 
 </details>

### Documentation
See our design system documentation at [skyscanner.design](https://www.skyscanner.design).

## How we review Backpack contributions

Please see the [code review guidelines](https://github.com/Skyscanner/backpack/blob/main/CODE_REVIEW_GUIDELINES.md).

## How to

<details>
    <summary>Testing</summary>

Tests can be run as usual from Xcode(Product -> Test or cmd+U). Snapshot tests should be run on the [device specified for CI](https://github.com/Skyscanner/backpack-ios/blob/main/scripts/ci#L7) with the Xcode version defined in [the _test.yml workflow](https://github.com/Skyscanner/backpack-ios/blob/main/.github/workflows/_test.yml#L62).
</details>

<details>
    <summary>Documentation screenshots</summary>

### Taking screenshots

The _screenshots_ folder stores all of the screenshots we use on the [documentation site](https://skyscanner.design). If you change the appearance of a component you must update the screenshots accordingly. To do this, run:

```
./scripts/take-screenshots
```

The script takes 10-15 minutes.

### Taking a subset of screenshots

It's possible to take only a subset of the screenshots which greatly speeds up the process.

To do this follow the following steps:


1. Update `Example/Backpack Screenshot/SwiftUIScreenshots` to capture screenshots of the new componenet. Please note that the screenshots will appear as they do in the component entry in (Stories)[https://github.com/Skyscanner/backpack-ios/blob/AlaaAmrAmin-patch-1/CONTRIBUTING.md#stories]. 
2. In `Example/Backpack Screenshot/BackpackSnapshotTestCase.swift` change the `runOnly` property per the guide in the comment.
3. Run the screenshots as above (using the `./scripts/take-screenshots` script)
4. Note that all other screenshots will be deleted in the process, so make sure you only commit the ones you generated not the deletions.
</details>

<details>
    <summary>Snapshot testing</summary>

Snapshot tests are used to capture images of components under different configurations. When you add or change a snapshot test, test images will need to be recaptured on CI to ensure consistency. Create an empty commit to regenerate snapshots:

```
git commit --allow-empty -m "record snapshots"
```

After checking on your PR that the new snapshots are as expected, create a new empty commit to rerun the tests on the CI

```
git commit --allow-empty -m "Retry"
```

If you want to test your snapshot tests locally change `isRecording = false` to `isRecording = true` in the relevant test file and re-run the tests on the [device specified for CI](https://github.com/Skyscanner/backpack-ios/blob/main/scripts/ci#L7). This will update the images on disk. Remember to revert `isRecording` and the snapshot updates afterwards otherwise the tests will fail. 
</details>

## And finally..

If you have any questions at all, don't hesitate to get in touch. We love to talk all things Backpack and we look forward to seeing your contribution!


## Skyscanner employees

<details>
    <summary>Relative font</summary>

Our fonts can only be used by Skyscanner employees. If you don't work for Skyscanner don't worry - the Example app will still work just fine with iOS system font too!

To use our `Skyscanner Relative` font-face in the example app do the following:

- Make sure you're connected to the VPN.
- If you've already done a `pod install`, delete `Example/Pods`.
- Set the environment variable using `export BPK_USE_RELATIVE=1`. (Put this in your `.bashrc`/`.zshrc` for convenience.)
- Setup the project as [above](#setup).

During pod install, fonts will be downloaded and made available to the project automatically.
</details>

<details>
    <summary>Upgrading Xcode / iOS</summary>

## Upgrading Xcode/iOS

As new versions of Xcode and iOS are released, we have to upgrade both to stay up to date with the main Skyscanner app, as well as what travellers are using. Our aim is to run our main test suite and snapshot tests on the dominate iOS version in use by Skyscanner travellers. At the time of a new release we continue to run our test suite on the previous major version until the new release has reached sufficient volume **and** the main app has moved to testing on the new version.

### How to upgrade

1. Change the value of `runs-on` in [`ci.yml`](./.github/workflows/ci.yml#26). The new value should be on of the [available environments](https://github.com/actions/virtual-environments/tree/main/images/macos) in GitHub Actions.
1. Update the `BUILD_SDK` variable in [`Rakefile`](./Rakefile#5) to the new build SDK we should use.
1. Update `correctMajorVersion` and `correctMinorVersion` in [`BPKSnapshotTest`](./Example/SnapshotTests/BPKSnapshotTest.h).
1. Update `expectedMajorVersion` and `expectedMinorVersion` in [`BPKSnapshotTest.swift`](./Example/SnapshotTests/BPKSnapshotTest.swift#26).
1. Run all snapshot tests.
1. **Review the failing snapshots thoroughly.** Most likely, all snapshots will have changed, **but** the diffs should be miniscule and mostly to do with changes in Apple's fonts.
1. **Run all snapshot tests in record mode.** At the time of writing this involves manually setting `recordMode` in every test case, we should have a better method than this, but alas we don't :(
1. Manually test the example app with the new version.
</details>

## Experimental changes

Want to run A/B experiments on features that entail changes to Backpack components? Continue reading below 👇

<details>
<summary>When is a component change considered experimental?</summary>

If the component or change you want to contribute to Backpack is not stable and it depends on the results of an experiment then it is considered experimental.

</details>

<details>
<summary>What do you need to do to mark a component or part of a component as experimental?</summary>

This will depend on what kind of change you are contributing.

**Patch and minor changes**

For patch and minor changes, you should use AppleDoc annotations. AppleDoc is a widely used and supported tool in the Swift ecosystem that allows developers to document their code. AppleDoc comments will be visible in Xcode.

**Major**

For major changes, you should create a new experimental V2 component. If the experiment is successful, the old component should be deprecated.

Any follow-up changes to experimental components will not be considered breaking.
</details>

<details>
<summary>When should documentation be created and published?</summary>

Each Bpk component has a corresponding README file which contains information about the component such as usage examples and API documentation. Our components' full documentation is at [skyscanner.design](https://www.skyscanner.design). New experimental components should have a README file, but don’t need to be published to [skyscanner.design](https://www.skyscanner.design). Make sure the README file reflects the component is experimental! When an experiment has run and is considered successful and so the change is stable, documentation can be published.

For changes to existing components, make sure the API documentation is updated to indicate if something is experimental.
    
Major changes will often require a migration guide. If an experiment is considered succesful, you should add a migration guide within the docs folder located in the respective component folder.

</details>

<details>
<summary>How long does experimentation code live in Backpack?</summary>

Experimentation code should be cleaned up at most 2 weeks after an experiment has completed. In the case of a successful experiment, annotations should be removed and documentation should be published. In the case of an unsuccessful experiment, the code should be removed altogether.
</details>

<details>
<summary>Examples</summary>

Here’s an end-to-end example on how to add an experimental prop to a Bpk component:

1. Reach out to Koala with the proposed change
2. Contribute code changes. Make sure the API table is updated too!
```swift
/// - Experiment: This property is experimental and subject to change. Use with caution
public var type: BPKChipType = .option {
    didSet {
        updateLookAndFeel()
    }
}
```
3. Released by Donburi
4. Adopt changes in project
5. Run experiment
    - if experiment is successful, publish documentation (only Donburi members) and remove experimental code.
    - if experiment is unsuccessful and further iterations are needed, repeat from step 2. Otherwise, remove experimental code. That’s all!
</details>


## Releasing
> Backpack team only

To issue a new release:
* Publish draft release

The release workflow will also trigger our design docs publish. If successful, you should see your component changes at [skyscanner.design](https://skyscanner.design).

 > Note: Don't forget that new components need to be added manually!

