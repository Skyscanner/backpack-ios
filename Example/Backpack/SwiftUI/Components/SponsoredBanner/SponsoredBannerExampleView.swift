//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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

import SwiftUI
import Backpack_SwiftUI

struct SponsoredBannerExampleView: View {
    private let orangeColor = Color(red: 1.000, green: 0.400, blue: 0.004, opacity: 1.000)
    private let yellowColor = Color(red: 1.000, green: 0.890, blue: 0.000, opacity: 1.000)
    var body: some View {
        ScrollView {
            VStack(spacing: .base) {
                titleOnlyView
                allTitlesView
                onLightView
                imageAndCTAView
            }
            .padding(.base)
        }
    }
    
    private var titleOnlyView: some View {
        BPKSponsoredBanner(
            title: "Title",
            variant: .onDark,
            backgroundColor: orangeColor)
    }
    
    private var allTitlesView: some View {
        BPKSponsoredBanner(
            title: "Title",
            subheadline: "Subheadline",
            bodyText: "This is a body text",
            variant: .onDark,
            backgroundColor: orangeColor)
    }
    
    private var imageAndCTAView: some View {
        BPKSponsoredBanner(
            logo: Image("skyland"),
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
            showTerms: true
        )
    }
    
    private var onLightView: some View {
        BPKSponsoredBanner(
            title: "On Light variant",
            subheadline: "Subheadline",
            bodyText: "This is a body text",
            variant: .onLight,
            backgroundColor: yellowColor)
    }
}

struct SponsoredBannerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SponsoredBannerExampleView()
    }
}
