# Unreleased
> Place your changes below this line.

**Deprecated:**
- Backpack/Calendar
  - `calendar:titleColorForDate:` in `BPKCalendarDelegate` has been deprecated in favour of `calendar:cellStyleForDate:`.
  - `calendar:fillColorForDate:` in `BPKCalendarDelegate` has been deprecated in favour of `calendar:cellStyleForDate:`.

**Added:**

- Backpack/Calendar
  - Added a new preferred method for coloured dates in the calendar via `BPKCalendarDateCellStyle` and the new delegate method `calendar:cellStyleForDate:`. Code that previously used `calendar:fillColorForDate:` and `calendar:titleColorForDate:` to colour code the calender to show price information should switch to this new method instead. When implementing `calendar:cellStyleForDate:` it's possible to fall back to the old delegate methods by returning `BPKCalendarDateCellStyleCustom` in which case the calendar will call these methods on the delegate to style the cell.

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
