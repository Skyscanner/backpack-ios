/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2025 Skyscanner Ltd
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
@testable import Backpack_Common

final class BPKCardConfigurationTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        let config = BpkConfiguration.shared
        do {
            try config.set(configs: [.card])
        } catch {
            XCTFail("Failed to set card config")
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        BpkConfiguration.shared.reset()
    }
    
    func content(_ title: String) -> some View {
        BPKText(title)
    }

    func testCardDefault() {
        assertSnapshot(
            VStack {
                BPKCard { content("Default") }
            }
            .padding()
            .background(.canvasContrastColor)
        )
    }

    func testCardSelected() {
        assertSnapshot(
            VStack {
                BPKCard(elevation: .focus) { content("Focused") }
            }
            .padding()
            .background(.canvasContrastColor)
        )
    }

    func testCardNoShadow() {
        assertSnapshot(
            VStack {
                BPKCard(elevation: .none) { content("No Shadow") }
            }
            .padding()
            .background(.canvasContrastColor)
        )
    }
    
    func testCardNotPadded() {
        assertSnapshot(
            VStack {
                BPKCard(padding: .none) { content("Not Padded") }
            }
            .padding()
            .background(.canvasContrastColor)
        )
    }

    func testCardLargeCorner() {
        assertSnapshot(
            VStack {
                BPKCard(cornerStyle: .large) { content("Large Corner") }
            }
            .padding()
            .background(.canvasContrastColor)
        )
    }
    
    func testCardOnDefault() {
        assertSnapshot(
            VStack {
                BPKCard(cardStyle: .onDefault) { content("On Default") }
            }
            .padding()
            .background(.surfaceDefaultColor)
        )
    }
}
