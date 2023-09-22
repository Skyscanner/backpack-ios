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
import SnapshotTesting
import Backpack_SwiftUI

class BPKSponsoredBannerViewTests: XCTestCase {
    private let orangeColor = Color(red: 1.000, green: 0.400, blue: 0.004, opacity: 1.000)
    private let yellowColor = Color(red: 1.000, green: 0.890, blue: 0.000, opacity: 1.000)
    func testSponsoredBannerWithTitle() {
        assertSnapshot(
            BPKSponsoredBanner(
                title: "Title",
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredBannerWithSubheadlineAndBody() {
        assertSnapshot(
            BPKSponsoredBanner(
                title: "Title",
                subheadline: "Subheadline",
                bodyText: "This is a body text",
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredBannerWithTitlesAndCallToAction() {
        assertSnapshot(
            BPKSponsoredBanner(
                title: "Title",
                subheadline: "Subheadline",
                callToAction: .init(text: "Sponsored",
                                    accessibilityLabel: "More information"),
                bodyText: "This is a body text",
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredBannerOnLightVariant() {
        assertSnapshot(
            BPKSponsoredBanner(
                title: "On Light variant",
                subheadline: "Subheadline",
                bodyText: "This is a body text",
                variant: .onLight,
                backgroundColor: yellowColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredBannerWithImageTitlesAndCallToAction() {
        assertSnapshot(
            BPKSponsoredBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle),
                title: "Title",
                subheadline: "Subheading",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityLabel: "Sponsored Banner"),
                bodyText: "You can change your destination, date of travel," +
                " or both, with no change fee. Valid for all " +
                "new bookings made up to 31 May for travel between now and 31 December 2020.",
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredBannerShowingTermsAndConditions() {
        assertSnapshot(
            BPKSponsoredBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle),
                title: "Title",
                subheadline: "Subheading",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityLabel: "Sponsored Banner"),
                bodyText: "You can change your destination, date of travel," +
                " or both, with no change fee. Valid for all " +
                "new bookings made up to 31 May for travel between now and 31 December 2020.",
                variant: .onDark,
                backgroundColor: orangeColor,
                showTerms: true)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredBannerOnLightWithoutInfoButton() {
        assertSnapshot(
            BPKSponsoredBanner(
                title: "On Light variant",
                subheadline: "Subheadline",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityLabel: "More Info",
                    showIcon: false),
                bodyText: "This is a body text",
                variant: .onLight,
                backgroundColor: yellowColor)
            .frame(width: 375)
            .padding()
        )
    }
}
