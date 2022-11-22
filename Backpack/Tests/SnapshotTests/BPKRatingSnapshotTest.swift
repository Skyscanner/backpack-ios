/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

class BPKRatingSnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    private let allLayouts: [BPKRatingLayout] = [
        .vertical,
        .horizontal,
        .horizontalPill
    ]
    
    private let sizes: [BPKRatingSize] = [
        .large,
        .base,
        .small,
        .extraSmall
    ]
    
    private func titleDefinition(_ title: String, theme: UIColor? = nil) -> BPKRatingTextDefinition {
        BPKRatingTextDefinition(
            highRatingText: title,
            mediumRatingText: title,
            lowRatingText: title
        )
    }
    
    private func applyTheme(to rating: BPKRating) {
        rating.lowRatingColor = .purple
        rating.mediumRatingColor = .orange
        rating.highRatingColor = .cyan
    }
    
    private func createView(
        ratings: [CGFloat],
        title: String,
        subtitle: String? = nil,
        themed: Bool = false
    ) -> UIView {
        viewsInStack(withStyles: sizes) { size in
            viewsInStack(withStyles: ratings) { rating in
                viewsInStack(withStyles: allLayouts, axis: .horizontal) { layout in
                    let view = BPKRating()
                    view.title = titleDefinition(title)
                    view.ratingValue = rating
                    if let subtitle = subtitle {
                        view.subtitle = titleDefinition(subtitle)
                    }
                    view.layout = layout
                    view.size = size
                    if themed {
                        applyTheme(to: view)
                    }
                    return view
                }
            }
        }
    }
    
    func testRating() {
        assertSnapshot(createView(ratings: [1, 7, 9], title: "Regular"))
    }
    
    func testRatingOutOfRange() {
        assertSnapshot(createView(ratings: [-1, 11], title: "Capped"))
    }
    
    func testRatingWithSubtitle() {
        assertSnapshot(createView(ratings: [1, 7, 9], title: "With Subtitle", subtitle: "Subtitle"))
    }
    
    func testRatingWithTheme() {
        assertSnapshot(createView(ratings: [1, 7, 9], title: "With Theme", themed: true))
    }
    
    func testRatingWithThemeWithSubtitle() {
        assertSnapshot(createView(ratings: [1, 7, 9], title: "With Theme", subtitle: "Subtitle", themed: true))
    }
}
