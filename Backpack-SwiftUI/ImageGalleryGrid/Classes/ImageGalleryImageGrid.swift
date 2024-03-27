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

struct ImageGalleryGridConstants {
    static let itemHeightInGrid: CGFloat = 192
}

struct ImageGalleryImageGrid<ImageView: View>: ViewModifier {
    let categories: [BPKImageGalleryCategoryImage<ImageView>]
    let closeAccessibilityLabel: String
    let onCategoryChanged: (BPKImageGalleryCategoryImage<ImageView>) -> Void
    let onItemTapped: (BPKImageGalleryCategoryImage<ImageView>, BPKImageGalleryImage<ImageView>) -> Void
    let onCloseTapped: () -> Void
    let initialCategory: Int
    @Binding var isPresented: Bool
    @State var selectedCategoryIndex: Int? = 0
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ImageGalleryGridContentView(
                    categories: .image(categories),
                    closeAccessibilityLabel: closeAccessibilityLabel,
                    onCategoryChanged: {
                        onCategoryChanged(selectedCategory)
                    },
                    itemTapped: { item, _ in
                        onItemTapped(selectedCategory, item)
                    },
                    onCloseTapped: onCloseTapped,
                    selectedCategoryIndex: $selectedCategoryIndex
                )
            }
    }
    
    private var selectedCategory: BPKImageGalleryCategoryImage<ImageView> {
        categories[selectedCategoryIndex ?? 0]
    }
}

public extension View {
    
    // swiftlint:disable function_parameter_count
    func bpkImageGalleryImageGrid<Content>(
        isPresented: Binding<Bool>,
        initialCategory: Int = 0,
        categories: [BPKImageGalleryCategoryImage<Content>],
        closeAccessibilityLabel: String,
        onCategoryChanged: @escaping (BPKImageGalleryCategoryImage<Content>) -> Void,
        onItemTapped: @escaping (BPKImageGalleryCategoryImage<Content>, BPKImageGalleryImage<Content>) -> Void,
        onCloseTapped: @escaping () -> Void
    ) -> some View {
        
        modifier(
            ImageGalleryImageGrid(
                categories: categories,
                closeAccessibilityLabel: closeAccessibilityLabel,
                onCategoryChanged: onCategoryChanged,
                onItemTapped: onItemTapped,
                onCloseTapped: onCloseTapped,
                initialCategory: initialCategory,
                isPresented: isPresented
                )
            )
    }
}

/*
 struct BPKImageGalleryGrid_Previews: PreviewProvider {
 static var previews: some View {
 ImageGalleryChipGrid<Color>.ContentView(
 categories: testCategories,
 closeAccessibilityLabel: "close",
 onCategoryChanged: { category in
 print("onCategoryChanged: \(category.title)")
 },
 onItemTapped: {category, item in
 print("onItemTapped category: \(category.title), item: \(item)")
 },
 onCloseTapped: { },
 selectedCategoryIndex: 0
 )
 }
 
 private static var testCategories: BPKImageGalleryCategoriesTypeContainer<Color> {
 return .image([
 BPKImageGalleryCategoryImage(
 title: "Green but with very long title indeed (40)",
 images: testImages(40, colour: .green),
 categoryImage: BPKImageGalleryCarouselImage() { Color.green }
 ),
 BPKImageGalleryCategoryImage(
 title: "Blue photos (10)",
 images: testImages(5, colour: .blue),
 categoryImage: BPKImageGalleryCarouselImage() { Color.blue }
 ),
 BPKImageGalleryCategoryImage(
 title: "Red photos (10)",
 images: testImages(6, colour: .red),
 categoryImage: BPKImageGalleryCarouselImage() { Color.red }
 )
 ])
 }
 
 private static func testImages(_ amount: Int, colour: Color) -> [BPKImageGalleryImage<Color>] {
 return (0..<amount).map { _ in
 BPKImageGalleryImage(title: "image \(amount)") { _ in
 colour
 }
 }
 }
 }
 */
