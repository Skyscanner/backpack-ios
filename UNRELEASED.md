# Unreleased

**Fixed:**

- Backpack/TappableLinkLabel:
  - Prevent cutting off parts of text with larger fonts.

**Added:**

- Backpack/TappableLinkLabel:
  - Added method for adding a link with Transit Information (an `NSDictionary`) instead of creating with a URL.
  - New `style` property which can be used when placing the link label over a blue/dark background.
  - Added `numberOfLines` property.

> Place your changes below this line.

**Fixed:**

- Backpack/Button
  - Icon-only buttons are now always circular regardless of the `cornerRadius` appearance setting.


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
