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

import SwiftUI

struct ImageGalleryGridCategoriesCarousel<ImageView: View>: View {
    let categories: [BPKImageGalleryCategory<ImageView>]
    @Binding var selectedCategory: Int
    private let categoryImageSideLength: CGFloat = 90
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(0..<categories.count, id: \.self) { ndx in
                    categoryThumb(for: categories[ndx])
                        .onTapGesture {
                            selectedCategory = ndx
                        }
                        .accessibilityAddTraits(.isButton)
                }
            }
        }
    }
    
    @ViewBuilder
    private func categoryThumb(for category: BPKImageGalleryCategory<ImageView>) -> some View {
        VStack {
            category.categoryImage.content()
                .frame(
                    width: categoryImageSideLength,
                    height: categoryImageSideLength
                )
                .clipShape(RoundedRectangle(cornerRadius: .md))
            
            BPKText(category.title)
                .lineLimit(nil)
        }
        .frame(width: categoryImageSideLength)
    }
}
