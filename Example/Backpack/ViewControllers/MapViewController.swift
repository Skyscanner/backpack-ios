/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import MapKit
import Backpack

class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    fileprivate static let reuseIdentifier = "ChipPreviewCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        self.mapView.register(
            BPKMapAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: Self.reuseIdentifier
        )
        self.setupAnnotations()
    }

    func setupAnnotations () {
        // To help with debugging, I've used points
        // where apple store logos appear on the map.

        let edinburgh = BPKMapAnnotation()
        edinburgh.title = "Edinburgh"
        edinburgh.alwaysShowCallout = true
        edinburgh.coordinate = CLLocationCoordinate2D(latitude: 55.95338, longitude: -3.189977)
        mapView.addAnnotation(edinburgh)

        let manchester = BPKMapAnnotation()
        manchester.title = "Manchester"
        manchester.iconName = .airports
        manchester.accessibilityLabel = "Manchester airport"
        manchester.alwaysShowCallout = true
        manchester.coordinate = CLLocationCoordinate2D(latitude: 53.483835, longitude: -2.24067)
        mapView.addAnnotation(manchester)

        let newcastle = BPKMapAnnotation()
        newcastle.title = "Newcastle"
        newcastle.alwaysShowCallout = true
        newcastle.enabled = false
        newcastle.coordinate = CLLocationCoordinate2D(latitude: 54.973042, longitude: -1.61699)
        mapView.addAnnotation(newcastle)

        let bristol = BPKMapAnnotation()
        bristol.title = "Bristol"
        bristol.coordinate = CLLocationCoordinate2D(latitude: 51.45705, longitude: -2.58719)
        mapView.addAnnotation(bristol)

        let soton = BPKMapAnnotation()
        soton.title = "Southampton"
        soton.coordinate = CLLocationCoordinate2D(latitude: 50.90382, longitude: -1.40638)
        mapView.addAnnotation(soton)

        let london = BPKMapAnnotation()
        london.title = "London"
        london.alwaysShowCallout = true
        london.coordinate = CLLocationCoordinate2D(latitude: 51.5122, longitude: -0.12355)
        mapView.addAnnotation(london)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return mapView.dequeueReusableAnnotationView(withIdentifier: Self.reuseIdentifier, for: annotation)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Did select")
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("Did deselect")
    }
}
