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
import Backpack

class BPKSkeletonTest: XCTestCase {
    func testInitWithAllDefaultValues() {
        let skeleton = BPKSkeleton()
        XCTAssertEqual(skeleton.type, .image)
        XCTAssertEqual(skeleton.size, .default)
        XCTAssertEqual(skeleton.style, .default)
    }
    
    func testInitWithOptionalSize() {
        let skeleton = BPKSkeleton(type: .circle, size: .small)
        XCTAssertEqual(skeleton.type, .circle)
        XCTAssertEqual(skeleton.size, .small)
    }
    
    func testInitWithStyle() {
        let skeleton = BPKSkeleton(type: .image, style: .rounded)
        XCTAssertEqual(skeleton.type, .image)
        XCTAssertEqual(skeleton.style, .rounded)
    }
    
    func testInitWithCustomSize() {
        let skeleton = BPKSkeleton(type: .image, size: .custom(size: CGSize(width: 111, height: 222)), style: .rounded)
        XCTAssertEqual(skeleton.type, .image)
        XCTAssertEqual(skeleton.size, .custom(size: CGSize(width: 111, height: 222)))
        XCTAssertEqual(skeleton.style, .rounded)
    }
}
