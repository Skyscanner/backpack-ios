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
    @State var chipsPresented = false
    @State var imagesPresented = false
    @State var selectedCategory = 0
    
    var body: some View {
        VStack {
            BPKButton("Show Chip Categories", action: {
                chipsPresented.toggle()
            })
            BPKButton("Show Image Categories", action: {
                imagesPresented.toggle()
            })
        }
        .onChange(of: selectedCategory) { _ in
            print("category index: \(selectedCategory)")
        }
        .bpkImageGalleryGrid(
            isPresented: $chipsPresented,
            selectedCategory: $selectedCategory,
            categories: chipCategories(imageForIndex: image(forIndex:)),
            closeAccessibilityLabel: "Close Gallery",
            onImageTapped: { category, image in
                onImageTapped(category: category, image: image)
            },
            onCloseTapped: { chipsPresented.toggle() }
        )
        .bpkImageGalleryGrid(
            isPresented: $imagesPresented,
            selectedCategory: $selectedCategory,
            categories: imageCategories(
                imageForIndex: image(forIndex:),
                categoryImageForIndex: image(forIndex:)
            ),
            closeAccessibilityLabel: "Close Gallery",
            onImageTapped: { category, image in
                onImageTapped(category: category, image: image)
            },
            onCloseTapped: { imagesPresented.toggle() }
        )
    }
    
    private func onImageTapped(category: Int, image: Int) {
        print("onItemTapped category: \(categoryName(category)), item: \(image)")
    }
    
    private func categoryName(_ categoryIndex: Int) -> String {
        [
            "Traveller photos (31)",
            "All Photos (59)",
            "Official Photos (43)",
            "Bedroom (10)"
        ][categoryIndex]
    }
    
    private func imageCategories<Category: View, Image: View>(
        imageForIndex: @escaping (Int) -> Image,
        categoryImageForIndex: @escaping (Int) -> Category
    ) -> [BPKImageGalleryImageCategory<Category, Image>] {
        (0...3)
            .map { categoryIndex in
                .init(
                    title: categoryName(categoryIndex),
                    images: (0...(10 + categoryIndex)).map { index in
                        BPKImageGalleryImage(
                            title: "image \(index)",
                            description: "Image at Index: \(index)",
                            credit: "@photographer",
                            content: { imageForIndex(index) }
                        )
                    },
                    categoryImage: {
                        categoryImageForIndex(categoryIndex)
                    }
                )
            }
    }
    
    private func chipCategories<Image: View>(
        imageForIndex: @escaping (Int) -> Image
    ) -> [BPKImageGalleryChipCategory<Image>] {
        (0...3).map { categoryIndex in
            .init(
                title: categoryName(categoryIndex),
                images: (0...(10 + categoryIndex)).map { index in
                    BPKImageGalleryImage(
                        title: "image \(index)",
                        description: "Image at Index: \(index)",
                        credit: "@photographer",
                        content: { imageForIndex(index) }
                    )
                }
            )
        }
    }
    
    private func image(forIndex number: Int) -> some View {
        Image("carousel_placeholder_\((number % 4) + 1)")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

struct ImageGalleryGridExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryGridExampleView()
    }
}
