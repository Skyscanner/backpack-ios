# Backpack/Map

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
