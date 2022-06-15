# Contributing

In this document we describe how to setup this repository for development and the release process.

## Code style

**All new components should be written in Swift.**

Please follow the [New York Times Objective-C style-guide](https://github.com/NYTimes/objective-c-style-guide) when writing Objective-C. Follow other conventions and patterns established in the source code already when the style-guide cannot help you. The goal is that the codebase should look like it was written by a single author.

Wrap all Objective-C in `NS_ASSUME_NONNULL_BEGIN` and `NS_ASSUME_NONNULL_END` blocks. Make sure to annotate any types that are nullable correctly.

## How we review Backpack contributions

Please see the [code review guidelines](https://github.com/Skyscanner/backpack/blob/main/CODE_REVIEW_GUIDELINES.md).

## Environment

We use both Ruby and Node in this project. To manage these language runtimes we recommend using [`rbenv`][0] and [`nvm`][1] respectively. You should ensure you have these installed or some other means of handling Ruby and Node versions. The required ruby version is specified in `.ruby-version` and the Node version is in `.nvmrc`.

With `rbenv` use `rbenv install` to install the project's version of Ruby. For `nvm` use `nvm use`. Also ensure you install `bundler` for Ruby with `gem install bundler`.

Use the most recent stable version of Xcode, however the project should work with old versions of the same major.

## Setup

Given that you have a compatible environment as stated above you can now setup the project.

- `bundle install` to install ruby dependencies
- `npm install` to install npm dependencies
- If you work for Skyscanner, [configure relative](#relative-font) (optional).
- `(cd Example && bundle exec pod install)` To setup the example project.
- `open Example/Backpack.xcworkspace` to open the example project

## Relative Font

> Skyscanner employees only

Our fonts can only be used by Skyscanner employees. If you don't work for Skyscanner don't worry - the Example app will still work just fine with iOS system font too!

To use our `Skyscanner Relative` font-face in the example app do the following:

- Make sure you're connected to the VPN.
- If you've already done a `pod install`, delete `Example/Pods`.
- Set the environment variable using `export BPK_USE_RELATIVE=1`. (Put this in your `.bashrc`/`.zshrc` for convenience.)
- Setup the project as [above](#setup).

During pod install, fonts will be downloaded and made available to the project automatically.

## Testing

Tests can be run as usual from Xcode(Product -> Test or cmd+U). Snapshot tests should be run on the [device specified for CI](https://github.com/Skyscanner/backpack-ios/blob/main/.github/workflows/ci.yml#L132).

## Taking screenshots

The _screenshots_ folder stores all of the screenshots we use on the [documentation site](https://backpack.github.io). If you change the appearance of a component you must update the screenshots accordingly. To do this, run:

```
bundle exec rake take_screenshots
```

The script takes 10-15 minutes.

### Taking a subset of screenshots

It's possible to take only a subset of the screenshots which greatly speeds up the process.

To do this follow the following steps:


1. In `Screenshots.swift` change the `runOnly` property per the guide.
2. Run the screenshots as above
3. Note that all other screenshots will be deleted in the process, so make sure you only commit the ones you generated not the deletions.

### Snapshot testing

Snapshot tests are used to capture images of components under different configurations. When you add or change a snapshot test, test images will need to be recaptured. To do this, change `self.recordMode = NO` to `self.recordMode = YES` in the relevant test file and re-run the tests on the [device specified for CI](https://github.com/Skyscanner/backpack-ios/blob/main/.github/workflows/ci.yml#L132). This will update the images on disk. Remember to revert `recordMode` afterwards otherwise the tests will fail.

## Git

Please submit your requested changes as a pull request to the `main` branch. If your branch becomes out of date and conflicts need to be resolved with `main` use `git rebase`, do not merge `main` into your feature branch.

Please add the correct label to your PR:

* major, A breaking change or new component
* minor, A non-breaking change
* patch, A fixed bug or updates to documentation

Write your commit messages using imperative mood and in general follow the rules in [How to Write a Good Commit Message](https://chris.beams.io/posts/git-commit/)

## Upgrading Xcode/iOS

As new versions of Xcode and iOS are released, we have to upgrade both to stay up to date with the main Skyscanner app, as well as what travellers are using. Our aim is to run our main test suite and snapshot tests on the dominate iOS version in use by Skyscanner travellers. At the time of a new release we continue to run our test suite on the previous major version until the new release has reached sufficient volume **and** the main app has moved to testing on the new version.

### How to upgrade

1. Change the value of `runs-on` in [`ci.yml`](./.github/workflows/ci.yml#26). The new value should be on of the [available environments](https://github.com/actions/virtual-environments/tree/main/images/macos) in GitHub Actions.
1. Update the `BUILD_SDK` variable in [`Rakefile`](./Rakefile#5) to the new build SDK we should use.
1. Update `correctMajorVersion` and `correctMinorVersion` in [`BPKSnapshotTest.`](./Example/SnapshotTests/BPKSnapshotTest.h).
1. Update `expectedMajorVersion` and `expectedMinorVersion` in [`BPKSnapshotTest.swift`](./Example/SnapshotTests/BPKSnapshotTest.swift#26).
1. Run all snapshot tests.
1. **Review the failing snapshots thoroughly.** Most likely, all snapshots will have changed, **but** the diffs should be miniscule and mostly to do with changes in Apple's fonts.
1. **Run all snapshot tests in record mode.** At the time of writing this involves manually setting `recordMode` in every test case, we should have a better method than this, but alas we don't :(
1. Manually test the example app with the new version.

## Releasing

> Backpack team only

To issue a new release:

* Publish draft release

[0]: https://github.com/rbenv/rbenv
[1]: https://github.com/creationix/nvm
