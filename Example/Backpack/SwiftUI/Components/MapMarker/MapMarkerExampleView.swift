//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

import SwiftUI
import MapKit
import Backpack_SwiftUI

struct MapMarkerExampleView: View {
    struct Annotation: Identifiable {
        // swiftlint:disable nesting
        enum Marker {
            case price(String, BPKPriceMapMarker.State, BPKPriceMapMarker.Icon?)
            case poi(Backpack_SwiftUI.BPKIcon, BPKPoiMapMarker.State)
            case pointer
            case hotel(BPKHotelMapMarker.State)
        }
        let id = UUID()
        let marker: Marker
        let coordinate: CLLocationCoordinate2D
    }
    
    var body: some View {
        Map(
            coordinateRegion: .constant(.init(
                center: .init(latitude: 51.5, longitude: -0.08),
                span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )),
            annotationItems: [
                Annotation(
                    marker: .price("£200", .selected, nil),
                    coordinate: .init(latitude: 51.57, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("£200", .unselected, nil),
                    coordinate: .init(latitude: 51.55, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("£200", .previousSelected, nil),
                    coordinate: .init(latitude: 51.53, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("£300", .unselected, .custom(.airports)),
                    coordinate: .init(latitude: 51.51, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("£300", .previousSelected, .custom(.airports)),
                    coordinate: .init(latitude: 51.49, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("£300", .selected, .custom(.airports)),
                    coordinate: .init(latitude: 51.47, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("£200", .unselected, .save),
                    coordinate: .init(latitude: 51.45, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("£200", .selected, .save),
                    coordinate: .init(latitude: 51.43, longitude: -0.1)
                ),
                Annotation(
                    marker: .price("£200", .previousSelected, .save),
                    coordinate: .init(latitude: 51.41, longitude: -0.1)
                ),
                Annotation(
                    marker: .pointer,
                    coordinate: .init(latitude: 51.45, longitude: -0.06)
                ),
                Annotation(
                    marker: .poi(.landmark, .unselected),
                    coordinate: .init(latitude: 51.55, longitude: -0.04)
                ),
                Annotation(
                    marker: .poi(.landmark, .selected),
                    coordinate: .init(latitude: 51.53, longitude: -0.04)
                ),
                Annotation(
                    marker: .hotel(.unselected),
                    coordinate: .init(latitude: 51.51, longitude: -0.04)
                ),
                Annotation(
                    marker: .hotel(.selected),
                    coordinate: .init(latitude: 51.49, longitude: -0.04)
                )
            ]) { item in
                MapAnnotation(coordinate: item.coordinate) {
                    switch item.marker {
                    case .price(let price, let state, let icon):
                        BPKPriceMapMarker(state: state, price: price, icon: icon)
                    case .poi(let icon, let state):
                        BPKPoiMapMarker(state: state, icon: icon)
                    case .pointer:
                        BPKPointerMapMarker()
                    case .hotel(let state):
                        BPKHotelMapMarker(state: state)
                    }
                }
        }
    }
}

struct MapMarkerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        MapMarkerExampleView()
    }
}
