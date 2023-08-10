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
    func test_defaultPriceMapMarker() {
        assertSnapshot(
            BPKPriceMapMarker(state: .default, price: "£200")
                .padding()
        )
    }

    func test_focusedPriceMapMarker() {
        assertSnapshot(
            BPKPriceMapMarker(state: .focused, price: "£200")
                .padding()
        )
    }

    func test_viewedPriceMapMarker() {
        assertSnapshot(
            BPKPriceMapMarker(state: .viewed, price: "£200")
                .padding()
        )
    }

    func test_disabledPriceMapMarker() {
        assertSnapshot(
            BPKPriceMapMarker(state: .disabled, price: "Sold out")
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

    func test_defaultPoiMapMarker() {
        assertSnapshot(
            BPKPoiMapMarker(state: .default, icon: .landmark)
                .padding()
        )
    }

    func test_focusedPoiMapMarker() {
        assertSnapshot(
            BPKPoiMapMarker(state: .focused, icon: .landmark)
                .padding()
        )
    }

    func test_viewedPoiMapMarker() {
        assertSnapshot(
            BPKPoiMapMarker(state: .viewed, icon: .landmark)
                .padding()
        )
    }
}
