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

class BPKSkeletonTests: XCTestCase {
    
    private func testView() -> some View {
        ZStack {
            Color(.clear.darkVariant(.black))
            VStack {
                Group {
                    BPKSkeleton.image()
                    BPKSkeleton.image(size: .small) // Should be the same as .default
                    BPKSkeleton.image(style: .rounded)
                    BPKSkeleton.image(size: .custom(size: CGSize(width: 111, height: 111)))
                    BPKSkeleton.image(size: .custom(size: CGSize(width: 111, height: 222)))
                }
                
                Group {
                    BPKSkeleton.circle()
                    BPKSkeleton.circle(size: .small)
                    BPKSkeleton.circle(size: .large) // Should be the same as .default
                    BPKSkeleton.circle(size: .custom(size: CGSize(width: 111, height: 111)))
                    BPKSkeleton.circle(size: .custom(size: CGSize(width: 111, height: 222))) // Should be the same as above
                }
                
                Group {
                    BPKSkeleton.headline()
                    BPKSkeleton.headline(size: .small)
                    BPKSkeleton.headline(size: .large)
                    BPKSkeleton.headline(size: .custom(size: CGSize(width: 111, height: 111)))
                }
                
                Group {
                    BPKSkeleton.bodytext()
                    BPKSkeleton.bodytext(size: .small) // Should be the same as .default
                    BPKSkeleton.bodytext(size: .custom(size: CGSize(width: 111, height: 111)))
                    BPKSkeleton.bodytext(size: .custom(size: CGSize(width: 111, height: 222)))
                }
            }
            .padding()
        }
    }
        
    func test_allSkeletonsWithoutShimmer() {
        // Then
        assertSnapshot(testView())
    }
    
    func test_allSkeletonsWithShimmer() {
        // Then
        assertSnapshot(testView().shimmering())
    }
}
