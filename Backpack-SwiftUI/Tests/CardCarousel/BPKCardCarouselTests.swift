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

class BPKCardCarouselTests: XCTestCase {
    func testCardCarousel() {
        assertSnapshot(
            BPKCardCarousel(
                cards: [
                    createCard(),
                    createCard(),
                    createCard()
                ],
                currentIndex: .constant(0)
            ).frame(width: 300, height: 530)
        )
    }
    
    // This test will assert that the carousel looks as expected in the different aspect ratios of iPad screen sizes
    func testCardCarouselIPad() {
        let cardCarousel = BPKCardCarousel(
            cards: [
                createCard(),
                createCard(),
                createCard()
            ],
            currentIndex: .constant(0)
        )
        
        // Then
        // IPad Landscape
        // Full
        assertSnapshot(
            cardCarousel
                .frame(width: 1112, height: 834)
            ,
            testName: "ipad_landscape_full"
        )
        
        // Two thirds
        assertSnapshot(
            cardCarousel
                .frame(width: 782, height: 834)
            ,
            testName: "ipad_landscape_two_thirds"
        )
        
        // One half
        assertSnapshot(
            cardCarousel
                .frame(width: 551, height: 834)
            ,
            testName: "ipad_landscape_half"
        )
        
        // One third
        assertSnapshot(
            cardCarousel
                .frame(width: 320, height: 834)
            ,
            testName: "ipad_landscape_third"
        )
        
        // iPad Potrait
        // Full
        assertSnapshot(
            cardCarousel
                .frame(width: 834, height: 1112)
            ,
            testName: "ipad_potrait_full"
        )
        
        // Two thirds
        assertSnapshot(
            cardCarousel
                .frame(width: 504, height: 1112)
            ,
            testName: "ipad_potrait_two_thirds"
        )
        
        // One third
        assertSnapshot(
            cardCarousel
                .frame(width: 320, height: 1112)
            ,
            testName: "ipad_potrait_third"
        )
    }
    
    func test_accessibility() {
        let cardCarousel = BPKCardCarousel(
            cards: [
                createCard(),
                createCard(),
                createCard()
            ],
            currentIndex: .constant(0)
        ).frame(width: 300, height: 530)
        
        assertA11ySnapshot(cardCarousel)
    }
    
    private func createCard() -> BPKCarouselCard<AnyView> {
        return BPKCarouselCard(
            content: {
                AnyView(
                    Image("dialog_image", bundle: TestsBundle.bundle)
                        .resizable()
                        .scaledToFill()
                )
            },
            title: "Test title",
            description: "Test descriptions" ,
            contentAccessibilityLabel: "Test label"
        )
    }
}
