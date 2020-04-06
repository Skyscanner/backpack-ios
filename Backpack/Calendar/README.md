# Backpack/Calendar

## Installation

In `Podfile` add

```
pod 'Backpack/Calendar'
```

and then run `pod install`.

## Usage

`Backpack/Calendar` contains the Backpack Calendar component in the class `BPKCalendar`. The calendar is a calendar view offering user interaction.

### Simple calendar

#### Objective-C

```objective-c
#import <Backpack/Calendar.h>
#import <Backpack/SimpleDate.h>

BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

bpkCalendar.selectionType = BPKCalendarSelectionSingle;
bpkCalendar.selectedDates = @[[bpkCalendar simpleDateFromDate:self.date1]];
[bpkCalendar reloadData];

// ...

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

#### Swift

```swift
import Backpack

let calendar = BPKCalendar(frame: .zero)
calendar.minDate = calendar.simpleDate(from: Date())
calendar.locale = Locale.current

// ...

extension MyClass: BPKCalendarDelegate {
    func calendar(_ calendar: BPKCalendar, didChangeDateSelection dateList: [BPKSimpleDate]) {
        // do stuff
    }

    func calendar(_ calendar: BPKCalendar, didScroll contentOffset: CGPoint) {
        // do stuff
    }

    func calendar(_ calendar: BPKCalendar, isDateEnabled: Date) -> Bool {
        // do stuff
    }
}
```

### Priced calendar


A colour coded calendar where dates are coloured based on how expensive/cheap they are.

#### Objective-C

```objective-c
#import <Backpack/Calendar.h>
#import <Backpack/SimpleDate.h>

NSSet<BPKSimpleDate *> *lowPrices = /* .... */;
NSSet<BPKSimpleDate *> *mediumPrices = /* .... */;
NSSet<BPKSimpleDate *> *highPrices = /* .... */;

BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

bpkCalendar.selectionType = BPKCalendarSelectionSingle;
bpkCalendar.selectedDates = @[[bpkCalendar simpleDateFromDate:self.date1]];
[bpkCalendar reloadData];

// ...

#pragma mark - <BPKCalendarDelegate>

- (BPKCalendarDateCellStyle)calendar:(BPKCalendar *)calendar cellStyleForDate:(BPKSimpleDate *)date {
    if ([lowPrices containsObject:date) {
        return BPKCalendarDateCellStylePositive;
    }

    if ([mediumPrices containsObject:date) {
        return BPKCalendarDateCellStyleNeutral;
    }

    if ([highPrices containsObject:date) {
        return BPKCalendarDateCellStyleNegative;
    }

    return BPKCalendarDateCellStyleNormal;
}

- (void)calendar:(BPKCalendar *)calendar didChangeDateSelection:(NSArray<BPKSimpleDate *> *)dateList {
    // do stuff
}
```

#### Swift

```swift
import Backpack

let lowPrices: Set<BPKSimpleDate> = ...
let mediumPrices: Set<BPKSimpleDate> = ...
let highPrices: Set<BPKSimpleDate> = ...

let calendar = BPKCalendar(frame: .zero)
calendar.minDate = calendar.simpleDate(from: Date())
calendar.locale = Locale.current

// ...

extension MyClass: BPKCalendarDelegate {
  func calendar(_ calendar: BPKCalendar, cellStyleFor date: BPKSimpleDate) -> BPKCalendarDateCellStyle {
      if lowPrices.contains(date) {
          return .positive
      }

      if mediumPrices.contains(date) {
          return .neutral
      }

      if highPrices.contains(date) {
          return .negative
      }

      return .normal
  }

  }
  func calendar(_ calendar: BPKCalendar, didChangeDateSelection dateList: [BPKSimpleDate]) {
      // do stuff
  }
}
```

### Appearance attributes
`(UIColor)dateSelectedContentColor`
`(UIColor)dateSelectedBackgroundColor`

