# Unreleased
> Place your changes below this line.

**Breaking:**

- Backpack/HorizontalNavigation
  - `options` on `BPKHorizontalNavigation` is now an `NSArray<id<BPKHorizontalNavigationOptionType>> *` was previously `NSArray<BPKHorizontalNavigationOption *> *`.
  - `initWithOptions:selected:` on `BPKHorizontalNavigation` now takes `NSArray<id<BPKHorizontalNavigationOptionType>> *` as its first argument rather than `NSArray<BPKHorizontalNavigationOption *> *`.

**Added:**

- Backpack/HorizontalNavigation
  - Via `makeItem` in `BPKHorizontalNavigationOptionType` it's possible to provide custom rendering for the items in the horizontal navigation.
- Backpack/Calendar
  - Via `contentOffset` in `BPKCalendar` it's possible to modify the underlying collection view's content offset.

**Fixed:**

- Backpack/Calendar
  - Calendar now doesn't snap to month name when its height changes.

## How to write a good changelog entry
1. Add 'Breaking', 'Added' or 'Fixed' in bold depending on if the change will be major, minor or patch according to [semver](semver.org).
2. Add the package name.
3. Detail the changes. Write with the consumer in mind, what do they need to know. If it's patch, tell them what's changed. If it's minor, tell them what you've added and what it does for them. If it's breaking, tell them what they need to change. Link to examples on the [Backpack docs site](backpack.github.io) where possible.

Don't worry about adding the specific version number or the date. This will be done by a Backpack squad member as part of the release process.

## Example of a good changelog entry

See [`CHANGELOG.md`](CHANGELOG.md) for real-world examples of good changelog entries.

**Breaking:**

- Backpack/Icon:
  - Replaced `charmeleon` icon with new `charizard` icon. To upgrade, replace your references to `charmeleon` with `charizard`.
  - Upgraded `fire` dependency to `3.0.0`.

**Added:**

- Backpack/Gauntlet:
  - New `timeStone` prop for controlling time. See &lt;link to docs site&gt;.

**Fixed:**

- Backpack/Horcrux:
  - Fixed issue where `BpkHorcrux` would occasionally possess the living.
