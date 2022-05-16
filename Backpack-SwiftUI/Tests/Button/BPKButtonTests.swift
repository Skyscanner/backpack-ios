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

class BPKButtonTests: XCTestCase {
    let sizes: [BPKButton.Size] = [.default, .large]
    
    private func allStates(for style: BPKButton.Style) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(0..<2) { size in
                HStack(spacing: 2) {
                    BPKButton("Click Me", size: self.sizes[size], action: {})
                        .buttonStyle(style)
                    BPKButton("Click Me", enabled: .constant(false), size: self.sizes[size], action: {})
                        .buttonStyle(style)
                    BPKButton("Click Me", loading: .constant(true), size: self.sizes[size], action: {})
                        .buttonStyle(style)
                    BPKButton("Click Me", icon: .leading(icon: .account), size: self.sizes[size], action: {})
                        .buttonStyle(style)
                    BPKButton("Click Me", icon: .trailing(icon: .account), size: self.sizes[size], action: {})
                        .buttonStyle(style)
                    BPKButton(icon: .trailing(icon: .account), size: self.sizes[size], action: {})
                        .buttonStyle(style)
                }
                
            }
        }.frame(width: 650)
    }
    
    func testPrimaryButton() {
        assertSnapshot(allStates(for: .primary))
    }
    
    func testSecondaryButton() {
        assertSnapshot(allStates(for: .secondary))
    }
    
    func testSecondaryOnDarkButton() {
        assertSnapshot(
            allStates(for: .secondaryOnDark)
                .background(.blackTint01)
        )
    }
    
    func testDestructiveButton() {
        assertSnapshot(allStates(for: .destructive))
    }
    
    func testFeaturedButton() {
        assertSnapshot(allStates(for: .featured))
    }
    
    func testLinkButton() {
        assertSnapshot(allStates(for: .link))
    }
    
    func testLinkOnDarkButton() {
        assertSnapshot(
            allStates(for: .linkOnDark)
                .background(.blackTint01)
        )
    }
    
    func testPrimaryOnDarkButton() {
        assertSnapshot(
            allStates(for: .primaryOnDark)
                .background(.blackTint01)
        )
    }
    
    func testPrimaryOnLightButton() {
        assertSnapshot(
            allStates(for: .primaryOnLight)
                .background(.white)
        )
    }
    
}
