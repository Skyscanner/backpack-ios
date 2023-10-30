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

class BPKInsetBannerViewTests: XCTestCase {
    private let orangeColor = Color(red: 1.000, green: 0.400, blue: 0.004, opacity: 1.000)
    private let yellowColor = Color(red: 1.000, green: 0.890, blue: 0.000, opacity: 1.000)
    func testInsetBannerWithTitle() {
        assertSnapshot(
            BPKInsetBanner(
                title: "Title",
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testInsetBannerWithSubheadlineAndBody() {
        assertSnapshot(
            BPKInsetBanner(
                title: "Title",
                subheadline: "Subheadline",
                bodyText: "This is a body text",
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testInsetBannerWithTitlesAndCallToAction() {
        assertSnapshot(
            BPKInsetBanner(
                title: "Title",
                subheadline: "Subheadline",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information"),
                bodyText: "This is a body text",
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testInsetBannerOnLightVariant() {
        assertSnapshot(
            BPKInsetBanner(
                title: "On Light variant",
                subheadline: "Subheadline",
                bodyText: "This is a body text",
                variant: .onLight,
                backgroundColor: yellowColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testInsetBannerWithImageTitlesAndCallToAction() {
        assertSnapshot(
            BPKInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle),
                title: "Title",
                subheadline: "Subheading",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Inset Banner"),
                bodyText: "You can change your destination, date of travel," +
                " or both, with no change fee. Valid for all " +
                "new bookings made up to 31 May for travel between now and 31 December 2020.",
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testInsetBannerShowingTermsAndConditions() {
        assertSnapshot(
            BPKInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle),
                title: "Title",
                subheadline: "Subheading",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Inset Banner"),
                bodyText: "You can change your destination, date of travel," +
                " or both, with no change fee. Valid for all " +
                "new bookings made up to 31 May for travel between now and 31 December 2020.",
                variant: .onDark,
                backgroundColor: orangeColor,
                isExpanded: true)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testInsetBannerOnLightWithoutInfoButton() {
        assertSnapshot(
            BPKInsetBanner(
                title: "On Light variant",
                subheadline: "Subheadline",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "More Info",
                    showIcon: false),
                bodyText: "This is a body text",
                variant: .onLight,
                backgroundColor: yellowColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testInsetBannerOnDarkWithSubheadlineOnly() {
        assertSnapshot(
            BPKInsetBanner(
                subheadline: "Subheadline only",
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    showIcon: true),
                bodyText: "This is a body text",
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testInsetBannerOnDarkWithImageWithoutTitleOrSubheadline() {
        assertSnapshot(
            BPKInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle),
                callToAction: .init(
                    text: "Sponsored",
                    accessibilityHint: "Double tap for more information",
                    showIcon: true),
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
    
    func testInsetBannerWithLongTitleAndSubHeadline() {
        assertSnapshot(
            BPKInsetBanner(
                logo: Image("skyland", bundle: TestsBundle.bundle),
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
                "Sed sit amet sagittis tellus, quis pharetra massa." +
                " Nunc nec nisl condimentum, efficitur sem vitae, facilisis erat. " +
                "Nullam ut tellus sed tortor eleifend accumsan sed nec enim." +
                " Nullam nec rhoncus nulla. Fusce placerat blandit semper.",
                subheadline: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
                "Sed sit amet sagittis tellus, quis pharetra massa." +
                " Nunc nec nisl condimentum, efficitur sem vitae, facilisis erat. ",
                variant: .onDark,
                backgroundColor: orangeColor)
            .frame(width: 375)
            .padding()
        )
    }
}
