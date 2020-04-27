# Backpack/BarChart

## Installation

In `Podfile` add

```
pod 'Backpack/BarChart'
```

and then run `pod install`.

## Usage

### Bar chart

`Backpack/BarChart` is a component for presenting data to travellers.

### Objective-C

```objective-c
#import <Backpack/Backpack-Swift.h>

BPKBarChart *view = [[BPKBarChart alloc] initWithTitle:@"Departure date" dataKeyText:@"Price" noDataKeyText:@"No price"];
view.barChartDelegate = self;
view.barChartDataSource = self;

...

#pragma mark - <BPKBarChartCollectionViewDelegate>

- (void)barChart:(BPKBarChart * _Nonnull)barChart didSelectBarAt:(NSIndexPath * _Nonnull)indexPath {
  // TODO
}

#pragma mark - <BPKBarChartCollectionViewDataSource>

- (NSString * _Nonnull)barChart:(BPKBarChart * _Nonnull)barChart valueDescriptionForBarAtIndex:(NSIndexPath * _Nonnull)atIndex {
  if (atIndex.item == 0) {
    return @"No price";
  }
  return [NSString stringWithFormat:@"£%ld", atIndex.item + 1];
}

- (NSNumber * _Nullable)barChart:(BPKBarChart * _Nonnull)barChart fillValueForBarAtIndex:(NSIndexPath * _Nonnull)atIndex {
  if (atIndex.item == 0) {
    return nil;
  }
  return [[NSNumber alloc] initWithFloat:atIndex.item * 0.1];
}

- (NSString * _Nonnull)barChart:(BPKBarChart * _Nonnull)barChart subtitleForBarAtIndex:(NSIndexPath * _Nonnull)atIndex {
  return [NSString stringWithFormat:@"%ld", atIndex.item + 1];
}

- (NSString * _Nonnull)barChart:(BPKBarChart * _Nonnull)barChart titleForBarAtIndex:(NSIndexPath * _Nonnull)atIndex {
NSString *weekdays[14] = {@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun"};
  return weekdays[atIndex.item];
}

- (NSInteger)barChart:(BPKBarChart * _Nonnull)barChart numberOfBarsInSection:(NSInteger)section {
  return 10;
}


- (NSInteger)numberOfSectionsIn:(BPKBarChart * _Nonnull)barChart {
  return 2;
}

- (NSString * _Nonnull)barChart:(BPKBarChart * _Nonnull)barChart titleForSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"January";
    case 1:
      return @"February";
    default:
      return @"None";
    break;
  }
}
```


### Swift

```swift
import Backpack

let barChart = BPKBarChart(title: "Departure date", dataKeyText: "Price", noDataKeyText: "No price")
barChart.barChartDelegate = self
barChart.barChartDataSource = self

...

extension MyViewController: BPKBarChartCollectionViewDataSource {
  func barChart(_ barChart: BPKBarChart, titleForSection section: Int) -> String {
    switch section {
    case 0:
      return "January"
    case 1:
      return "February"
    case 2:
      return "March"
    default:
      return "None"
    }
  }

  func numberOfSections(in barChart: BPKBarChart) -> Int {
    return 3
  }

  func barChart(_ barChart: BPKBarChart, numberOfBarsInSection section: Int) -> Int {
    return 10
  }

  func barChart(_ barChart: BPKBarChart, titleForBarAtIndex atIndex: IndexPath) -> String {
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun",
    "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    return daysOfWeek[atIndex.item]
  }

  func barChart(_ barChart: BPKBarChart, subtitleForBarAtIndex atIndex: IndexPath) -> String {
    return "\(atIndex.item + 1)"
  }

  func barChart(_ barChart: BPKBarChart, fillValueForBarAtIndex atIndex: IndexPath) -> NSNumber? {
    if atIndex.item == 0 {
      return nil
    }

    return NSNumber(value: Float(exactly: atIndex.item)! * 0.1)
  }

  func barChart(_ barChart: BPKBarChart, valueDescriptionForBarAtIndex atIndex: IndexPath) -> String {
    if atIndex.item == 0 {
      return "No price"
    }

    let value = (atIndex.item + 1) * 5
    return "£\(value)"
  }
}

extension MyViewController: BPKBarChartCollectionViewDelegate {
  func barChart(_ barChart: BPKBarChart, didSelectBarAt indexPath: IndexPath) {
    print("Selected bar at index \(indexPath.item)")
  }
}
```

