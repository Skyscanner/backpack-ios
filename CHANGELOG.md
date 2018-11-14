# Backpack iOS changelog

[Unreleased changes](./UNRELEASED.md).

## 2.3.0

**Added:**

- Backpack/Chip
  - Added a new Skyscanner-branded chip component that supports toggling of `selected` state, and can be disabled.

## 2.2.0

**Added:**

Backpack/Gradient:
  - Added Baseline Scrim for use as an overlay on images that contain text content.

## 2.1.0

**Added:**

- Backpack/Switch
  - A new component for showing Skyscanner-branded switches, to be used in place of `UISwitch`.

## 2.0.0

**Breaking:**

- Backpack/Font
  - The new type scale is here and with it some parts of `BPKFont` have been removed, but fear not `BPKFont` has gained new capabilities too. See the migration guide below.

**Added:**

- Backpack/Badge
- Backpack/Button
- Backpack/Dialog
- Backpack/Label
- Backpack/TextView
  - All these component use the new type scale.


### Migrating to the new type scale

The good news are that if you already use one of the higher level components you don't need to do anything. If you are directly using `BPKFont` some methods have been removed, specifcally those that return `UIFont *` directly. The new type scale requires greater control of text rendering, because of this `UIFont` instances are not enough to fully qualify text. Example migration

#### Before

```objective-c
UIFont *font [BPKFont textBase];
// Use `font`
```

#### After

```objective-c
NSAttributedString *attributedString = [BPKFont attributedStringWithFontStyle:BPKFontStyleTextBase content:@"Hello"];
// Use `attributedString`

// There's also `(NSAttributedString *)attributedStringWithFontStyle:(BPKFontStyle)fontStyle content:(NSString *)content textColor:(UIColor *)textColor`
// if you need control of the color use to render the font(the default is gray700).
// `+ (NSDictionary<NSAttributedStringKey, id> *)attributesForFontStyle:(BPKFontStyle)fontStyle` is useful when you need to construct an `NSAttributedString` yourself.
```

## 1.2.0

**Added:**
- Backpack/Icon
  - Added new icons
  - BPKIconNameCallBack
  - BPKIconNameEndCall
  - BPKIconNameKeypad
  - BPKIconNameMute
  - BPKIconNamePhoneCall
  - BPKIconNameSendMessage
  - BPKIconNameUnmute

## 1.1.0

**Added:**

- Backpack/Dialog
  - A new component for showing Skyscanner style alerts and buttom sheets.

## 1.0.0

**Fixed:**

- Backpack/Badge
- Backpack/Card
- Backpack/Color
- Backpack/Font
- Backpack/Gradient
- Backpack/Panel
  - Swift API updated to follow language conventions.

## 0.17.1

**Fixed:**

- Backpack/Card
  - Backpack card shadows will now be rendered correctly on MacOS. (Affect snapshot tests only)

## 0.17.0

**Breaking:**

- Backpack/Card
  - Backpack Card no longer allows `addSubview` to be used. Instead, Cards have a `subview` property that can be set.

**Fixed:**

- Backpack/Card
  - Non-padded cards will now correctly clip bounds of items placed inside.

**Added:**

- Backpack/Card
  - Divided cards now expose `primarySubview` and `secondarySubview` properties

## 0.16.1

**Fixed:**

- Backpack/Icon
  - Prevent collision with React Native icon font.
  - Prevent assertion error by not attempting to register the icon font if it's already been registered.

## 0.16.0

**Added:**
- Backpack/Gradient
  - `BPKGradientLayer` now allows `gradient` being `nil` in which case it will render transparent
- Backpack/Card:
  - Added divided card styles.

**Fixed:**
- Backpack/Button
  - Link style `BPKButton`s do not have white background anymore.


## 0.15.0

**Added:**

- Backpack/TextView
  - A `UITextView` subclass with Skyscanner styles.

- Backpack/Card
  - A `UIControl` subclass with Skyscanner card styling.

## 0.14.0

**Added:**

- Backpack/Spinner
  - A thin wrapper around `UIActivityIndicatorView` with the Skyscanner colors.

- Backpack/Icon
  - Added constants for icon names to avoid bugs due to the stringly typed API.

## 0.13.0

**Breaking:**

- Backpack/Color
  - Update Swift interface for Backpack colors. `BPKColor` is now `Backpack.Color` and the individual colors are class properties. `BPKColor.blue500()` becomes `Backpack.Color.blue500`.

## 0.12.0

**Added:**
- Backpack/Icon
  - Added new method for creating images for use as templates. `+ (UIImage *)templateIconNamed:name size:` in Objective-C and `makeTemplateIcon(name:size:)` in Swift.
- Backpack/Button
  - Introducing the Backpack button. Includes all Backpack button styles, support for leading and trailing icons as well as icon only buttons.

## 0.11.15

**Added:**
- Automated API docs publishing to https://backpack.github.io/ios

## 0.11.0

**Added:**
- Backpack/Icon
  - Added `iconMapping` property for an exhaustive list of available icon names.

## 0.10.0

**Breaking:**

- Reworked `BPKGradient` interface. `stops` now has the type `NSArray<NSNumber *> *` instead of `NSArray<NSValue *> *` of `CGPoint`s. A `startPoint` and `endPoint` of type `CGPoint` has been introduced and `stops` now indicate how far along the line formed by those two points the color sits.
- Moved `startPointForDirection` and `endPointForDirection` from being c functions to being class methods on `BPPKGradient`.

**Added:**

- Added two new initializers to `BPKGradient`: `-initWithColors:stops:startPoint:endPoint` and `-initWithColors:startPoint:endPoint`.
- `BPKGradientView`(`Backpack.GradientView` in Swift) for drawing instance of `BPKGradient`.
- `BPKIcon`(`Backpack.Icon` in Swift) for rendering Backpack icons.

## 0.9.0

**Added:**

- Introducing `Backpack/Label`, the label component.

## 0.8.1

**Added:**

- Introducing `Backpack/Panel`, the panel component.
- Introducing `Backpack/Badge`, the badge component.

Note: `0.8.0` was skipped because of a bug.

## 0.7.0

- Backpack gradient via `BPKGradient` and the `Backpack/Gradient` subpsec.

# 0.6.2

**Fixed:**

- The generated code has been re-oredered due to changes in the underlying `bpk-tokens` package.


## 0.6.1

This release ended up broken don't use this version.

## 0.6.0

**Breaking:**

- The `color` prefix in `BPKColor` methods have been removed as it was deemed to be redundant. Thanks to [@danielnagy81](https://github.com/danielnagy81) for contributing.

**Added:**

- Added `[BPKColor clear]`. Thanks to [@danielnagy81](https://github.com/danielnagy81) for contributing.

## 0.5.1

**Fixed:**

- Ensure that the root pod spec can be used and that the `Backpack/Backpack.h` import works as expected.

## 0.5.0

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
