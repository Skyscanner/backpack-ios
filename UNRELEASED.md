# Unreleased
> Place your changes below this line.

**Breaking:**
- Backpack/Button:
  - The title only button no longer hides the title when in the loading state, instead it grows and adds the spinner next to the title like the text + icon variant.

- Backpack/BottomSheet
  - Renamed `BottomSheet` class to `BPKBottomSheet` in Swift to be consistent with other components.
  - Renamed `BackpackFloatingPanelController` class to `BPKFloatingPanelController` in Swift to be consistent with other components.

- Backpack/Theme
- Backpack/TappableLinkLabel
  - Removed some long-deprecated methods.

**Added:**
- Backpack/FlareView
  - Added option for displaying the pointer at the top of the view instead of the bottom.

**Fixed**
- Backpack/TabBarController:
  - Fixed a typo in the component class name.

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
