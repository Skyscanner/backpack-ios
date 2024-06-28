/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2024 Skyscanner Ltd
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

class BPKSaveCardButtonTests: XCTestCase {
    func test_allCases() {
        assertSnapshot(
            HStack(spacing: 0) {
                makeGroup(style: .default)
                makeGroup(style: .contained)
                    .background(.surfaceHighlightColor)
                makeGroup(style: .onDark)
                    .background(.black)
            }
        )
    }
    
    @ViewBuilder
    private func makeGroup(style: Backpack_SwiftUI.BPKCardButtonStyle) -> some View {
        VStack {
            BPKShareCardButton(
                size: .small,
                style: style,
                accessibilityLabel: "",
                action: { }
            )
            BPKShareCardButton(
                size: .default,
                style: style,
                accessibilityLabel: "",
                action: { }
            )
        }
        .padding()
    }
}
