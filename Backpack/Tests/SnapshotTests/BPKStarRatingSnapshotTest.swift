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
import Backpack
import FBSnapshotTestCase

class BPKStarRatingSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    private func createView(
        ratings: [Float],
        roundings: [BPKStarRatingRounding],
        sizes: [BPKStarSize]
    ) -> UIView {
        viewsInStack(withStyles: ratings) { rating in
            viewsInStack(withStyles: roundings, axis: .horizontal) { rounding in
                viewsInStack(withStyles: sizes, axis: .horizontal) { size in
                    let starRating = BPKStarRating(size: size)
                    starRating.rounding = rounding
                    starRating.rating = rating
                    return starRating
                }
            }
        }
    }
    
    private let ratings: [Float] = [
        -1.0,
        0.0,
        0.49,
        0.5,
        0.99,
        1.0,
        1.49,
        1.5,
        1.99,
        2.0,
        2.49,
        2.5,
        2.99,
        3.0,
        3.49,
        3.5,
        3.99,
        4.0,
        4.49,
        4.5,
        4.99,
        5.0,
        6.0
    ]
    
    private let roundings: [BPKStarRatingRounding] = [.down, .up, .nearest]
    
    private let sizes: [BPKStarSize] = [.small, .large, .xLarge]
    
    func testStarRatingSizesRatingsAndRoundings() {
        BPKSnapshotVerifyViewLight(
            createView(ratings: ratings, roundings: roundings, sizes: sizes)
        )
        BPKSnapshotVerifyViewDark(
            createView(ratings: ratings, roundings: roundings, sizes: sizes)
        )
    }
}
