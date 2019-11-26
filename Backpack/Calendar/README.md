# Backpack/Calendar

## Installation

In `Podfile` add

```
pod 'Backpack/Calendar'
```

and then run `pod install`.

## Usage

`Backpack/Calendar` contains the Backpack Calendar component in the class `BPKCalendar`. The calendar is a calendar view offering user interaction.

### Objective-C

```objective-c
#import <Backpack/Calendar.h>
#import <Backpack/SimpleDate.h>

BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

bpkCalendar.selectionType = BPKCalendarSelectionSingle;
bpkCalendar.selectedDates = @[[bpkCalendar simpleDateFromDate:self.date1]];
[bpkCalendar reloadData];

...

#pragma mark - <BPKCalendarDelegate>

- (void)calendar:(BPKCalendar *)calendar didChangeDateSelection:(NSArray<BPKSimpleDate *> *)dateList {
    // do stuff
}

- (void)calendar:(BPKCalendar *)calendar didScroll:(CGPoint)contentOffset {
    // do stuff
}

- (BOOL)calendar:(BPKCalendar *)calendar isDateEnabled:(NSDate *)date {
    // do stuff
}
```

### Swift

```swift
import Backpack

let calendar = Backpack.Calendar(frame: .zero)
calendar.minDate = calendar.simpleDate(from: Date())
calendar.locale = Locale.current

...

extension MyClass: CalendarDelegate {
  func calendar(_ calendar: Backpack.Calendar, didChangeDateSelection dateList: [SimpleDate]) {
      // do stuff
  }

  func calendar(_ calendar: Backpack.Calendar, didScroll contentOffset: CGPoint) {
      // do stuff
  }

  func calendar(_ calendar: Backpack.Calendar, isDateEnabled: Date) -> Bool {
      // do stuff
  }
}
```

### Appearance attributes
`(UIColor)dateSelectedContentColor`
`(UIColor)dateSelectedBackgroundColor`

`(BPKFontMapping)fontMapping`
