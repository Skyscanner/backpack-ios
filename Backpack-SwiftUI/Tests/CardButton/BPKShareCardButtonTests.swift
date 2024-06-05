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

class BPKShareCardButtonTests: XCTestCase {
    func test_whenCheckedIsFalse() {
        assertSnapshot(
            HStack(spacing: 0) {
                makeGroup(style: .default, checked: false)
                makeGroup(style: .contained, checked: false)
                    .background(.surfaceHighlightColor)
                makeGroup(style: .onDark, checked: false)
                    .background(.black)
            }
        )
    }
    
    func test_whenCheckedIsTrue() {
        assertSnapshot(
            HStack(spacing: 0) {
                makeGroup(style: .default, checked: true)
                makeGroup(style: .contained, checked: true)
                    .background(.surfaceHighlightColor)
                makeGroup(style: .onDark, checked: true)
                    .background(.black)
            }
        )
    }
    
    @ViewBuilder
    private func makeGroup(
        style: Backpack_SwiftUI.BPKCardButtonStyle,
        checked: Bool
    ) -> some View {
        VStack {
            BPKSaveCardButton(
                size: .small,
                style: style,
                checked: checked,
                accessibilityLabel: "",
                action: { }
            )
            BPKSaveCardButton(
                size: .default,
                style: style,
                checked: checked,
                accessibilityLabel: "",
                action: { }
            )
        }
        .padding()
    }
}
