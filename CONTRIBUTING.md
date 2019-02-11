# Contributing

In this document we describe how to setup this repository for development and the release process.

## Codestyle

Please follow the [New York Times Objective-C style-guide](https://github.com/NYTimes/objective-c-style-guide) when writing Objective-C. Follow other conventions and patterns established in the source code already when the style-guide cannot help you. The goal is that the codebase should look like it was written by a single author.

Wrap all Objective-C in `NS_ASSUME_NONNULL_BEGIN` and `NS_ASSUME_NONNULL_END` blocks. Make sure to annotate any types that are nullable correctly.

## Environment

We use both Ruby and Node in this project. To manage these language runtimes we recommend using [`rbenv`][0] and [`nvm`][1] respectively. You should ensure you have these installed or some other means of handling Ruby and Node versions. The required ruby version is specified in `.ruby-version` and the Node version is in `.nvmrc`.

With `rbenv` use `rbenv install` to install the project's version of Ruby. For `nvm` use `nvm use`. Also ensure you install `bundler` for Ruby with `gem install bundler`.

Use the most recent stable version of Xcode, however the project should work with old verisons of the same major.

## Setup

Given that you have a compatible environment as stated above you can now setup the project.

+ `bundle install` to install ruby dependencies
+ `npm install` to install npm dependencies
+ `(cd Example && bundle exec pod install)` To setup the example project.
+ `open Example/Backpack.xcworkspace` to open the example project

## Testing

Tests can be ran as usual from Xcode(Product -> Test or cmd+U). Snapshot tests should be run on a 2x device otherwise they will fail.

## Git

Please submit your requested changes as a pull request to the `master` branch. If your branch becomes out of date and conflicts need to be resolved with `master` use `git rebase`, do not merge `master` into your feature branch.

## Releasing

> Backpack team only

To issue a new release make sure you've set the project up as above, that you have push access to the Backpack CocoaPod and that you're logged in to [CocoaPods trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk.html#getting-started). `bundle exec pod trunk me` should print **your info** and include the **Backpack pod** in the output.

Move all the entries from the `UNRELEASED.md` file to the `CHANGELOG.md` and add them under the header with the new version you're about to publish. **Do not commit these changes** (leave them unstaged) and run `bundle exec rake release`.


[0]: https://github.com/rbenv/rbenv
[1]: https://github.com/creationix/nvm
