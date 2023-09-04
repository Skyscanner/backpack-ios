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

class BPKGraphicPromoTests: XCTestCase {
    func test_topAligned() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the trip in three days",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                action: {}
            )
            .fallbackColor(Color(.statusDangerFillColor))
        }
        .frame(width: 375, height: 800)
        .padding()
        
        // When
        assertSnapshot(sut)
    }
    
    func test_bottomAligned() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the trip in three days",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                verticalAlignment: .bottom,
                action: {}
            )
            .fallbackColor(Color(.statusDangerFillColor))
        }
        .frame(width: 375, height: 800)
        .padding()
        
        // When
        assertSnapshot(sut)
    }
    
    func test_topAligned_sponsored() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the trip in three days",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                action: {}
            )
            .fallbackColor(Color(.statusDangerFillColor))
            .sponsor(
                title: "Sponsored",
                logo: Image(decorative: "skyland", bundle: TestsBundle.bundle),
                accessibilityLabel: "Sponsored by: Skyland"
            )
        }
        .frame(width: 375, height: 800)
        .padding()
        
        // When
        assertSnapshot(sut)
    }
    
    func test_bottomAligned_sponsored() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the trip in three days",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                verticalAlignment: .bottom,
                action: {}
            )
            .fallbackColor(Color(.statusDangerFillColor))
            .sponsor(
                title: "Sponsored",
                logo: Image(decorative: "skyland", bundle: TestsBundle.bundle),
                accessibilityLabel: "Sponsored by: Skyland"
            )
        }
        .frame(width: 375, height: 800)
        .padding()
        
        // When
        assertSnapshot(sut)
    }
    
    func test_topAligned_sponsored_a11y() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the trip in three days",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                action: {}
            )
            .fallbackColor(Color(.statusDangerFillColor))
            .sponsor(
                title: "Sponsored",
                logo: Image(decorative: "skyland", bundle: TestsBundle.bundle),
                accessibilityLabel: "Sponsored by: Skyland"
            )
        }
        .frame(width: 375, height: 1000)
        .padding()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        
        // When
        assertSnapshot(sut)
    }

}
