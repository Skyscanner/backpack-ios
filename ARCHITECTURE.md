# Architecture

This project uses a mix of technologies and languages to achieve its goals. This document describes what those technologies are and their responsibilities.

## NPM 

**Relevant files/folders:** 
* [`package.json`](./package.json)
* [`package-lock.json`](./package-lock.json)
* `node_modules`

We use `npm` to pull in several dependencies, in particular, `@skyscanner/bpk-foundation-ios` and `@skycsanner/bpk-svgs`. These two packages contain the design system's tokens and icons respectively. We also use `npm` to run some tasks via its script system, most notably the `build` task which runs `gulp`.

## Gulp

**Relevant files/folders:** 
* [`gulpfile.js`](./gulpfile.js)
* `templates`

[Gulp](https://gulpjs.com/), a JavaScript task automator, is used to template out Objective-C files for the tokens so they can be consumed from Swift and Objective-C. By convention, files that are templated live in `Backpack/*/Classes/Generated`. Making manual changes to these files is not possible and any changes will be overwritten by Gulp. 

An example of templated files is: `Backpack/Color/Classes/Generated`, which contains our `BPKColor` class and extensions on `UIColor`.

The templates themselves are in `templates` and are called `*.{finalExtension}.njk`. These are [nunjucks](https://mozilla.github.io/nunjucks/) templates.

## Ruby and Bundler

**Relevant files/folders:** 

* [`Gemfile`](./Gemfile) Defines Ruby gems we use.
* [`Gemfile.lock`](./Gemfile.lock) Bundler, lockfile.
* [`Backpack.podspec`](./Backpack.podspec) the project's podspec, which defines the library for consumption via CocoaPods.

We use Ruby and [`Bundler`](https://bundler.io/) to perform most other automation and management of the project. The three most important gems we use are:

* `cocoapods` publishing the project, hosting the example project.
* `fastlane` iOS project automation, used for taking our screenshots.
* `jazzy` generates static HTML documentation from our reference docs, which is published at https://backpack.github.io/ios.

We have a fair amount of automation in `Rakefile` that might be more suited for `fastlane` e.g. building the project, running the tests, etc.
