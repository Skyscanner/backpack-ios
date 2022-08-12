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
    var body: some View {
        VStack(alignment: .leading) {
            BPKText("Image Skeleton", style: .heading4)
            makeImageSkeletonRow()
            
            BPKText("Headline Skeleton", style: .heading4)
            makeHeadlineSkeletonRow()
            
            BPKText("Circle Skeleton", style: .heading4)
            makeCircleSkeletonRow()
            
            BPKText("Body text Skeleton", style: .heading4)
            makeBodytextSkeletonRow()
        }
        .padding()
    }
    
    private func makeImageSkeletonRow() -> some View {
        HStack(alignment: .bottom) {
            Spacer()
            VStack {
                BPKSkeleton(type: .image, style: .default)
                BPKText("Default")
                    .foregroundColor(.textPrimaryColor)
            }
            Spacer()
            VStack {
                BPKSkeleton(type: .image, style: .rounded)
                BPKText("Rounded")
                    .foregroundColor(.textPrimaryColor)
            }
            Spacer()
        }
        .padding()
    }
    
    private func makeHeadlineSkeletonRow() -> some View {
        HStack(alignment: .bottom) {
            Spacer()
            VStack {
                BPKSkeleton(type: .headline, size: .small)
                BPKText("Small")
                    .foregroundColor(.textPrimaryColor)
            }
            Spacer()
            VStack {
                BPKSkeleton(type: .headline, size: .default)
                BPKText("Default")
                    .foregroundColor(.textPrimaryColor)
            }
            Spacer()
            VStack {
                BPKSkeleton(type: .headline, size: .large)
                BPKText("Large")
                    .foregroundColor(.textPrimaryColor)
            }
            Spacer()
        }
        .padding()
    }
    
    private func makeCircleSkeletonRow() -> some View {
        HStack(alignment: .bottom) {
            Spacer()
            VStack {
                BPKSkeleton(type: .circle, size: .small)
                BPKText("Small")
                    .foregroundColor(.textPrimaryColor)
            }
            Spacer()
            VStack {
                BPKSkeleton(type: .circle, size: .default)
                BPKText("Default")
                    .foregroundColor(.textPrimaryColor)
            }
            Spacer()
        }
        .padding()
    }
    
    private func makeBodytextSkeletonRow() -> some View {
//        HStack(alignment: .bottom) {
//            Spacer()
        BPKSkeleton(type: .bodytext)
//            Spacer()
//        }
    }
}

struct SkeletonExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonExampleView()
    }
}
