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

struct ImageGalleryChipCategoryView: View {
    let categories: [String]
    @Binding var selectedCategoryIndex: Int
    
    var body: some View {
        BPKSingleSelectChipGroup(
            chips: categories.map { .init(text: $0) },
            selectedIndex: Binding(
                get: { selectedCategoryIndex },
                set: { newValue in selectedCategoryIndex = newValue ?? 0 }
            )
        ) { index in
            selectedCategoryIndex = index
        }
        .insetPadding(.horizontal, .lg)
        .padding(.bottom, .md)
    }
}

struct ImageGalleryImageCategoryView<ImageView: View>: View {
    struct Category {
        let title: String
        let categoryImage: () -> ImageView
    }
    
    let categoryImageSize: CGFloat = 90
    let categories: [Category]
    @Binding var selectedCategory: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: .md) {
                ForEach(0..<categories.count, id: \.self) { ndx in
                    categoryThumb(
                        for: categories[ndx],
                        isSelected: selectedCategory == ndx
                    )
                    .onTapGesture {
                        selectedCategory = ndx
                    }
                    .accessibilityAddTraits(.isButton)
                }
            }
            .padding(.horizontal, .lg)
        }
        .padding(.bottom, .base)
    }
    
    @ViewBuilder
    private func categoryThumb(
        for category: Category,
        isSelected: Bool
    ) -> some View {
        VStack(spacing: .md) {
            category.categoryImage()
                .frame(
                    width: categoryImageSize,
                    height: categoryImageSize
                )
                .clipShape(RoundedRectangle(cornerRadius: .md))
            
            BPKText(
                category.title,
                style: isSelected ? .label3 : .caption
            )
            .lineLimit(nil)
            
        }
        .frame(width: categoryImageSize)
    }
}

struct ImageGalleryGridCategoriesCarousel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ImageGalleryImageCategoryView(
                categories: testCategories,
                selectedCategory: .constant(0)
            )
            ImageGalleryChipCategoryView(
                categories: [
                    "Green photos with long title (40)",
                    "Blue photos (10)",
                    "red photos (10)"
                ],
                selectedCategoryIndex: .constant(0)
            )
        }
    }

    private static var testCategories: [ImageGalleryImageCategoryView<Color>.Category] {
        [
            .init(
                title: "Green photos with long title (40)",
                categoryImage: { Color.green }
            ),
            .init(
                title: "Blue photos (10)",
                categoryImage: { Color.blue }
            ),
            .init(
                title: "red photos (10)",
                categoryImage: { Color.red }
            )
        ]
    }
}
 
