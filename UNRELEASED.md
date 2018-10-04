# Unreleased

**Breaking:**

- Backpack/Card:
  - Backpack Card no longer allows `addSubview` to be used. Instead, Cards have a `subview` property that can be set.

**Fixed:**

- Backpack/Card:
  - Non-padded cards will now correctly clip bounds of items placed inside.

**Added:**

- Backpack/Card:
  - Divided cards now expose `primarySubview` and `secondarySubview` properties
