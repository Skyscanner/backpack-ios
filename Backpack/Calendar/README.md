# Backpack/Calendar

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKCalendar.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Calendar)

## Single date

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___single_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___single_dm.png) |

## Date range

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___range_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___range_dm.png) |

## Multiple dates

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___multiple_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___multiple_dm.png) |

## Custom colours

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___custom-style_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___custom-style_dm.png) |

## With prices

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___with-prices_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___with-prices_dm.png) |

## Showing year pill

| Day | Night |
| --- | --- | 
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___pill_lm.png)| ![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-calendar___pill_dm.png) |

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

bpkCalendar.selectionConfiguration = [[BPKCalendarSelectionConfigurationSingle alloc] initWithSelectionHint:@"Double tap to select date"];
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

bpkCalendar.selectionConfiguration = [[BPKCalendarSelectionConfigurationSingle alloc] initWithSelectionHint:@"Double tap to select date"];
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

bpkCalendar.selectionConfiguration = [[BPKCalendarSelectionConfigurationSingle alloc] initWithSelectionHint:@"Double tap to select date"];
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

- `(UIColor)dateSelectedContentColor`
- `(UIColor)dateSelectedBackgroundColor`
