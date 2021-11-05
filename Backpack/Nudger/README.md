# Backpack/Nudger

## Usage

`BPKNudger` contains the Backpack Nudger component. It's an adjustable control that allows a traveller to select a numerical value between a min/max determined by the consumer.

It uses the iOS accessibility adjustable trait so that users of Assistive Technology can easily interact with it.

### Objective-C

```objective-c
#import <Backpack/Nudger.h>

BPKNudgerConfiguration *nudgerConfiguration = [[BPKNudgerConfiguration alloc]
    initWithLabel:@"Passengers"
    valueFormatter:^(double value) {
        return [NSNumberFormatter localizedStringFromNumber:@(value) numberStyle:NSNumberFormatterDecimalStyle];
    }
    accessibilityLabelFormatter:^(double value) {
        NSString *number = [NSNumberFormatter localizedStringFromNumber:@(value) numberStyle:NSNumberFormatterDecimalStyle];
        return [NSString stringWithFormat:@"%@ passengers", number];
    }
];

BPKNudger *nudger = [[BPKNudger alloc] initWithConfiguration:nudgerConfiguration];
nudger.minimumValue = 2;
nudger.maximumValue = 9;
nudger.value = 4;
```

### Swift

```swift
import Backpack

let nudgerConfiguration = BPKNudgerConfiguration(
    label:"Passengers",
    valueFormatter: { (value) -> String in
        NumberFormatter.localizedString(from: NSNumber(value: value), number: .decimal)
    }
)

let nudger = BPKNudger(configuration: nudgerConfiguration)
nudger.minimumValue = 2
nudger.maximumValue = 9
nudger.value = 4
```
