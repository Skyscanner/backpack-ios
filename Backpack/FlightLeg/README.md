# Backpack/Flight Leg

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKRating.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Rating)

## Default

| Day | Night |
| --- | --- |
| <img src="https://user-images.githubusercontent.com/55076036/228302928-1c831506-977a-4b2c-bc16-fcf7bef45500.png" alt="" width="375" /> |<img src="https://user-images.githubusercontent.com/55076036/228303107-104b80c3-b063-45d6-a881-8dce4a6ef282.png" alt="" width="375" /> |


## Usage

The BPKFlightLeg component contains nine properties, from which five are mandatory. 
```swift
  departureArrivalTime: String,
  nextDayArrival: String?,
  flightDescription: NSAttributedString,
  stopsInfo: String,
  highlightStopsInfo: Bool,
  duration: String,
  operatedBy: String?,
  warning: String?,
  carrierLogo: BPKIconName
```

* ```departureArrivalTime, nextDayArrival, stopsInfo, duration, operatedBy, warning``` expect Strings;
* ```flightDescription``` expects an attributed string;
* ```highlightStopsInfo``` expects a boolean;
* ```carrierLogo``` expects a [BPKIconName](https://github.com/Skyscanner/backpack-ios/tree/sonic/SONIC-1384-bpk-flightleg-uikit/Backpack/Icon).

If a flight has more than one leg (i.e. 1 or more stops), then ```highlightStopsInfo``` must be included and be set to **true**.

BPKFlightLeg Example
```swift
import Backpack

private let defaultDescription: NSAttributedString = {
    return NSAttributedString(string: "EDI-LHR, British Airways", attributes: BPKFlightLeg.descriptionDefaultAttributes())
}()  
private let highlightedDescription: NSAttributedString = {
    let flightDescriptionString = NSMutableAttributedString(
        string: "LHR-SYD, Emirates", attributes: BPKFlightLeg.descriptionDefaultAttributes())
    let range = (flightDescriptionString.string as NSString).range(of: "SYD")
    flightDescriptionString.addAttributes(BPKFlightLeg.airportHighlightAttributes(), range: range)

    return flightDescriptionString
}()

let flightLegComponent = BPKFlightLeg(
    departureArrivalTime: "17:25 - 19:00",
    flightDescription: defaultDescription,
    stopsInfo: "Direct",
    duration: "1h 35m",
    carrierLogo: .airline
)

let completeFlightLegWithAllPossibleArguments = BPKFlightLeg(
    departureArrivalTime: "22:10 - 08:45",
    nextDayArrival: "+2",
    flightDescription: highlightedDescription,
    stopsInfo: "1 Stop",
    highlightStopsInfo: true,
    duration: "25h 35m",
    operatedBy: "Operated by Emirates",
    warning: "Change airports in Dubai",
    carrierLogo: .airline
)

```
