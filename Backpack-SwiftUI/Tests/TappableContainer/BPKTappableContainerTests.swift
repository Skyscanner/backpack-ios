/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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

class BPTappableContainerTests: XCTestCase {
    func test_tappableContainer() {
        assertSnapshot(
            BPKTappableContainer(
                accessibilityLabel: "bpk_tappable_container_example",
                action: { },
                content: {
                    BPKText("Simple Text", style: .bodyDefault)
                        .foregroundColor(.textPrimaryColor)
                        .padding()
                        .background(.surfaceDefaultColor)
                        .clipShape(RoundedRectangle(cornerRadius: .sm))
                }
            )
            .frame(width: 200)
        )
    }

    func test_accessibility() {
        let tappableContainer =  BPKTappableContainer(
            accessibilityLabel: "bpk_tappable_container_example",
            action: { },
            content: {
                BPKText("Simple Text", style: .bodyDefault)
                    .foregroundColor(.textPrimaryColor)
                    .padding()
                    .background(.surfaceDefaultColor)
                    .clipShape(RoundedRectangle(cornerRadius: .sm))
            }
        )
        .frame(width: 200)
        assertA11ySnapshot(tappableContainer)
    }
}
