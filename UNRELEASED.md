# Unreleased

### 8.0.0

**Breaking:**

- Backpack/Theme
  - Theme container classes are no longer exposed by Backpack/Theme. Instead they must be accessed using the `container` method of the themes.

**Changed:**

- Backpack/Calendar
  - New selection mechanism where every selection after a range defined clears the previously selected range
