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

## Float year label

There is a configurable option to hide/show a floating year label from the calendar view. Default option is to show the year.

```swift
BPKCalendar(
    selectionType: .range(selectedRange: $selectedDateRange),
    calendar: .current,
    validRange: validStartDate...validEndDate,
    showFloatYearLabel: false
)
```

## Highlighted dates

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_calendar___highlighted_dates_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_calendar___highlighted_dates_dm.png" alt="" width="375" /> |

It's possible to display and highlight some of days in the calendar. They would be in circles. These days could be outside the valid range, in that case the calendar would show whatever is earlier (the first highlightdd date or the lower bound of the valid range). If a highlighted date was selected, then it's going to be a circled and filled cell at the same time.

```swift
let otherDays = Set([today, dayBeforeToday, dayAfterToday])

BPKCalendar(
    selectionType: .single(selected: $selectedDate),
    calendar: .current,
    validRange: validStartDate...validEndDate,
    highlightedDates: otherDays
)
```

## Custom date selection handler 

If you need to customise the date selection handling for any reason, you can implement your own implementation of CalendarSelectionHandler for specific date selection type you need (single date selection or range dates selection).

Complete customisation of date selection handling:
```swift
struct CustomCalendarSelectionHandler: CalendarSelectionHandler {
    public let rangeSelectionHandler: RangeCalendarSelectionHandler = CustomRangeCalendarSelectionHandler()
    public let singleSelectionHandler: SingleCalendarSelectionHandler
    
    ....
}

struct CustomRangeCalendarSelectionHandler: RangeCalendarSelectionHandler {
    func newRangeSelectionStateFor(
        selection date: Date,
        currentSelection: CalendarRangeSelectionState?,
        dateSelectedAccessibilityCallback: (() -> Void)?
    ) -> CalendarRangeSelectionState {
        // Selection handling code which returns CalendarRangeSelectionState
        // Here you also need to call `dateSelectedAccessibilityCallback` when you're about to change a date selection.
    }
}

struct CustomSingleCalendarSelectionHandler: SingleCalendarSelectionHandler {
    func newSingleSelectionStateFor(
        selection date: Date,
        currentSelection: CalendarSingleSelectionState?
    ) -> CalendarSingleSelectionState {
        // Selection handling code which returns CalendarSingleSelectionState
    }
}


BPKCalendar(
    selectionType: .range(selectedRange: $selectedDateRange),
    calendar: .current,
    validRange: validStartDate...validEndDate,
    calendarSelectionHandler: CustomCalendarSelectionHandler()
)
```

Customisation only one type of date selection. In this case only range selection behaviour is replaced, and the single selection is using the default behaviour:
```swift
struct CustomRangeCalendarSelectionHandler: RangeCalendarSelectionHandler {
    func newRangeSelectionStateFor(
        selection date: Date,
        currentSelection: CalendarRangeSelectionState?,
        dateSelectedAccessibilityCallback: (() -> Void)?
    ) -> CalendarRangeSelectionState {
        // Selection handling code which returns CalendarRangeSelectionState
        // Here you also need to call `dateSelectedAccessibilityCallback` when you're about to change a date selection.
    }
}

BPKCalendar(
    selectionType: .range(selectedRange: $selectedDateRange),
    calendar: .current,
    validRange: validStartDate...validEndDate,
    calendarSelectionHandler: DefaultCalendarSelectionHandler(rangeSelectionHandler: CustomRangeCalendarSelectionHandler())
)
```

## OnScrollToMonth handler 

If you need to customise the on scroll to month handling for any reason, you can add an action to your BPKCalendar definition. The handler will return all the months that are visible on screen.
You can also configurate a debounce threshold to add a delay before your onScrollToMonthAction is triggered

)
```
func updateOnScroll(monthDates: [Date]) {
    // Handle scroll
}

BPKCalendar(
    selectionType: .single(selected: $selectedDate),
    calendar: .current,
    validRange: startDate...endDate,
    scrollDebounceThreshold: 200 // time in millisecond
)
.onScrollToMonthAction(updateOnScroll)
```
                    
