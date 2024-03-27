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
    let categories: BPKImageGalleryCategoriesTypeContainer<ImageView>
    @Binding var selectedCategory: Int?
    private let categoryImageSideLength: CGFloat = 90
    
    var body: some View {
        
        switch categories {
            
        case .chip(let chipCategories):
            BPKSingleSelectChipGroup(
                chips: chipCategories.map { .init(text: $0.title) },
                selectedIndex: $selectedCategory
            ) { index in
                selectedCategory = index
            }
            
        case .image(let imageCatgories):
            ScrollView(.horizontal) {
                HStack(alignment: .top) {
                    ForEach(0..<imageCatgories.count, id: \.self) { ndx in
                        categoryThumb(
                            for: imageCatgories[ndx],
                            isSelected: selectedCategory == ndx
                        )
                        .onTapGesture {
                            selectedCategory = ndx
                        }
                        .accessibilityAddTraits(.isButton)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func categoryThumb(
        for category: BPKImageGalleryCategoryImage<ImageView>,
        isSelected: Bool
    ) -> some View {
        VStack {
            category.categoryImage.content()
                .frame(
                    width: categoryImageSideLength,
                    height: categoryImageSideLength
                )
                .clipShape(RoundedRectangle(cornerRadius: .md))
            
            BPKText(
                category.title,
                style: isSelected ? .label3 : .caption
            )
            .lineLimit(nil)
            
        }
        .frame(width: categoryImageSideLength)
    }
}

struct ImageGalleryGridCategoriesCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryGridCategoriesCarousel(
            categories: .image(testCategories),
            selectedCategory: .constant(0)
        )
        .fixedSize(horizontal: false, vertical: true)
        .previewDisplayName("Images")
        
        ImageGalleryGridCategoriesCarousel(
            categories: .chip(testChipCategories),
            selectedCategory: .constant(0)
        )
        .fixedSize(horizontal: false, vertical: true)
        .previewDisplayName("Chips")
    }
    
    private static var testCategories: [BPKImageGalleryCategoryImage<Color>] {
        [
            BPKImageGalleryCategoryImage(
                title: "Green photos with long title (40)",
                images: [],
                categoryImage: BPKImageGalleryCarouselImage() { Color.green }
            ),
            BPKImageGalleryCategoryImage(
                title: "Blue photos (10)",
                images: [],
                categoryImage: BPKImageGalleryCarouselImage() { Color.blue }
            ),
            BPKImageGalleryCategoryImage(
                title: "red photos (10)",
                images: [],
                categoryImage: BPKImageGalleryCarouselImage() { Color.red }
            )
        ]
    }
    
    private static var testChipCategories: [BPKImageGalleryCategoryChip<Color>] {
        [
            BPKImageGalleryCategoryChip(
                title: "Green photos with long title (40)",
                images: []
            ),
            BPKImageGalleryCategoryChip(
                title: "Blue photos (10)",
                images: []
            ),
            BPKImageGalleryCategoryChip(
                title: "red photos (10)",
                images: []
            )
        ]
    }
}
 
