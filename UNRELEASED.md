# Unreleased

> Place your changes below this line.
**Added:**

- Backpack/StarRating:
  - New `StarRating` component to display a rating between 0.0 and 5.0. See [Star rating on Backpack docs site](https://backpack.github.io/components/star-rating/?platform=ios).
- Backpack/Icon:
  - New `size` prop on `BPKIconView` to control icon size.
  - New `flipsForRightToLeft` prop on `BPKIconView` to support icons with a horizontal direction in a right to left environment.
  
  **Fixed:**
  - Backpack/Dialog:
  - Dialog now respects a user's preference for reduced motion and reduced transparency.

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
