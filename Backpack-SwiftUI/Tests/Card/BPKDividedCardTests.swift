/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

class BPKDividedCardTests: XCTestCase {
        
    private func primaryContent(title: String) -> some View {
        VStack {
            BPKText(title, style: .heading3)
            BPKText("""
                Lorem ipsum dolor sit amet,
                consectetuer adipiscing elit.
                Aenean commodo ligula eget dolor.
            """).lineLimit(3)
        }
    }
    
    private func secondaryContent() -> some View {
        BPKText("Lorem ipsum dolor sit amet")
    }
    
    func testDividedCardDefault() {
        assertSnapshot(
            BPKDividedCard {
                primaryContent(title: "Default")
            } secondaryContent: {
                secondaryContent()
            }
                .padding()
        )
    }
    
    func testDividedCardWithoutElevation() {
        assertSnapshot(
            BPKDividedCard(elevation: .none) {
                primaryContent(title: "Not Elevated")
            } secondaryContent: {
                secondaryContent()
            }
                .padding()
        )
    }
    
    func testDividedCardWithPaddedContent() {
        assertSnapshot(
            BPKDividedCard {
                primaryContent(title: "Padded")
                    .padding()
            } secondaryContent: {
                secondaryContent()
                    .padding()
            }
                .padding()
        )
    }
}

