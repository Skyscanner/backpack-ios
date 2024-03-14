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

class BPKRatingBarTests: XCTestCase {
    func test_defaultStyleZeroToFive() {
        assertSnapshot(
            BPKRatingBar(
                label: "Rating",
                rating: 2.5,
                accessibilityLabel: ""
            )
        )
    }
    
    func test_belowZero() {
        assertSnapshot(
            BPKRatingBar(
                label: "Rating",
                rating: -2.5,
                accessibilityLabel: ""
            )
        )
    }
    
    func test_aboveScale() {
        assertSnapshot(
            BPKRatingBar(
                label: "Rating",
                rating: 6,
                accessibilityLabel: ""
            )
        )
    }

    func test_ratingEmpty() {
        assertSnapshot(
            BPKRatingBar(
                label: "Rating",
                rating: 0,
                accessibilityLabel: ""
            )
        )
    }

    func test_ratingFull() {
        assertSnapshot(
            BPKRatingBar(
                label: "Rating",
                rating: 5,
                accessibilityLabel: ""
            )
        )
    }
    
    func test_onContrastStyle() {
        assertSnapshot(
            BPKRatingBar(
                label: "Rating",
                rating: 2.5,
                accessibilityLabel: "",
                style: .onContrast
            )
            .background(.canvasContrastColor)
        )
    }

    func test_noScale() {
        assertSnapshot(
            BPKRatingBar(
                label: "Rating",
                rating: 2.5,
                accessibilityLabel: "",
                showScale: false
            )
        )
    }
    
    func test_zeroToTen() {
        assertSnapshot(
            BPKRatingBar(
                label: "Rating",
                rating: 5,
                accessibilityLabel: "",
                ratingScale: .zeroToTen
            )
        )
    }
}
