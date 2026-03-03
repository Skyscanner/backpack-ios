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

class BPKSwapTests: XCTestCase {
    func test_canvasDefaultStyle() {
        assertSnapshot(
            BPKSwap(
                style: .canvasDefault,
                accessibilityLabel: "Swap"
            ) {}
            .padding()
            .background(.canvasColor)
        )
    }
    
    func test_canvasContrastStyle() {
        assertSnapshot(
            BPKSwap(
                style: .canvasContrast,
                accessibilityLabel: "Swap"
            ) {}
            .padding()
            .background(.canvasContrastColor)
        )
    }
    
    func test_surfaceContrastStyle() {
        assertSnapshot(
            BPKSwap(
                style: .surfaceContrast,
                accessibilityLabel: "Swap"
            ) {}
            .padding()
            .background(.surfaceContrastColor)
        )
    }
    
    func test_accessibility() {
        let swap = BPKSwap(
            style: .canvasContrast,
            accessibilityLabel: "Swap origin and destination"
        ) {}
        .padding()
        assertA11ySnapshot(swap)
    }
}
