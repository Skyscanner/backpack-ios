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
    private let orangeColor = Color(red: 1.000, green: 0.400, blue: 0.004, opacity: 1.000)
    private let yellowColor = Color(red: 1.000, green: 0.890, blue: 0.000, opacity: 1.000)
    func testSponsoredInsetBannerWithNoTitleorSubheadline() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logoContent: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    onClick: {}
                ),
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerWithTitleAndSubheadline() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logoContent: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                title: "Title",
                subheadline: "Subheadline",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    onClick: {}
                ),
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerWithTitlesAndCallToAction() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logoContent: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                title: "Title",
                subheadline: "Subheadline",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    onClick: {}
                ),
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerOnLightVariant() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logoContent: Image("skyland-black", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                title: "On Light variant",
                subheadline: "Subheadline",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    onClick: {}
                ),
                variant: .onLight,
                backgroundColor: yellowColor)
            .frame(width: 375)
            .padding()
        )
    }

    func testSponsoredInsetBannerOnLightWithImage() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logoContent: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                subheadline: "Subheadline only",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    onClick: {}
                ),
                variant: .onLight,
                backgroundColor: orangeColor,
                image: Image("dialog_image", bundle: TestsBundle.bundle),
            )
            .frame(width: 375)
            .padding()
        )
    }

    func testSponsoredInsetBannerWithImageTitlesAndCallToAction() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logoContent: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                title: "Title",
                subheadline: "Subheading",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    onClick: {}
                ),
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }

    func testSponsoredInsetBannerOnDarkNoTitle() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logoContent: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                subheadline: "Subheadline only",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    onClick: {}
                ),
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }

    func testSponsoredInsetBannerOnDarkWithSubheadlineOnlyAndImage() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logoContent: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                subheadline: "Subheadline only",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    onClick: {}
                ),
                variant: .onDark,
                backgroundColor: orangeColor,
                image: Image("dialog_flare", bundle: TestsBundle.bundle),
            )
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerOnDarkWithImageWithoutTitleOrSubheadline() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logoContent: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    onClick: {}
                ),
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSponsoredInsetBannerWithLongTitleAndSubHeadline() {
        assertSnapshot(
            BPKSponsoredInsetBanner(
                logoContent: Image("skyland", bundle: TestsBundle.bundle).resizable().scaledToFit(),
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
                "Sed sit amet sagittis tellus, quis pharetra massa." +
                " Nunc nec nisl condimentum, efficitur sem vitae, facilisis erat. " +
                "Nullam ut tellus sed tortor eleifend accumsan sed nec enim." +
                " Nullam nec rhoncus nulla. Fusce placerat blandit semper.",
                subheadline: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
                "Sed sit amet sagittis tellus, quis pharetra massa." +
                " Nunc nec nisl condimentum, efficitur sem vitae, facilisis erat. ",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    onClick: {}
                ),
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
}
