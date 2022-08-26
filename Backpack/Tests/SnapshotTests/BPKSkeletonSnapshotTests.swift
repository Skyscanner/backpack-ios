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
import FBSnapshotTestCase
import Backpack

class BPKSkeletonSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
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
        BPKSnapshotVerifyViewLight(create())
        BPKSnapshotVerifyViewDark(create())
    }
    
    func testCustomSizeImageSkeleton() {
        BPKSnapshotVerifyViewLight(create(type: .image, size: .custom(size: CGSize(width: 111, height: 222))))
        BPKSnapshotVerifyViewDark(create(type: .image, size: .custom(size: CGSize(width: 111, height: 222))))
    }
    
    func testRoundedImageSkeleton() {
        BPKSnapshotVerifyViewLight(create(type: .image, style: .rounded))
        BPKSnapshotVerifyViewDark(create(type: .image, style: .rounded))
    }
    
    func testShimmerSkeleton() {
        func enrich(_ skeleton: BPKSkeleton) {
            BPKSkeleton.startShimmer(view: skeleton)
        }
        BPKSnapshotVerifyViewLight(create(enrich: enrich))
        BPKSnapshotVerifyViewDark(create(enrich: enrich))
    }
    
    func testSmallCircleSkeleton() {
        BPKSnapshotVerifyViewLight(create(type: .circle, size: .small, style: .default))
        BPKSnapshotVerifyViewDark(create(type: .circle, size: .small, style: .default))
    }
    
    func testDefaultCircleSkeleton() {
        BPKSnapshotVerifyViewLight(create(type: .circle))
        BPKSnapshotVerifyViewDark(create(type: .circle))
    }
    
    func testCustomSizeCircleSkeleton() {
        BPKSnapshotVerifyViewLight(create(type: .circle, size: .custom(size: CGSize(width: 88, height: 111))))
        BPKSnapshotVerifyViewDark(create(type: .circle, size: .custom(size: CGSize(width: 88, height: 111))))
    }
    
    func testSmallHeadlineSkeleton() {
        BPKSnapshotVerifyViewLight(create(type: .headline, size: .small, style: .default))
        BPKSnapshotVerifyViewDark(create(type: .headline, size: .small, style: .default))
    }
    
    func testDefaultHeadlineSkeleton() {
        BPKSnapshotVerifyViewLight(create(type: .headline))
        BPKSnapshotVerifyViewDark(create(type: .headline))
    }
    
    func testLargeHeadlineSkeleton() {
        BPKSnapshotVerifyViewLight(create(type: .headline, size: .large, style: .default))
        BPKSnapshotVerifyViewDark(create(type: .headline, size: .large, style: .default))
    }
    
    func testBodytextSkeleton() {
        BPKSnapshotVerifyViewLight(create(type: .bodytext))
        BPKSnapshotVerifyViewDark(create(type: .bodytext))
    }
    
    func testCustomSizeBodytextSkeleton() {
        BPKSnapshotVerifyViewLight(create(type: .bodytext, size: .custom(size: CGSize(width: 280, height: 111))))
        BPKSnapshotVerifyViewDark(create(type: .bodytext, size: .custom(size: CGSize(width: 280, height: 111))))
    }
}
