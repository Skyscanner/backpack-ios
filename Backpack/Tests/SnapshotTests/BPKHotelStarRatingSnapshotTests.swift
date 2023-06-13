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

import XCTest
import Backpack
import SnapshotTesting

class BPKHotelStarRatingSnapshotTests: XCTestCase {
    
    private let sizes: [BPKStarSize] = [.small, .large, .xLarge]
    private let ratings = Array(1...5)
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    func testHotelStarRatingSizesAndRatings() {
        assertSnapshot(createView(sizes: sizes, ratings: ratings))
    }
    
    private func createView(sizes: [BPKStarSize], ratings: [Int]) -> UIView {
        viewsInStack(withStyles: sizes, axis: .horizontal) { size in
            viewsInStack(withStyles: ratings) { rating in
                BPKHotelStarRating(size: size, rating: rating)
            }
        }
    }
}
