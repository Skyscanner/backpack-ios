# Backpack-SwiftUI/Calendar

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKCalendar.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Calendar)

## Range selection

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_calendar___range_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_calendar___range_dm.png" alt="" width="375" /> |

## Single selection

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_calendar___single_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_calendar___single_dm.png" alt="" width="375" /> |
 
## Usage

`BPKCalendar` can be configured with different selection types and an accessory action for each month.

## Selection types

### Single selection

Allows the user to only select one date at a time.

```swift
@State var selectedDate: Date?

BPKCalendar(
    selectionType: .single(selected: $selectedDate),
    calendar: .current,
    validRange: validStartDate...validEndDate
)
```

### Range selection

Allows the user to select a range of dates.

```swift
@State var selectedDateRange: ClosedRange<Date>?

BPKCalendar(
    selectionType: .range(selectedRange: $selectedDateRange),
    calendar: .current,
    validRange: validStartDate...validEndDate
)
```

## Valid range

The valid range is used to determine which dates are selectable by the user. Dates outside of the valid range will be disabled.

```swift
let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
let endDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())

BPKCalendar(
    selectionType: .single(selected: $selectedDate),
    calendar: .current,
    validRange: startDate...endDate
)
```

## Adding an accessory view to each day

An accessory view can be added to each day in the calendar. This can be used to display additional information or actions for each day.

```swift
BPKCalendar(
    selectionType: .single(selected: $selectedDate),
    calendar: .current,
    validRange: startDate...endDate
    dayAccessoryView: { date in
        BPKText("$200 \(date)", style: .caption)
            .foregroundColor(.accentColor)
    }
)
```

## Spacing between rows

It's possible to configure the spacing margin between weeks in the calendar. The default value is BPKSpacing.lg (24px).

```swift
BPKCalendar(
    selectionType: .range(selectedRange: $selectedDateRange),
    calendar: .current,
    validRange: validStartDate...validEndDate,
    spacingBetweenRows: .base
)
```
