# Unreleased

**Added:**

- Backpack/Calendar:
  - Added accessibility labels to `BPKCalendar` cells to provide month and year context to screen-readers.

- Backpack/Theme:
  - `BPKThemeContainerController` now returns `self.rootViewController` for `forwardingTargetForSelector:` this improves code that makes assumptions about the specific methods available on `keyWindow.rootViewController` when the previous `rootViewController` is wrapped in a `BPKThemeContainerController`. In debug builds this will cause an assertion error as it is not a behaviour we encourage relying on.

