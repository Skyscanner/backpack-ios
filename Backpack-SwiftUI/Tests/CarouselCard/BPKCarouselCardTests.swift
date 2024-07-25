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

class BPKCarouselCardTests: XCTestCase {
    func testCarouselCard() {
        assertSnapshot(
            BPKCarouselCard(
                content: {
                    Image("dialog_image", bundle: TestsBundle.bundle)
                        .resizable()
                        .scaledToFill()
                },
                title: "Test title",
                description: "Test descriptions" ,
                contentAccessibilityLabel: "Test label"
            ).frame(width: 300, height: 530)
        )
    }
    
    func test_accessibility() {
        let card = BPKCarouselCard(
            content: {
                Image("dialog_image", bundle: TestsBundle.bundle)
                    .resizable()
                    .scaledToFill()
            },
            title: "Test title",
            description: "Test descriptions" ,
            contentAccessibilityLabel: "Test label"
        ).frame(width: 300, height: 530)
        assertA11ySnapshot(card)
    }
}
