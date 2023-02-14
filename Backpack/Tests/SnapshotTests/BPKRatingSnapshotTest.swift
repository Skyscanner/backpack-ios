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

    private let sizes = [BPKRatingSize.default, BPKRatingSize.large]
    private let subtitles = ["1,532 reviews", nil]
    private let visibilityAndScalesType = [
        (true, BPKRatingScale.zeroToFive),
        (true, BPKRatingScale.zeroToTen),
        (false, BPKRatingScale.zeroToFive)
    ]
    private let showCustomTitleViews = [false, true]

    struct BPKRatingParameter {
        let scale: BPKRatingScale
        let size: BPKRatingSize
        let subtitle: String?
        let showScale: Bool
        let showCustomTitleView: Bool
    }

    private func createRatingStackView() -> UIView {
        var styles: [BPKRatingParameter] = []
        sizes.forEach { size in
            subtitles.forEach { (subtitle: String?) in
                visibilityAndScalesType.forEach { (showScale: Bool, scale: BPKRatingScale) in
                    showCustomTitleViews.forEach { (showCustomTitleView: Bool) in
                        let parameter = BPKRatingParameter(
                            scale: scale,
                            size: size,
                            subtitle: subtitle,
                            showScale: showScale,
                            showCustomTitleView: showCustomTitleView)
                        styles.append(parameter)
                    }
                }
            }
        }

        return viewsInStack(
            withStyles: styles,
            backgroundColor: BPKColor.surfaceDefaultColor
        ) { style in
            createRating(style)
        }
    }

    private func createRating(_ parameter: BPKRatingParameter) -> BPKRating {
        if parameter.showCustomTitleView {
            let starRating = BPKStarRating()
            starRating.rating = 4.5
            return BPKRating(
                accessibilityLabel: "",
                value: 4.5,
                ratingScale: parameter.scale,
                size: parameter.size,
                subtitle: parameter.subtitle,
                showScale: parameter.showScale,
                titleView: starRating
            )
        } else {
            return BPKRating(
                accessibilityLabel: "",
                title: "Excellent",
                value: 4.5,
                ratingScale: parameter.scale,
                size: parameter.size,
                subtitle: parameter.subtitle,
                showScale: parameter.showScale
            )
        }
    }

    func testBPKRatingSnapshot() {
        let ratingsStackView = createRatingStackView()
        assertSnapshot(ratingsStackView)
    }
}
