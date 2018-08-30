# Contributing

In this document we describe how to setup this repository for development and the release process.

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

## Releasing

> Backpack team only

To issue a new release make sure you've set the project up as above, that you have push acess to the Backpack CocoaPod and that you're logged in to CocoaPods trunk. `bundle exec pod trunk me` should print your info and including the Backpack pod in the output. Make sure you've added a new entry in the `CHANGELOG.md` with the version you're publishing then run `bundle exec rake release`.


[0]: https://github.com/rbenv/rbenv
[1]: https://github.com/creationix/nvm
