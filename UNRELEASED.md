# Unreleased

**Breaking:**

- Backpack/Calendar
  - Changed the external interface of the Calendar to use a simple time zone independent date class, `BPKSimpleDate`/`SimpleDate`. All methods and properties that previously used `NSDate` in the device's local time zone now use `BPKSimpleDate` instead.
  - `minDate`, `maxDate`, and `locale` in `BPKCalendar`/`Calendar` are now correctly `nonnull`.

**Added:**

- Backpack/Calendar
  - Added a method: `simpleDateFromDate:`/`simpleDate(from:)` to `BPKCalendar`/`Calendar` to convert from `NSDate` in the device's local time zone to `BPKSimpleDate`/`SimpleDate`.
  - Added a method: `dateFromSimpleDate:`/`date(from:)` to `BPKCalendar`/`Calendar` to convert from `BPKSimpleDate`/`SimpleDate` to `NSDate` in the device's locale time zone.
  - Added a new initializer to `BPKCalendar`/`Calendar` to create a calendar with a predefined `minDate` and `maxDate`. This initializer is preferred.
