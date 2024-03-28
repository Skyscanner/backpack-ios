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

struct ImageGalleryGridContentView<ImageView: View>: View {
    
    let categories: BPKImageGalleryImageGridStyle<ImageView>
    let closeAccessibilityLabel: String
    let itemTapped: (BPKImageGalleryImage<ImageView>) -> Void
    let onCloseTapped: () -> Void
    
    @Binding var selectedCategoryIndex: Int
    @State var isSlideshowPresented: Bool = false
    @State var imageIndexInCategory: Int = 0
    
    var body: some View {
        VStack(spacing: .md) {
            ImageGalleryHeader(
                closeAccessibilityLabel: "closeAccessibilityLabel",
                onCloseTapped: onCloseTapped
            )
            
            ImageGalleryGridCategoriesCarousel(
                categories: categories,
                selectedCategory: $selectedCategoryIndex
            )
            .fixedSize(horizontal: false, vertical: true)
            
            TwoRowGrid(
                items: selectedCategoryImages
            ) { item, index in
                
                item.content(.grid)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(height: ImageGalleryGridConstants.itemHeightInGrid)
                    .onTapGesture {
                        itemTapped(item)
                        imageIndexInCategory = index
                        isSlideshowPresented.toggle()
                    }
                    .accessibilityAddTraits(.isButton)
                 
            }
        }
        .padding([.leading, .trailing], .base)
        .background(Color(.canvasContrastColor))
        .bpkImageGallerySlideshow(
            isPresented: $isSlideshowPresented,
            images: selectedCategoryImages,
            closeAccessibilityLabel: closeAccessibilityLabel,
            currentIndex: $imageIndexInCategory,
            onCloseTapped: { isSlideshowPresented = false }
        )
    }
    
    private var selectedCategoryImages: [BPKImageGalleryImage<ImageView>] {
        switch categories {
        case .chip(let chips):
            chips[selectedCategoryIndex].images
        case .image(let images):
            images[selectedCategoryIndex].images
        }
    }
}
