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
    
    let sizes: [BPKRating.Size] = [.default, .large]
    let subtitles = ["1,532 reviews", nil]
    let scaleAndVisible: [(BPKRating.Scale, Bool)] = [
        (scale: .zeroToFive, showScale: true),
        (scale: .zeroToTen, showScale: true),
        (scale: .zeroToFive, showScale: false)
    ]
    
    private func ratings(withTitleView: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: BPKSpacing.sm.value) {
            ForEach(sizes, id: \.self) { size in
                ForEach(self.subtitles, id: \.self) { subtitle in
                    ForEach(0..<self.scaleAndVisible.count, id: \.self) { count in
                        let (scale, showScale) = self.scaleAndVisible[count]
                        if withTitleView {
                            BPKRating(
                                accessibilityLabel: "",
                                value: 4.5,
                                ratingScale: scale,
                                size: size,
                                subtitle: subtitle,
                                showScale: showScale
                            ) {
                                AnyView(
                                    BPKIconView(.account, size: .large)
                                )
                            }
                        } else {
                            BPKRating(
                                accessibilityLabel: "",
                                title: "Excellent",
                                value: 4.5,
                                ratingScale: scale,
                                size: size,
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
