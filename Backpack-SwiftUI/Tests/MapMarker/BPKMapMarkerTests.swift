/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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

import XCTest
import SwiftUI
@testable import Backpack_SwiftUI

class BPKMapMarkerTests: XCTestCase {
    func test_unselectedPriceMapMarker() {
        assertSnapshot(
            BPKPriceMapMarker(state: .unselected, price: "£200")
                .padding()
        )
    }

    func test_selectedPriceMapMarker() {
        assertSnapshot(
            BPKPriceMapMarker(state: .selected, price: "£200")
                .padding()
        )
    }

    func test_previousSelectedPriceMapMarker() {
        assertSnapshot(
            BPKPriceMapMarker(state: .previousSelected, price: "£200")
                .padding()
        )
    }
    
    func test_unselectedPriceMapMarker_withCustomIcon() {
        assertSnapshot(
            BPKPriceMapMarker(state: .unselected, price: "£200", icon: .custom(.airports))
                .padding()
        )
    }
    
    func test_selectedPriceMapMarker_withCustomIcon() {
        assertSnapshot(
            BPKPriceMapMarker(state: .selected, price: "£200", icon: .custom(.airports))
                .padding()
        )
    }
    
    func test_previousSelectedPriceMapMarker_withCustomIcon() {
        assertSnapshot(
            BPKPriceMapMarker(state: .previousSelected, price: "£200", icon: .custom(.airports))
                .padding()
        )
    }
    
    func test_unselectedPriceMapMarker_withSaveIcon() {
        assertSnapshot(
            BPKPriceMapMarker(state: .unselected, price: "£200", icon: .save)
                .padding()
        )
    }
    
    func test_selectedPriceMapMarker_withSaveIcon() {
        assertSnapshot(
            BPKPriceMapMarker(state: .selected, price: "£200", icon: .save)
                .padding()
        )
    }

    func test_pointerMapMarker() {
        assertSnapshot(
            BPKPointerMapMarker()
                .padding()
                .background(.surfaceSubtleColor)
        )
    }

    func test_unselectedPoiMapMarker() {
        assertSnapshot(
            BPKPoiMapMarker(state: .unselected, icon: .landmark)
                .padding()
        )
    }

    func test_selectedPoiMapMarker() {
        assertSnapshot(
            BPKPoiMapMarker(state: .selected, icon: .landmark)
                .padding()
        )
    }
    
    func test_unselectedHotelMapMarker() {
        assertSnapshot(
            BPKHotelMapMarker(state: .unselected)
                .padding()
        )
    }
    
    func test_selectedHotelMapMarker() {
        assertSnapshot(
            BPKHotelMapMarker(state: .selected)
                .padding()
        )
    }
}
