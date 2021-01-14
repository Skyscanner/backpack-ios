# Unreleased

> Place your changes below this line.
**Added:**

- Backpack/BottomSheet:
  - New style of presentation to BottomSheet. Now we are capable to present it modally or persistently by using the `init` parameter `presentationStyle` being `.persistent` or `.modal`
  - Added an Example of usage in the Example App

**Fixed:**

- Upgrade `FloatingPanel` version to 1.7.5


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

**Added:**

- Backpack/Calendar:
  - New `timeStone` prop for controlling time. See &lt;link to docs site&gt;.

**Fixed:**

- Backpack/Dialog:
  - Fixed an issue that allowed a `Horcrux` to be contained in a `BPKDialog`.