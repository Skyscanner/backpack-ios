# Backpack/Map

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKMap.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/Map)

## Map markers

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-map___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-map___default_dm.png" alt="" width="375" /> |

## Usage

`BPKMapView` is a wrapper around `MKMapView`.

`BPKMapAnnotationView` contains the Backpack annotation component. `BPKMapAnnotation` can be used to represent a given annotation.

### Objective-C

```objective-c
#import <Backpack/Map.h>

BPKMapView *mapView = [BPKMapView new];
mapView.delegate = self;
[mapView registerClass:BPKMapAnnotationView.class forAnnotationViewWithReuseIdentifier:@"Annotation"];

BPKMapAnnotation *edinburgh = [BPKMapAnnotation new];
edinburgh.title = @"Edinburgh";
edinburgh.alwaysShowCallout = YES;
edinburgh.coordinate = CLLocationCoordinate2DMake(55.95338, -3.189977);
[mapView addAnnotation:edinburgh];)

- (MKAnnotationView *_Nullable)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    return [mapView dequeueReusableAnnotationViewWithIdentifier:ReuseIdentifier forAnnotation:annotation];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // do something
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    // do something
}
```

### Swift

```swift
import Backpack

let mapView = MKMapView()
mapView.delegate = self
mapView.register(BPKMapAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Annotation")

let edinburgh = BPKMapAnnotation()
edinburgh.title = "Edinburgh"
edinburgh.alwaysShowCallout = true
edinburgh.coordinate = CLLocationCoordinate2D(latitude: 55.95338, longitude: -3.189977)
mapView.addAnnotation(edinburgh)

...

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return mapView.dequeueReusableAnnotationView(withIdentifier: "Annotation", for: annotation)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // do something
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        // do something
    }
}

```
