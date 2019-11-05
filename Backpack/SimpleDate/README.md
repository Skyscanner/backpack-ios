# Backpack/SimpleDate

## Usage

`Backpack/SimpleDate` contains the Backpack `BPKSimpleDate` object class.

### Objective-C


```objective-c
#import <Backpack/SimpleDate.h>

// Create a `BPKSimpleDate` from an `NSDate`:
BPKSimpleDate *simpleDate = [[BPKSimpleDate alloc] initWithDate:date forCalendar:calendar];

// Create an `NSDate` from a `BPKSimpleDate`:
NSDate *date = [simpleDate dateForCalendar:calendar];
...
```

### Swift

```swift
import Backpack

// Create a `BPKSimpleDate` from an `NSDate`:
let simpleDate = SimpleDate(date: date, for: calendar);

// Create an `NSDate` from a `BPKSimpleDate`:
let date = simpleDate date(calendar: calendar);
...
```

