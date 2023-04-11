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

class BPKFlareTests: XCTestCase {
    func testMediumFlareView() {
        assertSnapshot(
            BPKFlareView(
                size: .medium,
                content: {
                    Color(.coreAccentColor)
                        .frame(width: 100, height: 100)
                }
            )
        )
    }
    
    func testSmallFlareView() {
        assertSnapshot(
            BPKFlareView(
                size: .small,
                content: {
                    Color(.coreAccentColor)
                        .frame(width: 100, height: 100)
                }
            )
        )
    }
    
    func testLargeFlareView() {
        assertSnapshot(
            BPKFlareView(
                size: .large,
                content: {
                    Color(.coreAccentColor)
                        .frame(width: 150, height: 100)
                }
            )
        )
    }
    
    func testRectFlareView() {
        assertSnapshot(
            BPKFlareView(
                roundedCorners: false,
                content: {
                    Color(.coreAccentColor)
                        .frame(width: 150, height: 100)
                }
            )
            .padding()
        )
    }
    
    func testTopFlareView() {
        assertSnapshot(
            BPKFlareView(
                direction: .top,
                content: {
                    Color(.coreAccentColor)
                        .frame(width: 150, height: 100)
                }
            )
        )
    }
}
