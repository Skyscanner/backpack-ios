/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd
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
import Backpack_Common
@testable import Backpack_SwiftUI

class BPKLinkTests: XCTestCase {
    func test_styles() {
        let view = VStack(alignment: .leading, spacing: .lg) {
            BPKLink(
                markdown: "Review our [privacy policy](https://www.example.com/privacy) or [terms](app://terms)."
            ) { url in
                _ = url
            }

            BPKLink(
                markdown: "Need help? [Contact support](app://support).",
                style: .onContrast
            ) { _ in }
            .padding()
            .background(Color(BPKColor.surfaceContrastColor))
            .cornerRadius(BPKCornerRadius.md.value)
        }
        .padding()

        assertSnapshot(view)
    }

    func test_accessibilitySnapshot() {
        let view = VStack(alignment: .leading, spacing: .lg) {
            BPKLink(
                markdown:
                    "Read our [accessibility statement](https://www.example.com/accessibility) or " +
                "[contact us](app://support)."
            ) { _ in }
                .fixedSize(horizontal: false, vertical: true)
        }

        assertA11ySnapshot(view, customHeight: 400)
    }
}
