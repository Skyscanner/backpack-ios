# Backpack

[![CI Status](http://img.shields.io/travis/skyscanner/backpack-ios.svg?style=flat)](https://travis-ci.org/skyscanner/backpack-ios)
[![Version](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](http://cocoapods.org/pods/Backpack)
[![License](https://img.shields.io/cocoapods/l/Backpack.svg?style=flat)](http://cocoapods.org/pods/Backpack)
[![Platform](https://img.shields.io/cocoapods/p/Backpack.svg?style=flat)](http://cocoapods.org/pods/Backpack)

## Installation

Backpack is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Backpack'
```


## Setup

This project uses both Ruby and Node. To manage the version of these we use `rbenv` for Ruby and `nvm` for Node. Please ensure you have both of these installed. Then run:

+ `rbenv install` to install the required version of Ruby
+ `nvm use` to set the projects node version
+ `bundler install` to install ruby dependencies
+ `npm install` to install npm dependencies
+ `(cd Example && bundle exec pod install)` To setup the example project.
+ `open Example/Backpack.xcworkspace` to open the example project

## Releasing

> Backpack team only

To issue a new release make sure you've set the project up as above, that you have push acess to the Backpack CocoaPod and that you're logged in to CocoaPods trunk. `bundle exec pod trunk me` should print your info and including the Backpack pod in the output. Make sure you've added a new entry in the `CHANGELOG.md` with the version you're publishing then run `be rake release`.

## License

Backpack is available under the Apache 2.0 license. See the LICENSE file for more info.
