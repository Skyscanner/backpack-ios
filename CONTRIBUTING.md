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
Use the version of Xcode specified in [our build pipeline](https://github.com/Skyscanner/backpack-ios/blob/main/.github/workflows/_build.yml#L131), however the project should work with old versions of the same major. 

### Code style

1. All new components are written in Swift
1. We sparingly update Objective-c components and rather upgrade to Swift with UIKit or provide a SwiftUI version

Please follow the [Swift Style Guide](https://google.github.io/swift/) when writing Swift. Follow other conventions and patterns established in the source code already when the style-guide cannot help you. The goal is that the codebase should look like it was written by a single author.

## Getting started
Run the following commands from your terminal, these should be run from the root of the project. 

- `./fullsetup` to install all dependencies
- `open Example/Backpack.xcworkspace` to open the example project

## Adding a new component
If you want to add a new component, we will need the following:

- Design (Figma file)
- UIKit or SwiftUI component
- Accessibility
- Stories
- Tests (unit & snapshot)
- Documentation (Including main `REAMDE.md`)

### Design

Figma is the preferred format for non-technical folks. We’d appreciate if you could provide an exact match of your component in Figma format together with examples for each state e.g. disabled, expanded etc.

### UIKit and SwiftUI component

Make sure that when you contribute you are considering a UIKit and a SwiftUI version of your component. The UIKit component should live in the Backpack folder. A SwiftUI component needs to be located in Backpack-SwiftUI.

A component folder structure is setup as follows. Please take a look at the setup of existing components for examples. 

* Backpack
    - {ComponentName}
        - Classes
            - BPK{ComponentName.swift}
            - {Any supporting swift files}
        - README.md

For SwiftUI the root folder will be `Backpack-SwiftUI`. The structure is otherwise the same.

### Accessibility
All of our components must be accessible. 

The easiest way to achieve this is to consider different accessibility needs in the design stage. We follow WCAG 2.2 AA as a guiding standard and apply this to all of our components. 

At a mimimum you should make sure your component meets the following criteria:

* Colour contrast meets AA standard
* Required accessibility labels are passed to the component
* Screen readers can interact with the component
* The component can scale when the font-size increases

In SwiftUI, you must create at least one Accessibility snapshot that tests Dynamic Type, you can do this by adding a new test for your component. Below we included an example accessibility test.

```swift
func test_accessibility() {
    let badge = BPKBadge("Test badge", icon: .accessibility)
    assertA11ySnapshot(badge)
}
```

### Stories
Each component needs to be visually documented in our example app. Make sure to add a new entry and showcase your component in each of its different states and variants. 

### Tests
Our components need to be well tested. We require all business logic to be covered by unit tests. The component and all of its types and states need to be captured in Snapshot tests. Please review existing components to learn how we set up these tests.

Our CI runs on Intel hardware, so you might find your snapshots failing when recording them with an M1 Mac. If you have access to an Intel Mac, you can run the tests locally on that machine to avoid this issue.
Otherwise, please create a commit on your pull request with `Record snapshots` to trigger a Github Action that will re-record your snapshots. 

Once your snapshots are generated, please manually verify that they are correct before merging your pull request.

### Documentation
See our design system documentation at [skyscanner.design](https://www.skyscanner.design).

## How we review Backpack contributions

Please see the [code review guidelines](https://github.com/Skyscanner/backpack/blob/main/CODE_REVIEW_GUIDELINES.md).

## How to

<details>
    <summary>Testing</summary>

Tests can be run as usual from Xcode(Product -> Test or cmd+U). Snapshot tests should be run on the [device specified for CI](https://github.com/Skyscanner/backpack-ios/blob/main/scripts/ci#L7).
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


1. In `Example/Backpack Screenshot/BackpackSnapshotTestCase.swift` change the `runOnly` property per the guide in the comment.
2. Run the screenshots as above
3. Note that all other screenshots will be deleted in the process, so make sure you only commit the ones you generated not the deletions.
</details>

<details>
    <summary>Snapshot testing</summary>

Snapshot tests are used to capture images of components under different configurations. When you add or change a snapshot test, test images will need to be recaptured on CI to ensure consistency. Create an empty commit to regenerate snapshots:

```
git commit --allow-empty -m "record snapshots"
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
3. Released by Koala
4. Adopt changes in project
5. Run experiment
    - if experiment is successful, publish documentation (only Koala members) and remove experimental code.
    - if experiment is unsuccessful and further iterations are needed, repeat from step 2. Otherwise, remove experimental code. That’s all!
</details>


## Releasing
> Backpack team only

To issue a new release:
* Publish draft release

The release workflow will also trigger our design docs publish. If successful, you should see your component changes at [skyscanner.design](https://skyscanner.design).

 > Note: Don't forget that new components need to be added manually!

