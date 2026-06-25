/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
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

/// Snapshot tests for BPKGraphicPromo with a custom @ViewBuilder background.
///
/// Tests use plain SwiftUI views rather than BPKVideoPlayer so the test target
/// has no dependency on the VideoPlayer module. The scenarios mirror what a
/// video background produces at each stage:
///
///   1. Loading state  — transparent background (Color.clear) lets the
///      fallbackColor show through, matching what PlayerLayerView renders
///      before the first frame is decoded (opacity 0).
///   2. Letterboxing — a 9:16-proportioned background inside the 3:4 mobile
///      card and the 1.96 tablet card verifies aspectFill clipping behaviour.
class BPKGraphicPromoVideoTests: XCTestCase {

    // MARK: - Loading state

    /// Transparent background surfaces the fallbackColor — no black flash.
    func test_sponsored_videoBackground_loading() {
        let sut = VStack {
            BPKGraphicPromo(
                headline: "There's always more to explore in Britain",
                background: { Color.clear },
                overlay: .linear(.high, .bottom),
                sponsorTitle: "Sponsored",
                partnerLogo: Image(decorative: "skyland", bundle: TestsBundle.bundle),
                sponsoredAccessibilityLabel: "Sponsored by Skyland",
                callToAction: .init(accessibilityLabel: "Learn more", onClick: {})
            )
            .fallbackColor(Color(.surfaceHighlightColor))
        }
        .frame(width: 375, height: 500)
        .padding()

        assertSnapshot(sut)
    }

    // MARK: - Aspect ratio / clipping

    /// 9:16 background in the 3:4 mobile card — should fill without pillarboxing.
    func test_sponsored_videoBackground_mobileLayout() {
        let sut = promoView(width: 375, height: 500, layoutType: .mobile)
        assertSnapshot(sut)
    }

    /// 9:16 background in the 1.96 tablet card — should fill without letterboxing.
    func test_sponsored_videoBackground_tabletLayout() {
        let sut = promoView(width: 768, height: 400, layoutType: .tablet)
        assertSnapshot(sut)
    }

    // MARK: - Private

    private func promoView(width: CGFloat, height: CGFloat, layoutType: BPKGraphicPromoLayoutType) -> some View {
        VStack {
            BPKGraphicPromo(
                headline: "There's always more to explore in Britain",
                background: {
                    Color(red: 0, green: 0.69, blue: 1)
                        .aspectRatio(9/16, contentMode: .fill)
                },
                layoutType: layoutType,
                overlay: .linear(.high, .bottom),
                sponsorTitle: "Sponsored",
                partnerLogo: Image(decorative: "skyland", bundle: TestsBundle.bundle),
                sponsoredAccessibilityLabel: "Sponsored by Skyland",
                callToAction: .init(accessibilityLabel: "Learn more", onClick: {})
            )
            .fallbackColor(Color(.surfaceHighlightColor))
        }
        .frame(width: width, height: height)
        .padding()
    }
}
