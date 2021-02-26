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

bpkCalendar.selectionConfiguration = [[BPKCalendarSelectionConfigurationSingle alloc] init];
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

### Color-coded calendar

A colour coded calendar where dates are coloured based on how expensive/cheap they are.

#### Objective-C

```objective-c
#import <Backpack/Calendar.h>
#import <Backpack/SimpleDate.h>

NSSet<BPKSimpleDate *> *lowPrices = /* .... */;
NSSet<BPKSimpleDate *> *mediumPrices = /* .... */;
NSSet<BPKSimpleDate *> *highPrices = /* .... */;

BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithFrame:CGRectZero];

bpkCalendar.selectionConfiguration = [[BPKCalendarSelectionConfigurationSingle alloc] init];
bpkCalendar.selectedDates = @[[bpkCalendar simpleDateFromDate:self.date1]];
[bpkCalendar reloadData];

// ...

#pragma mark - <BPKCalendarDelegate>

- (id _Nullable)calendar:(BPKCalendar *)calendar cellDataForDate:(BPKSimpleDate *)date {
    if ([lowPrices containsObject:date) {
        return BPKCalendarTrafficLightCellData.positive;
    }

    if ([mediumPrices containsObject:date) {
        return BPKCalendarTrafficLightCellData.neutral;
    }

    if ([highPrices containsObject:date) {
        return BPKCalendarTrafficLightCellData.negative;
    }

    return BPKCalendarTrafficLightCellData.normal;
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
  func calendar(_ calendar: BPKCalendar, cellDataFor date: BPKSimpleDate) -> Any? {
      if lowPrices.contains(date) {
          return BPKCalendarTrafficLightCellData.positive
      }

      if mediumPrices.contains(date) {
          return BPKCalendarTrafficLightCellData.neutral
      }

      if highPrices.contains(date) {
          return BPKCalendarTrafficLightCellData.negative
      }

      return BPKCalendarTrafficLightCellData.normal
  }

  }
  func calendar(_ calendar: BPKCalendar, didChangeDateSelection dateList: [BPKSimpleDate]) {
      // do stuff
  }
}
```

### Priced calendar

A calendar where cells display a price.

#### Objective-C

```objective-c
#import <Backpack/Calendar.h>
#import <Backpack/SimpleDate.h>

NSSet<BPKSimpleDate *> *lowPrices = /* .... */;
NSSet<BPKSimpleDate *> *mediumPrices = /* .... */;
NSSet<BPKSimpleDate *> *highPrices = /* .... */;

BPKCalendar *bpkCalendar = [[BPKCalendar alloc] initWithConfiguration: [BPKCalendarPriceLabelConfiguration new]];

bpkCalendar.selectionConfiguration = [[BPKCalendarSelectionConfigurationSingle alloc] init];
bpkCalendar.selectedDates = @[[bpkCalendar simpleDateFromDate:self.date1]];
[bpkCalendar reloadData];

// ...

#pragma mark - <BPKCalendarDelegate>

- (id _Nullable)calendar:(BPKCalendar *)calendar cellDataForDate:(BPKSimpleDate *)date {
    if ([lowPrices containsObject:date) {
        return [[BPKCalendarPriceLabelCellData alloc] initWithPrice: @"£12" labelStyle: BPKCalendarPriceLabelStyle.positive];
    }

    if ([mediumPrices containsObject:date) {
        return [[BPKCalendarPriceLabelCellData alloc] initWithPrice: @"£25" labelStyle: BPKCalendarPriceLabelStyle.neutral];
    }

    if ([highPrices containsObject:date) {
        return [[BPKCalendarPriceLabelCellData alloc] initWithPrice: @"£43" labelStyle: BPKCalendarPriceLabelStyle.negative];
    }

    return [[BPKCalendarPriceLabelCellData alloc] initWithPrice: @"-" labelStyle: BPKCalendarPriceLabelStyle.noData];
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

let calendar = BPKCalendar(configuration: BPKCalendarPriceLabelConfiguration())
calendar.minDate = calendar.simpleDate(from: Date())
calendar.locale = Locale.current

// ...

extension MyClass: BPKCalendarDelegate {
  func calendar(_ calendar: BPKCalendar, cellDataFor date: BPKSimpleDate) -> Any? {
      if lowPrices.contains(date) {
          return BPKCalendarPriceLabelCellData(price: "£12", labelStyle: BPKCalendarPriceLabelStyle.positive)
      }

      if mediumPrices.contains(date) {
          return BPKCalendarPriceLabelCellData(price: "£25", labelStyle: BPKCalendarPriceLabelStyle.neutral)
      }

      if highPrices.contains(date) {
          return BPKCalendarPriceLabelCellData(price: "£43", labelStyle: BPKCalendarPriceLabelStyle.negative)
      }

      return BPKCalendarPriceLabelCellData(price: "-", labelStyle: BPKCalendarPriceLabelStyle.noData)
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
