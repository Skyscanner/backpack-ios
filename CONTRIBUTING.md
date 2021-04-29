# Contributing

In this document we describe how to setup this repository for development and the release process.

## Code style

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

+ `bundle install` to install ruby dependencies
+ `npm install` to install npm dependencies
+ `(cd Example && bundle exec pod install)` To setup the example project.
+ `open Example/Backpack.xcworkspace` to open the example project

## Relative Font

> Skyscanner employees only

To use our `Skyscanner Relative` font-face in the example app, download the files first by executing the script below from the top level of the repo. You will need SSH access to `github.skyscannertools.net` to do this.

If you don't work for Skyscanner don't worry - the Example app will still work just fine with iOS system font too!

```
./scripts/download-relative-fonts
```

Once the fonts are downloaded, add them to the Xcode project under _Example for Backpack/Resources_. To do this, right click on _Resources_, press _Add files to "Backpack"_ and add them.

## Testing

Tests can be run as usual from Xcode(Product -> Test or cmd+U). Snapshot tests should be run on an iPhone 8 running iOS 13.5 to match what is used on CI.

## Taking screenshots

The _screenshots_ folder stores all of the screenshots we use on the [documentation site](https://backpack.github.io). If you change the appearance of a component you must update the screenshots accordingly. To do this, run:

```
bundle exec rake take_screenshots
```

The script takes 10-15 minutes.

### Snapshot testing

Snapshot tests are used to capture images of components under different configurations. When you add or change a snapshot test, test images will need to be recaptured. To do this, change `self.recordMode = NO` to `self.recordMode = YES` in the relevant test file and re-run the tests on an iPhone 8 running iOS 13.5. This will update the images on disk. Remember to revert `recordMode` afterwards otherwise the tests will fail.

## Git

Please submit your requested changes as a pull request to the `main` branch. If your branch becomes out of date and conflicts need to be resolved with `main` use `git rebase`, do not merge `main` into your feature branch.

Write your commit messages using imperative mood and in general follow the rules in [How to Write a Good Commit Message](https://chris.beams.io/posts/git-commit/)

## Releasing

> Backpack team only

To issue a new release make sure you've set the project up as above, that you have push access to the Backpack CocoaPod and that you're logged in to [CocoaPods trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk.html#getting-started). `bundle exec pod trunk me` should print **your info** and include the **Backpack pod** in the output.

Move all the entries from the `UNRELEASED.md` file to the `CHANGELOG.md` and add them under the header with the new version you're about to publish. **Do not commit these changes** (leave them unstaged) and run `bundle exec rake release`.

[0]: https://github.com/rbenv/rbenv
[1]: https://github.com/creationix/nvm
