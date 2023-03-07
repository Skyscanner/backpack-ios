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

class BPKRatingTests: XCTestCase {
    
    private let isDefaultSizes = [true, false]
    private let subtitles = ["1,532 reviews", nil]
    private let showScaleAndShowZeroToFive: [(showScale: Bool, showZeroToFive: Bool)] = [
        (showScale: true, showZeroToFive: true),
        (showScale: true, showZeroToFive: false),
        (showScale: false, showZeroToFive: true)
    ]
    private let value: Float = 4.5
    
    private func ratings(withTitleView: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: BPKSpacing.sm.value) {
            ForEach(isDefaultSizes, id: \.self) { isDefaultSize in
                ForEach(self.subtitles, id: \.self) { subtitle in
                    ForEach(self.showScaleAndShowZeroToFive.indices, id: \.self) { index in

                        let (showScale, showZeroToFive) = self.showScaleAndShowZeroToFive[index]
                        if withTitleView {
                            BPKRating(
                                value: self.value,
                                ratingScale: showZeroToFive ? .zeroToFive: .zeroToTen,
                                size: isDefaultSize ? .default: .large,
                                subtitle: subtitle,
                                showScale: showScale
                            ) {
                                BPKIconView(.account, size: .large)
                            }
                        } else {
                            BPKRating(
                                title: "Excellent",
                                value: self.value,
                                ratingScale: showZeroToFive ? .zeroToFive: .zeroToTen,
                                size: isDefaultSize ? .default: .large,
                                subtitle: subtitle,
                                showScale: showScale
                            )
                        }
                    }
                }
            }
        }
    }

    func test_ratingsWithString() {
        // Then
        assertSnapshot(ratings())
    }
    
    func test_ratingsWithTitleView() {
        // Then
        assertSnapshot(ratings(withTitleView: true))
    }
}
