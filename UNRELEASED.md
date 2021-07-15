# Unreleased
> Place your changes below this line.

**Breaking:**

- Backpack/HorizontalNavigation:
  - Migrated the component to Swift. This has caused regressions in the Objective-C capabilities of the component. 
  - In Objective-C only the default size of the component is now available.
  - In Objective-C some options are no longer supported e.g. the ability to show a notification dot and the support for badges.
  - The component adopts the new `BPKIcon` API and enforces the correct usage of icons with the appropriate horizontal navigation size at compile time.
  - Due to a bug in Swift/UIKit with generic views the component no longer supports theming. Theming can still be achieved with an explicit wrapping view that integrates with `UIAppearance`.
- Backpack/Chip:
  - The type of `iconName` has changed from the deprecated `BPKIconName` to `BPKIconNameLarge`. Some icons previously used might to be available.

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
