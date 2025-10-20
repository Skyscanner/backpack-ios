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

struct SponsoredInsetBannerExampleView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .base) {
                logoAndSponsoredOnly
                withTitle
                withTitleAndSubheadline
                withImage
                withImageOnly
                withSubheadlineOnly
            }
            .padding(.base)
        }
    }
    
    private var logoAndSponsoredOnly: some View {
        BPKSponsoredInsetBanner(
            logo: Image("skyland").resizable().scaledToFit(),
            sponsoredLabel: "Sponsored",
            onSponsoredLabelTapped: {
                print("Sponsored label tapped")
            },
            sponsoredAccessibilityHint: "Double tap for more information"
        )
    }
    
    private var withTitle: some View {
        BPKSponsoredInsetBanner(
            logo: Image("skyland").resizable().scaledToFit(),
            sponsoredLabel: "Sponsored",
            onSponsoredLabelTapped: {
                print("Sponsored label tapped")
            },
            sponsoredAccessibilityHint: "Double tap for more information",
            title: "Amazing offer just for you"
        )
    }
    
    private var withTitleAndSubheadline: some View {
        BPKSponsoredInsetBanner(
            logo: Image("skyland").resizable().scaledToFit(),
            sponsoredLabel: "Sponsored",
            onSponsoredLabelTapped: {
                print("Sponsored label tapped")
            },
            sponsoredAccessibilityHint: "Double tap for more information",
            title: "Amazing offer just for you",
            subheadline: "Limited time only - book now and save"
        )
    }
    
    private var withImage: some View {
        BPKSponsoredInsetBanner(
            logo: Image("skyland").resizable().scaledToFit(),
            sponsoredLabel: "Sponsored",
            onSponsoredLabelTapped: {
                print("Sponsored label tapped")
            },
            sponsoredAccessibilityHint: "Double tap for more information",
            title: "Summer getaway",
            subheadline: "Save up to 40% on selected destinations",
            image: Image("carousel_0").resizable().scaledToFit()
        )
    }
    
    private var withImageOnly: some View {
        BPKSponsoredInsetBanner(
            logo: Image("skyland").resizable().scaledToFit(),
            sponsoredLabel: "Sponsored",
            onSponsoredLabelTapped: {
                print("Sponsored label tapped")
            },
            sponsoredAccessibilityHint: "Double tap for more information",
            image: Image("carousel_0").resizable().scaledToFit()
        )
    }
    
    private var withSubheadlineOnly: some View {
        BPKSponsoredInsetBanner(
            logo: Image("skyland").resizable().scaledToFit(),
            sponsoredLabel: "Sponsored",
            onSponsoredLabelTapped: {
                print("Sponsored label tapped")
            },
            sponsoredAccessibilityHint: "Double tap for more information",
            subheadline: "Book now and save up to 40%"
        )
    }
}

struct SponsoredInsetBannerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SponsoredInsetBannerExampleView()
    }
}
