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

class BPKBadgeTests: XCTestCase {
    
    let styles: [BPKBadge.Style] = [
        .normal,
        .strong,
        .success,
        .warning,
        .destructive,
        .inverse,
        .outline
    ]
    
    private func testView(icon: BPKIcon? = nil) -> some View {
        ZStack {
            Color(.skyGrayTint06.darkVariant(.black))
            VStack {
                ForEach(styles, id: \.self) {
                    BPKBadge("Test badge", icon: icon)
                        .badgeStyle($0)
                }
            }
            .padding()
        }
    }
        
    func test_allBadgesWithoutIcon() {
        // Then
        assertSnapshot(testView())
    }
    
    func test_allBadgesWithIcon() {
        // Then
        assertSnapshot(testView(icon: .tickCircle))
    }
    
    func test_badgeWillKeepSingleLine() {
        // Given
        let view =
            BPKBadge("Quite a long line of text")
                .frame(maxWidth: 100)
        
        // Then
        assertSnapshot(view)
    }
}
