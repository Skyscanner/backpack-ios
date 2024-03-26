//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2024 Skyscanner Ltd. All rights reserved.
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

struct ImageGalleryGridExampleView: View {
    @State var isPresented = true
    var body: some View {
        BPKButton("Show", action: {
            isPresented.toggle()
        })
        .bpkImageGalleryGrid(
            isPresented: $isPresented,
            categories: (0...7).map { categoryIndex in
                BPKImageGalleryCategory(
                    title: categoryName(categoryIndex),
                    images: (0...categoryIndex).map { index in
                        BPKImageGalleryImage(
                            title: "Pumphouse Point.",
                            description: "Walk deep into the fjord-like surrounds of Lake St Clair.",
                            credit: "@PhotographerName",
                            content: { image(((categoryIndex + index) % 4) + 1) }
                        )
                    },
                    categoryImage: BPKImageGalleryImage(
                        title: "Pumphouse Point.",
                        description: "Walk deep into the fjord-like surrounds of Lake St Clair.",
                        credit: "@PhotographerName",
                        content: { image(categoryIndex + 1) }
                    )
                )
            },
            closeAccessibilityLabel: "Close",
            onCloseTapped: { isPresented.toggle() }
        )
    }
    
    private func categoryName(_ categoryIndex: Int) -> String {
        switch categoryIndex % 2 {
        case 0:
            return "Long Category Name For Photos (\(categoryIndex))"
        default:
            return "Short (\(categoryIndex))"
        }
    }
    
    private func image(_ number: Int) -> some View {
        print("NUMBER: \(number)")
        return ZStack(content: {
            Image("carousel_placeholder_\(number)")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            BPKText("\(number)", style: .heading1)
                .foregroundColor(.textPrimaryInverseColor)
        })
    }
}

#Preview {
    ImageGalleryGridExampleView()
}
