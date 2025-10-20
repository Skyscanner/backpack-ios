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

class BPKSponsoredInsetBannerViewTests: XCTestCase {
    func testSponsoredInsetBannerWithLogoAndSponsoredLabelOnly() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                sponsoredLabel: "Sponsored",
                onSponsoredLabelTapped: {}
            )
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerWithTitle() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                sponsoredLabel: "Sponsored",
                onSponsoredLabelTapped: {},
                title: "Amazing offer just for you"
            )
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerWithTitleAndSubheadline() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                sponsoredLabel: "Sponsored",
                onSponsoredLabelTapped: {},
                title: "Amazing offer just for you",
                subheadline: "Limited time only - book now"
            )
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerWithImage() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                sponsoredLabel: "Sponsored",
                onSponsoredLabelTapped: {},
                title: "Amazing offer",
                subheadline: "Limited time only",
                image: Image("carousel_0", bundle: TestsBundle.bundle).resizable().scaledToFit()
            )
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerWithImageOnly() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                sponsoredLabel: "Sponsored",
                onSponsoredLabelTapped: {},
                image: Image("carousel_0", bundle: TestsBundle.bundle).resizable().scaledToFit()
            )
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerWithLongText() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                sponsoredLabel: "Sponsored",
                onSponsoredLabelTapped: {},
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
                "Sed sit amet sagittis tellus, quis pharetra massa.",
                subheadline: "Nunc nec nisl condimentum, efficitur sem vitae, facilisis erat. " +
                "Nullam ut tellus sed tortor eleifend accumsan."
            )
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerWithSubheadlineOnly() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                sponsoredLabel: "Sponsored",
                onSponsoredLabelTapped: {},
                subheadline: "Book now and save up to 40%"
            )
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerAccessibility() {
        assertA11ySnapshot(
            BPKSponsoredInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                sponsoredLabel: "Sponsored",
                onSponsoredLabelTapped: {},
                title: "Amazing offer",
                subheadline: "Limited time only"
            )
            .frame(width: 375)
        )
    }
}
