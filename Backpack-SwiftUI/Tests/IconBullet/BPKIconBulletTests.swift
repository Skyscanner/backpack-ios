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
@testable import Backpack_SwiftUI

class BPKIconBulletTests: XCTestCase {
    let styles: [(BPKIconBullet.Style, BPKIconBullet.Size)] = [
        (.loyalty, .small),
        (.brand, .small),
        (.strong, .small),
        (.loyalty, .medium),
        (.brand, .medium),
        (.strong, .medium),
        (.loyalty, .large),
        (.brand, .large),
        (.strong, .large)
        ]
    
    private func testView() -> some View {
        VStack(spacing: 0) {
            ForEach(Array(styles.enumerated()), id: \.offset) { _, style in
                BPKIconBullet(icon: .trendDown)
                    .iconBulletStyle(style.0)
                    .iconBulletSize(style.1)
                    .padding(4)
            }
        }
    }
    
    func test_allIconBullets() {
        // Then
        assertSnapshot(testView())
    }
    
    
    func test_accessibility() {
        let iconBullet = BPKIconBullet(icon: .accessibility)
        assertA11ySnapshot(iconBullet)
    }
}
