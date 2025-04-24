//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

import SwiftUI
import Backpack_SwiftUI

struct SkeletonExampleView: View {
    let columns = Array(repeating: GridItem(.flexible(minimum: 32), spacing: 12), count: 7)

    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<28, id: \.self) { _ in
                        BPKSkeleton.headline(size: .custom(size: CGSize(width: 32, height: 12)))
                            .shimmering(size: .small)
                    }
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 16) {
                    Spacer()
                    BPKText("Image", style: .heading5)
                    makeImageSkeletonRow()
                    
                    BPKText("Circle", style: .heading5)
                    makeCircleSkeletonRow()
                    
                    BPKText("Headline", style: .heading5)
                    makeHeadlineSkeletonRow()
                    
                    BPKText("Bodytext", style: .heading5)
                    makeBodytextSkeletonRow()
                    Spacer()
                }
                .shimmering()
                Spacer()
            }
            .padding()
        }
    }

    private func makeImageSkeletonRow() -> some View {
        HStack(alignment: .bottom) {
            VStack {
                BPKSkeleton.image()
                BPKText("Default", style: .caption)
            }
            VStack {
                BPKSkeleton.image(style: .rounded)
                BPKText("Rounded", style: .caption)
            }
        }
    }

    private func makeHeadlineSkeletonRow() -> some View {
        HStack(alignment: .bottom) {
            VStack {
                BPKSkeleton.headline(size: .small)
                BPKText("Small", style: .caption)
            }
            VStack {
                BPKSkeleton.headline()
                BPKText("Default", style: .caption)
            }
            VStack {
                BPKSkeleton.headline(size: .large)
                BPKText("Large", style: .caption)
            }
        }
    }

    private func makeCircleSkeletonRow() -> some View {
        HStack(alignment: .bottom) {
            VStack {
                BPKSkeleton.circle(size: .small)
                BPKText("Small", style: .caption)
            }
            VStack {
                BPKSkeleton.circle()
                BPKText("Default", style: .caption)
            }
        }
    }

    private func makeBodytextSkeletonRow() -> some View {
        VStack {
            VStack {
                BPKSkeleton.bodytext()
                BPKText("Default", style: .caption)
            }
        }
    }
}

struct SkeletonExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonExampleView()
    }
}
