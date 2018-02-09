# Unreleased

**Fixed:**

- Ensure that the root pod spec can be used and that the `Backpack/Backpack.h` import works as expected.

# 0.5.0

**Added:**

- Backpack shadows via `BPKShadow` and the `Backpack/Shadow` subpsec.

## 0.4.0

**Added:**

- Backpack radii constants via `BpkRadii` and the `Backpack/Radii` subspec.

## 0.3.0

**Added:**

- Backpack spacing constants via `BpkSpacing` and the `Backpack/Spacing` subspec.

## 0.2.0

**Added:**

- Introduced Backpack Font stack via `BPKFont` and the `Backpack/Font` subspec.

## 0.1.0

**Breaking:**

- Moved colors to a subspec in `Backpack/Color`.

Use as

```
#import <Backpack/Color.h>

[BPKColor colorBlue500];
```

## 0.0.2

Dummy release to test, release automation.

## 0.0.1

Initial release of Backpack for iOS featuring color tokens. Usage

```
#import <Backpack/Backpack.h>

[BPKColor colorBlue500];
```
