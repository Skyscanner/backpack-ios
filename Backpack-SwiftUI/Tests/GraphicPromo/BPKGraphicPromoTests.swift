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
@testable import Backpack_Common

class BPKGraphicPromoTests: XCTestCase {
    func test_topAligned() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                kicker: "Travel tips",
                headline: "Three peaks challenge",
                subheadline: "How to complete the trip in three days",
                image: Image("dialog_image", bundle: TestsBundle.bundle)
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
                verticalAlignment: .bottom
            )
            .fallbackColor(Color(.statusDangerFillColor))
        }
        .frame(width: 375, height: 800)
        .padding()
        
        // When
        assertSnapshot(sut)
    }
    
    func test_sponsored() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                headline: "Three peaks challenge",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                sponsorTitle: "Sponsored",
                partnerLogo: Image(decorative: "skyland", bundle: TestsBundle.bundle),
                sponsoredAccessibilityLabel: "Sponsored by: Skyland"
            )
            .fallbackColor(Color(.statusDangerFillColor))
        }
            .frame(width: 375, height: 800)
            .padding()
        
        // When
        assertSnapshot(sut)
    }
    
    func test_sponsored_tabletLayout() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                headline: "Three peaks challenge",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                layoutType: .tablet,
                sponsorTitle: "Sponsored",
                partnerLogo: Image(decorative: "skyland", bundle: TestsBundle.bundle),
                sponsoredAccessibilityLabel: "Sponsored by: Skyland"
            )
            .fallbackColor(Color(.statusDangerFillColor))
        }
            .frame(width: 800)
            .padding()
        
        // When
        assertSnapshot(sut)
    }
    
    func test_sponsored_desktopLayout() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                headline: "Three peaks challenge",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                layoutType: .desktop,
                sponsorTitle: "Sponsored",
                partnerLogo: Image(decorative: "skyland", bundle: TestsBundle.bundle),
                sponsoredAccessibilityLabel: "Sponsored by: Skyland"
            )
            .fallbackColor(Color(.statusDangerFillColor))
        }
            .frame(width: 1024)
            .padding()
        
        // When
        assertSnapshot(sut)
    }
    
    func test_sponsored_longText() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                headline: "Three peaks challenge.",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                sponsorTitle: "This will be a longer string that should change the layout to vertical",
                partnerLogo: Image(decorative: "skyland", bundle: TestsBundle.bundle),
                sponsoredAccessibilityLabel: "Sponsored by: Skyland"
            )
            .fallbackColor(Color(.statusDangerFillColor))
        }
        .frame(width: 375, height: 800)
        .padding()
        
        // When
        assertSnapshot(sut)
    }
    
    func test_sponsored_a11y() {
        // Given
        BPKFont.setDynamicType(enabled: true)
        let sut = VStack {
            BPKGraphicPromo(
                headline: "Three peaks challenge",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                sponsorTitle: "This will be a longer string that should change the layout to vertical",
                partnerLogo: Image(decorative: "skyland", bundle: TestsBundle.bundle),
                sponsoredAccessibilityLabel: "Sponsored by: Skyland"
            )
            .fallbackColor(Color(.statusDangerFillColor))
        }
        .frame(width: 375, height: 1000)
        .padding()
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        
        // When
        assertSnapshot(sut)
    }
    
    func test_sponsored_noLogo() {
        // Given
        let sut = VStack {
            BPKGraphicPromo(
                headline: "Three peaks challenge",
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                sponsorTitle: "Sponsored",
                partnerLogo: nil,
                sponsoredAccessibilityLabel: "Sponsored by: Skyland"
            )
            .fallbackColor(Color(.statusDangerFillColor))
        }
            .frame(width: 375, height: 800)
            .padding()
        
        // When
        assertSnapshot(sut)
    }
}
