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

class BPKCarouselTests: XCTestCase {
    private func createImage(_ name: String) -> some View {
        Image(systemName: "backpack.fill")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
    }
    
    func testWithOneImage() {
        assertSnapshot(
            BPKCarousel(
                images: [createImage("Amsterdam")],
                currentIndex: .constant(0)
            )
            .frame(width: 300, height: 250)
        )
    }
    
    func testWithThreeImages() {
        assertSnapshot(
            BPKCarousel(
                images: [
                    createImage("Amsterdam"),
                    createImage("Amsterdam"),
                    createImage("Amsterdam")
                ],
                currentIndex: .constant(0)
            )
            .frame(width: 300, height: 250)
        )
    }
    
    func testWithSecondSelected() {
        assertSnapshot(
            BPKCarousel(
                images: [
                    createImage("Amsterdam"),
                    createImage("Amsterdam"),
                    createImage("Amsterdam")
                ],
                currentIndex: .constant(1)
            )
            .frame(width: 300, height: 250)
        )
    }
}
