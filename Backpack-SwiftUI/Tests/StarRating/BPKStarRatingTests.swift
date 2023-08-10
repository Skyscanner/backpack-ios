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

class BPKStarRatingTests: XCTestCase {
    func test_hotelStars() {
        assertSnapshot(BPKHotelStarRating(rating: .constant(3)))
    }
    
    func test_zeroStars() {
        assertSnapshot(BPKStarRating(rating: .constant(0), maxRating: 5))
    }

    func test_halfStar() {
        assertSnapshot(BPKStarRating(rating: .constant(2.5), maxRating: 5))
    }

    func test_fullStars() {
        assertSnapshot(BPKStarRating(rating: .constant(5), maxRating: 5))
    }

    func test_customNumberOfStars() {
        assertSnapshot(BPKStarRating(rating: .constant(3), maxRating: 10))
    }

    func test_largeSize() {
        assertSnapshot(BPKStarRating(rating: .constant(3), maxRating: 5, size: .large))
    }

    func test_upRounding() {
        assertSnapshot(
            VStack {
                BPKStarRating(rating: .constant(3.3), maxRating: 5, rounding: .up)
                BPKStarRating(rating: .constant(3.7), maxRating: 5, rounding: .up)
            }
        )
    }

    func test_downRounding() {
        assertSnapshot(
            VStack {
                BPKStarRating(rating: .constant(3.3), maxRating: 5, rounding: .down)
                BPKStarRating(rating: .constant(3.7), maxRating: 5, rounding: .down)
            }
        )
    }

    func test_nearestRounding() {
        assertSnapshot(
            VStack {
                BPKStarRating(rating: .constant(3.3), maxRating: 5, rounding: .nearest)
                BPKStarRating(rating: .constant(3.7), maxRating: 5, rounding: .nearest)
            }
        )
    }
}
