# Backpack iOS changelog

[Unreleased changes](./UNRELEASED.md).

## 16.0.0

**Fixed:**

 - Backpack/NavigationBar:
   - Fixed an issue that would cause the large title to jump when bouncing back from a scroll down.

**Changed:**

- Dropped iOS 10 support.

## 15.3.0

**Added:**

- Backpack/Color
  - Added new colours `textPrimaryLightColor` and `textSecondaryLightColor`

## 15.2.0

**Added:**

- Backpack/Panel:
  - New `style` property which can be either `BPKPanelStyleDefault` or `BPKPanelStyleElevated`.

## 15.1.1

**Fixed:**

- Backpack/NavigationBar
  - Fixed issue related to the scroll smoothness using the navigation bar

## 15.1.0

**Added:**

- Backpack/Dialogs:
  - Now the title is optional maintaining all the subviews in the correct place

## 15.0.1

**Fixed:**

- Backpack/Theme:
  - Updated theme `gray` colours.

## 15.0.0

**Breaking:**

- Backpack/Theme:
  - Added `systemGreen` and `systemRed` to `BPKThemeDefinition`.

## 14.3.0

**Added:**
- Backpack/FlareView:
  - New `FlareView` component

## 14.2.1

**Fixed:**

- Backpack/Calendar:
  - Fixed an inconsistency in the gray colours used in the Calendar component.

## 14.2.0

**Added:**

- Initial version of `BPKNavigationBar` with large titles.

## 14.1.2

**Fixed:**

- Backpack/Font:
  - Fixed an issue that sometimes causes the wrong font to be selected.

## 14.1.1

**Fixed:**

- Backpack/Button:
  - Fixed issue with Button pressed state being too subtle.

## 14.1.0

**Added:**

- Backpack:
  - New `BottomSheet` Swift component for presenting a floating panel similar to the one used in Apple Maps, Stocks and other native Apple apps.

## 14.0.1

**Fixed:**
 - Backpack/Label:
   - Default text colour is now `gray900` as this is a more suitable colour in the new palette.

## 14.0.0

**Breaking:**
 - Backpack/Dialog
   - Icon definition is now encapsulated in a separate object, and is optional.

**Added:**

- Backpack/Color:
  - Updated gray colours `gray50`, `gray100`, `gray200`, `gray300`, `gray400`, `gray500`, `gray700`, `gray900`
  - Deprecated `gray600` and `gray800` please update as these will be removed in the future.

## 13.0.0

**Breaking:**
- Backpack/Icon
  - Added new icons
  - `BPKIconNameSwap` renamed `BPKIconNameSwapHorizontal`

**Added:**
- Backpack/Icon
  - Added new icons
  - `BPKIconNameSwapVertical`

## 12.1.2

**Fixed:**

- Backpack/HorizontalNavigation:
  - Reduced horizontal spacing between items.

## 12.1.1

**Fixed:**

- Backpack/Dialog:
  - Fixed bottom padding underneath buttons.

## 12.1.0

**Added:**

- Backpack/HorizontalNavigation:
  - When creating a `BPKHorizontalNavigationOption`, a `tag` value can now be provided.

## 12.0.0

**Added:**
- Backpack/HorizontalNavigation:
  - Added `HorizontalNavigation` component.
  - Added small variants.
  - Added option to hide the selected item bar.
  - Added option to specify an icon for each option.

- Backpack/ProgressBar:
  - Added `ProgressBar` component.

**Breaking:**
  - Backpack/Theme:
    - Added `horiontalNavigationSelectedColor` property.

## 11.9.0

**Added:**

- Backpack/StarRating
  - `BPKStarRating` is now `IB_DESIGNABLE`.

**Changed:**
- Backpack/Icon
  - Updated `BPKIconNameTrips` with a new design.

## 11.8.0

**Added:**

- Backpack/StarRating:
  - New `StarRating` component to display a rating between 0.0 and 5.0.
- Backpack/Icon:
  - New `size` prop on `BPKIconView` to control icon size.
  - New `flipsForRightToLeft` prop on `BPKIconView` to support icons with a horizontal direction in a right to left environment.

**Fixed:**

- Backpack/Dialog:
  - Dialog now respects a user's preference for reduced motion and reduced transparency.

## 11.7.0

- Backpack/BPKTappableLinkLabel:
  - `textAlignment` similar to `UILabel`
  - `lineBreakMode` similar to `UILabel`

## 11.6.0

**Added:**
- Backpack/Icon
  - New icons:
    - Added `flight-landing` as `BPKIconNameFlightLanding`.
    - Added `flight-takeoff` as `BPKIconNameFlightTakeoff`.
    - Added `aircraft` as `BPKIconNameAircraft`.

## 11.5.3

**Fixed:**

- Backpack/Calendar:
  - Fixed layout issues when using range selection in RTL.

## 11.5.2

Nothing of note!

## 11.5.0

**Added:**

- Backpack/Label:
  - New method for setting the label font style for a specified range.

## 11.4.0

**Fixed:**

- Backpack/TappableLinkLabel:
  - Prevent cutting off parts of text with larger fonts.

- Backpack/Button
  - Icon-only buttons are now always circular regardless of the `cornerRadius` appearance setting.

**Added:**

- Backpack/TappableLinkLabel:
  - Added method for adding a link whilst providing Transit Information (an `NSDictionary`) instead of a URL.
  - New `style` property which can be used when placing the link label over a blue/dark background.
  - Added `numberOfLines` property.

### 11.3.0

**Added:**

- Backpack/TappableLinkLabel:
  - New `TappableLinkLabel` component.

### 11.2.0

**Added:**

- Backpack/Icons:
  - Updated `bpk-svgs` dependency to get new icons.

### 11.1.0

**Added:**

- Backpack/TextField:
  - Added a new class `BPKTextField`, a subclass of `UITextField` which uses the Skyscanner style.

**Fixed:**

- Backpack/TextView:
  - Fixed issue where `BPKTextView` didn't set proper styling when user typed.

### 11.0.1

**Fixed:**

- Backpack/Button:
  - Fixed issue where content color of `BPKButton` didn't change after changing its `linkContentColor`

### 11.0.0

**Breaking:**
 - Backpack/Theme:
   - We've deprecated `grayXXColorFor:` methods in favour of using `UI_APPEARANCE_SELECTOR`s.

### 10.0.0

**Breaking:**
 - Backpack/Theme:
   - `BPKContainerController themeContainer` has been renamed `container`.
   - `BPKContainerController isThemeActive` has been renamed `isContainerActive`.

**Added:**
 - Backpack/Theme:
   - Added initialiser for creating a `BPKContainerController` with a `UIView Class`, instead of insisting on a complete theme definition.

### 9.0.0-beta

**Breaking:**
- Backpack/Theme
  - Theme definitions now require a `fontMapping` object attribute of type `BPKFontMapping`.

- Backpack/Font
  - A number of `BPKFont` methods now require a `fontMapping` to provided. This can be `nil`.

**Added:**
- Backpack/Icon
  - Added `heart--outline` as `BPKIconNameHeartOutline`.

### 8.17.1

**Fixed:**

- Backpack/Icon
  - Updated stroke widths of `heart`, `heart--outline`, `world-amer`, `world-emea` and `world-apac` icons.

### 8.17.0

**Added:**

- Backpack/Icon
  - Added `face--blank`, `face--happy` and `face--sad` icons.

### 8.16.1

**Changed:**

- Backpack/Icon
  - Updated `heart--outline`

### 8.16.0

**Changed:**

- Backpack/Icon
  - Updated `heart`, `family`

**Added:**

- Backpack/Icon
  - Added `heart`, `heart--outline`, `trend--steady`, `trend--down`, `trend--will-rise`, `filter` `world--amer`, `world--apac` and `world--emea` icons.

### 8.15.1

**Fixed:**
 - Backpack/Theme:
   - Exposed missing `BPKThemeContainer` interface.

### 8.15.0

**Added:**
 - Backpack/Theme
   - Added utilities for getting `gray50Color`, `gray100Color`, `gray300Color`, `gray500Color`, `gray700Color`, and `gray900Color`.

### 8.14.1

**Fixed:**

- Backpack/Calendar:
  - Added `Button`, `Selected`, and `Not enabled` accessibility traits as appropriate.

### 8.14.0

**Added:**

- Backpack/Theme:
  - Added `featuredButtonContentColor`, `featuredButtonGradientStartColor`, and `featuredButtonGradientEndColor` properties to Backpack theme definitions.
  - Added `destructiveButtonContentColor`, `destructiveButtonBackgroundColor`, and `destructiveButtonBorderColor` properties to Backpack theme definitions.

- Backpack/Button:
  - Added `featuredContentColor`, `featuredGradientStartColor`, and `featuredGradientEndColor` appearance proxy properties to support theming.
  - Added `destructiveContentColor`, `destructiveBackgroundColor`, and `destructiveBorderColor` appearance proxy properties to support theming.

**Fixed:**

- Backpack/Button
  - Fixed a bug which meant that button text wasn't properly displayed when set in interface-builder.

### 8.13.0

**Added:**

- Backpack/Theme:
  - Added `primaryGradient` property to Backpack theme definitions.

- Backpack/Gradient:
  - Added a new gradient view `BPKprimaryGradientView`/`PrimaryGradientView` suitable for rendering a primary gradient.

### 8.12.0

**Added:**

- Backpack/Theme:
  - Added `buttonCornerRadius` property to Backpack theme definitions.

- Backpack/Button:
  - Added `cornerRadius` appearance proxy property to support theming.

### 8.11.0

**Added:**

- Backpack/Theme:
  - Added `calendarDateSelectedContentColor` and `calendarDateSelectedBackgroundColor` properties to Backpack theme definitions.

- Backpack/Calendar:
  - Added `dateSelectedContentColor` and `dateSelectedBackgroundColor` appearance proxy properties to support theming.

### 8.10.0

**Added:**

- Backpack/Theme:
  - Added `secondaryButtonContentColor`, `secondaryButtonBackgroundColor` and `secondaryButtonBorderColor` properties to Backpack theme definitions.

- Backpack/Button:
  - Added `secondaryContentColor`, `secondaryBackgroundColor` and `secondaryBorderColor` appearance proxy properties to support theming.

**Fixed:**

- Backpack/Calendar
  - Fixed the background of the header to be transparent.

### 8.9.0

**Added:**

- Backpack/Theme:
  - Added `buttonLinkContentColor` property to Backpack theme definitions.

- Backpack/Button:
  - Added `linkContentColor` appearance proxy property to support theming.

### 8.8.0

**Added:**

- Backpack/Theme:
  - Added `chipPrimaryColor` property to Backpack theme definitions.

- Backpack/Chip:
  - Added `primaryColor` appearance proxy property to support theming.

### 8.7.1

**Fixed:**

- Backpack/Switch
- Backpack/Theme
  - Fixed a race condition bug were `BPKSwitch` when created from code would not correctly support theming.

### 8.7.0

**Added:**

- Backpack/Theme:
  - `BPKThemeContainerController` now returns `self.rootViewController` for `forwardingTargetForSelector:` this improves code that makes assumptions about the specific methods available on `keyWindow.rootViewController` when the previous `rootViewController` is wrapped in a `BPKThemeContainerController`. In debug builds this will cause an assertion error as it is not a behaviour we encourage relying on.

**Fixed:**
- Backpack/Calendar:
  - Added accessibility labels to `BPKCalendar` cells to provide month and year context to screen-readers.

### 8.6.0

**Changed:**
- Backpack/Icon
  - Updated `alert--active`, `alert--add`, `alert--expired`, `alert--remove`, `price-alerts` icons.

### 8.5.0

**Added:**

- Backpack/Theme:
  - Added `primaryButtonContentColor`, `primaryButtonGradientStartColor`, and `primaryButtonGradientEndColor` properties to Backpack theme definitions.

- Backpack/Button:
  - Added `primaryContentColor`, `primaryGradientStartColor`, and `primaryGradientEndColor` appearance proxy properties to support theming.

### 8.4.0

**Added:**

 - Backpack/Color
   - Added colour blending utility, which can combine any two given colours with a specified weighting.

### 8.3.0

**Added:**

 - Backpack/Theme:
   - Added `primaryColor` property to Backpack theme definitions.
   - Added `primaryColor` helper method to `BPKTheme`, which returns the appropriate themed primary colour given a view.

### 8.2.0

**Added:**

- Backpack/Theme
  - Theme container controller now holds a reference to the currently applied theme.

### 8.1.0

**Added:**

- Backpack/Spinner
  - Added `primaryColor` appearance attribute to support theming.

- Backpack/Theme
  - Themes now apply `primaryColor` to Backpack Spinner components.

### 8.0.0

**Breaking:**

- Backpack/Theme
  - Theme container classes are no longer exposed by Backpack/Theme. Instead they must be accessed using the `container` method of the themes.

**Changed:**

- Backpack/Calendar
  - New selection mechanism where every selection after a range defined clears the previously selected range

### 7.0.0

**Breaking:**

- Backpack/Calendar
  - Changed the external interface of the Calendar to use a simple time zone independent date class, `BPKSimpleDate`/`SimpleDate`. All methods and properties that previously used `NSDate` in the device's local time zone now use `BPKSimpleDate` instead.
  - `minDate`, `maxDate`, and `locale` in `BPKCalendar`/`Calendar` are now correctly `nonnull`.

**Added:**

- Backpack/Calendar
  - Added a method: `simpleDateFromDate:`/`simpleDate(from:)` to `BPKCalendar`/`Calendar` to convert from `NSDate` in the device's local time zone to `BPKSimpleDate`/`SimpleDate`.
  - Added a method: `dateFromSimpleDate:`/`date(from:)` to `BPKCalendar`/`Calendar` to convert from `BPKSimpleDate`/`SimpleDate` to `NSDate` in the device's locale time zone.
  - Added a new initializer to `BPKCalendar`/`Calendar` to create a calendar with a predefined `minDate` and `maxDate`. This initializer is preferred.

### 6.6.3

- Backpack/Calendar
  - Fixes for iPad split screen: Layout updated at the right time (after screen transition completed)

### 6.6.2

**Fixed:**

- Backpack/Calendar
  - Revert breaking changes that were accidentally included in 6.6.1.

### 6.6.1

**Fixed:**

+ Backpack/Calendar
  + Make sure screen rotation works correctly.
  + Fixed layout issues on iPad.

### 6.6.0

**Added:**
- Backpack/Calendar
  - Exposed some read only properties of the calendar's underlying `scrollView`. These are:
    - `contentInset`
    - `contentSize`
    - `isDecelerating`
    - `isTracking`
    - `isDragging`

### 6.5.1

**Fixed:**

+ Backpack/Button
  + Fixed a bug where Backpack buttons would incorrectly lay out as if there was an image if the image was set and then removed.

### 6.5.0

**Added:**

+ Backpack/Icon
  + Added new icons
    + `BPKIconNameEcoLeaf`
    + `BPKIconNameHide`

### 6.4.1

**Changed:**
- Added a runtime check that all Backpack UI components are being called from the main thread.

### 6.4.0

**Added:**
 - Backpack/Theme
   - New example themes and containers.

### 6.3.0

**Added:**

- `Backpack/Icon`
  - Added a new class `BPKIconView`(`IconView` in Swift) for displaying icons. It is based on `UIImageView` and the perfect choice when you just want to display an icon with a tint.

    ```objective-c
    #import <Backpack/Color.h>
    #import <Backpack/Icon.h>

    BPKIconView *iconView = [[BPKIconView alloc] initWithIconName:BPKIconNameAccessibility
                                                               size:BPKIconSizeLarge];
    iconView.tintColor = BPKColor.blue500;
    ```

### 6.2.1

**Fixed:**

+ Backpack/Button
  + Bug fix to ensure disabled style is not overridden when title is set.
  + Bug fix to make link button background transparent.

### 6.2.0

**Added:**

+ Backpack/Icon
  + Added new icons
    + `BPKIconNameSocialLike`
    + `BPKIconNameGridLayout`

+ Backpack/Font
    + Added new API to make it easier to deal with custom attributes. `attributesForForStyle:withCustomAttributes:` in Objective-C and `makeAttributes(fontStyle:customAttributes:)` in Swift. Note this API will ignore some overrides that would change the text rendering to the point where it is no longer conforming to the Backpack style.
+

### 6.1.1

**Fixed:**

- Backpack/Calendar
  - Expose the `NSCalendar` instance used as a read only property.

### 6.1.0

**Added:**
+ Backpack/Icon
  + Added new icons
    + `BPKIconNameSpeaker`

### 6.0.0

**Breaking:**
  + Bumped deployment target to iOS 10.0.

**Fixed:**
  + The calendar component no longer uses Auto Layout internally. This is to enable it to be used from React Native.
  + Internals of the date selection logic for the calendar has been refactored to support usage from React Native.

## 5.0.0

**Breaking:**

- Backpack
  - Remove all subspecs in favour of a single specification for the whole pod.
- `Backpack.Font`
  - Made the API more swifty by renaming the methods in Swift.


## 4.2.0

**Added:**

- Backpack/Calendar
  - Added ability for a user to select a range of dates beginning and ending on the same day.

## 4.1.0

**Added:**

- Backpack/Button
  - New `outline` button type which renders just an outline and the text. Designed for use on more colourful backgrounds.

## 4.0.1

**Fixed:**

- Backpack/Calendar
  - Minor fixes

## 4.0.0

**Breaking:**

- Backpack/Font
  - XXL and XXXL font sizes are now `30pt` and `36pt` (previously `36pt` and `42pt`). The `42pt` font size has been removed for the time being.

## 3.2.1

**Fixed:**
 - `BPKCalendar`:
   - Minor tweaks

## 3.2.0

**Added:**
 - `BPKCalendar`:
   - Added Calendar component which was kindly contributed by Stark.

## 3.1.0

**Added:**
 - `BPKCard`:
   - Added `cornerStyles` options of small (default) and large.

## 3.0.0

**Breaking:**
 - `BPKShadow`:
   - Removed `Xl` variant of `BPKShadow`.

**Fixed:**
 - `BPKChip`:
   - Updated accessibility traits.

## 2.3.1

**Fixed:**

- Backpack/Icon:
  - Updated `bpk_send_message` icon.

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

The good news are that if you already use one of the higher level components you don't need to do anything. If you are directly using `BPKFont` some methods have been removed, specifically those that return `UIFont *` directly. The new type scale requires greater control of text rendering, because of this `UIFont` instances are not enough to fully qualify text. Example migration

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
  - `BPKIconNameCallback`
  - `BPKIconNameEndCall`
  - `BPKIconNameKeypad`
  - `BPKIconNameMute`
  - `BPKIconNamePhoneCall`
  - `BPKIconNameSendMessage`
  - `BPKIconNameUnmute`

## 1.1.0

**Added:**

- Backpack/Dialog
  - A new component for showing Skyscanner style alerts and bottom sheets.

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
  - Link style `BPKButton`s do not have white background any more.


## 0.15.0

**Added:**

- Backpack/TextView
  - A `UITextView` subclass with Skyscanner styles.

- Backpack/Card
  - A `UIControl` subclass with Skyscanner card styling.

## 0.14.0

**Added:**

- Backpack/Spinner
  - A thin wrapper around `UIActivityIndicatorView` with the Skyscanner colours.

- Backpack/Icon
  - Added constants for icon names to avoid bugs due to the strongly typed API.

## 0.13.0

**Breaking:**

- Backpack/Color
  - Update Swift interface for Backpack colours. `BPKColor` is now `Backpack.Color` and the individual colours are class properties. `BPKColor.blue500()` becomes `Backpack.Color.blue500`.

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

- The generated code has been reordered due to changes in the underlying `bpk-tokens` package.


## 0.6.1

This release ended up broken don't use this version.

## 0.6.0

**Breaking:**

- The `color` prefix in `BPKColor` methods have been removed as it was deemed to be redundant. Thanks to [@danielnagy81](https://github.com/danielnagy81) for contributing.

**Added:**

- Added `[BPKColor clear]`. Thanks to [@danielnagy81](https://github.com/danielnagy81) for contributing.

## 0.5.1

**Fixed:**

- Ensure that the root pod specification can be used and that the `Backpack/Backpack.h` import works as expected.

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

- Moved colours to a subspec in `Backpack/Color`.

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
