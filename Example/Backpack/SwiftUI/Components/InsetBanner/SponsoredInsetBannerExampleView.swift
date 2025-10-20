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
    private let orangeColor = Color(red: 1.000, green: 0.400, blue: 0.004, opacity: 1.000)
    private let yellowColor = Color(red: 1.000, green: 0.890, blue: 0.000, opacity: 1.000)
    var body: some View {
        ScrollView {
            VStack(spacing: .base) {
                noTitleView
                titleOnlyView
                subheadlineOnlyView
                allTitlesView
                onLightView
                sponsoredWithoutCTAOnLightView
                imageAndCTAView
            }
            .padding(.base)
        }
    }
    
    private var noTitleView: some View {
        BPKSponsoredInsetBanner(
            logoContent: Image("skyland").resizable().scaledToFit(),
            callToAction: .init(
                text: "Sponsored",
                accessibilityHint: "Double tap for more information",
                onClick: {}
            ),
            variant: .onDark,
            backgroundColor: orangeColor)
    }
    
    private var titleOnlyView: some View {
        BPKSponsoredInsetBanner(
            logoContent: Image("skyland").resizable().scaledToFit(),
            title: "Title",
            callToAction: .init(
                text: "Sponsored",
                accessibilityHint: "Double tap for more information",
                onClick: {}
            ),
            variant: .onDark,
            backgroundColor: orangeColor)
    }
    
    private var subheadlineOnlyView: some View {
        BPKSponsoredInsetBanner(
            logoContent: Image("skyland").resizable().scaledToFit(),
            subheadline: "Subheadline",
            callToAction: .init(
                text: "Sponsored",
                accessibilityHint: "Double tap for more information",
                onClick: {}
            ),
            variant: .onDark,
            backgroundColor: orangeColor)
    }
    
    private var allTitlesView: some View {
        BPKSponsoredInsetBanner(
            logoContent: Image("skyland").resizable().scaledToFit(),
            title: "Title",
            subheadline: "Subheadline",
            callToAction: .init(
                text: "Sponsored",
                accessibilityHint: "Double tap for more information",
                onClick: {}
            ),
            variant: .onDark,
            backgroundColor: orangeColor)
    }
    
    private var imageAndCTAView: some View {
        BPKSponsoredInsetBanner(
            logoContent: Image("skyland").resizable().scaledToFit(),
            title: "Title",
            subheadline: "Subheading",
            callToAction: .init(
                text: "Sponsored",
                accessibilityHint: "Double tap for more information",
                onClick: {}
            ),
            variant: .onDark,
            backgroundColor: orangeColor,
            image: Image("carousel_placeholder_1"),
        )
    }
    
    private var onLightView: some View {
        BPKSponsoredInsetBanner(
            logoContent: Image("skyland-black").resizable().scaledToFit(),
            title: "On Light variant",
            subheadline: "Subheadline",
            callToAction: .init(
                text: "Sponsored",
                accessibilityHint: "Double tap for more information",
                onClick: {}
            ),
            variant: .onLight,
            backgroundColor: yellowColor)
    }
    
    private var sponsoredWithoutCTAOnLightView: some View {
        BPKSponsoredInsetBanner(
            logoContent: Image("skyland-black").resizable().scaledToFit(),
            title: "On Light Variant",
            subheadline: "Without info icon",
            callToAction: .init(
                text: "Sponsored",
                accessibilityHint: "Double tap for more information",
                onClick: {}
            ),
            variant: .onLight,
            backgroundColor: yellowColor)
    }
}

struct SponsoredInsetBannerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SponsoredInsetBannerExampleView()
    }
}
