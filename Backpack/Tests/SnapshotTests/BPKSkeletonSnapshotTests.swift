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
import SnapshotTesting

class BPKSkeletonSnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    private func create(
        type: BPKSkeletonType = .image,
        size: BPKSkeletonSize = .default,
        style: BPKSkeletonStyle = .default,
        enrich: (BPKSkeleton) -> Void = { _ in }
    ) -> BPKSkeleton {
        let skeleton = BPKSkeleton(type: type, size: size, style: style)
        skeleton.translatesAutoresizingMaskIntoConstraints = false
        enrich(skeleton)
        return skeleton
    }
    
    func testImageSkeleton() {
        assertSnapshot(create())
    }
    
    func testCustomSizeImageSkeleton() {
        assertSnapshot(create(type: .image, size: .custom(size: CGSize(width: 111, height: 222))))
    }
    
    func testRoundedImageSkeleton() {
        assertSnapshot(create(type: .image, style: .rounded))
    }
    
    func testShimmerSkeleton() {
        func enrich(_ skeleton: BPKSkeleton) {
            BPKSkeleton.startShimmer(view: skeleton)
        }
        assertSnapshot(create(enrich: enrich))
    }
    
    func testSmallCircleSkeleton() {
        assertSnapshot(create(type: .circle, size: .small, style: .default))
    }
    
    func testDefaultCircleSkeleton() {
        assertSnapshot(create(type: .circle))
    }
    
    func testCustomSizeCircleSkeleton() {
        assertSnapshot(create(type: .circle, size: .custom(size: CGSize(width: 88, height: 111))))
    }
    
    func testSmallHeadlineSkeleton() {
        assertSnapshot(create(type: .headline, size: .small, style: .default))
    }
    
    func testDefaultHeadlineSkeleton() {
        assertSnapshot(create(type: .headline))
    }
    
    func testLargeHeadlineSkeleton() {
        assertSnapshot(create(type: .headline, size: .large, style: .default))
    }
    
    func testBodytextSkeleton() {
        assertSnapshot(create(type: .bodytext))
    }
    
    func testCustomSizeBodytextSkeleton() {
        assertSnapshot(create(type: .bodytext, size: .custom(size: CGSize(width: 280, height: 111))))
    }
}
