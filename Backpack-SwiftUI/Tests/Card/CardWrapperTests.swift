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

class CardWrapperTests: XCTestCase {
    private func header(title: String) -> some View {
        HStack(spacing: 5) {
            BPKIconView(.flag)
            BPKText(title, style: .caption)
                .foregroundColor(.white)
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.md)
    }
    
    private func content() -> some View {
        BPKText("""
            Lorem ipsum dolor sit amet,
            consectetuer adipiscing elit.
            Aenean commodo ligula eget dolor.
        """).lineLimit(3)
    }
    
    func testWithCard() {
        assertSnapshot(
            BPKCardWrapper(backgroundColor: .coreAccentColor) {
                header(title: "BPKCard")
            } card: {
                BPKCard(elevation: .none) {
                    content()
                }
            }
                .padding()
        )
    }
    
    func testWithDividedCard() {
        assertSnapshot(
            BPKCardWrapper(backgroundColor: .coreAccentColor) {
                header(title: "BPKDividedCard")
            } card: {
                BPKDividedCard {
                    content()
                        .padding()
                } secondaryContent: {
                    BPKText("Lorem ipsum dolor sit amet")
                        .padding()
                }
            }
                .padding()
        )
    }
    
    func testWithCorePrimaryColorBackground() {
        assertSnapshot(
            BPKCardWrapper(backgroundColor: .corePrimaryColor) {
                header(title: "PrimaryColor")
            } card: {
                BPKCard(elevation: .none) {
                    content()
                }
            }
                .padding()
        )
    }
}
