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
import SnapshotTesting
@testable import Backpack_SwiftUI

class BPKIconViewTests: XCTestCase {
    func testLargeIcon() {
        assertSnapshot(BPKIconView(.account, size: .large))
    }
    
    func testSmallIcon() {
        assertSnapshot(BPKIconView(.account, size: .small))
    }
    
    private func iconsGrid(size: BPKIcon.Size) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(26)), count: 14), spacing: 0) {
            ForEach((0..<Self.allIcons.count), id: \.self) { iconId in
                BPKIconView(Self.allIcons[iconId], size: size)
            }
        }
    }
    
    func testAllSmallIcons() {
        assertSnapshot(iconsGrid(size: .small))
    }
    
    func testAllLargeIcons() {
        assertSnapshot(iconsGrid(size: .large))
    }
}
