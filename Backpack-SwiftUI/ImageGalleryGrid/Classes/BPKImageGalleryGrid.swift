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

struct ImageGalleryGrid<Categories: View, GridImageView: View, SlideshowImageView: View>: ViewModifier {
    let categories: () -> Categories
    let gridImages: [BPKGridGalleryImage<GridImageView>]
    let slideshowImages: [BPKSlideshowGalleryImage<SlideshowImageView>]
    let closeAccessibilityLabel: String
    let onImageTapped: (_ category: Int, _ image: Int) -> Void
    let onCloseTapped: () -> Void
    @Binding var selectedCategoryIndex: Int
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ImageGalleryGridContentView(
                    categories: categories,
                    gridImages: gridImages,
                    slideshowImages: slideshowImages,
                    closeAccessibilityLabel: closeAccessibilityLabel,
                    imageTapped: { selectedCategory, image in
                        onImageTapped(selectedCategory, image)
                    },
                    onCloseTapped: onCloseTapped,
                    selectedCategoryIndex: selectedCategoryIndex
                )
            }
    }
}

public extension View {
    // swiftlint:disable function_parameter_count
    @ViewBuilder
    func bpkImageGalleryGrid<CategoryView, GridImage, SlideshowImage>(
        isPresented: Binding<Bool>,
        selectedCategory: Binding<Int>,
        categories: [BPKImageGalleryImageCategory<CategoryView, GridImage, SlideshowImage>],
        closeAccessibilityLabel: String,
        onImageTapped: @escaping (_ category: Int, _ image: Int) -> Void,
        onCloseTapped: @escaping () -> Void
    ) -> some View {
        modifier(
            ImageGalleryGrid(
                categories: {
                    ImageGalleryImageCategoryView(
                        categories: categories.map {
                            .init(
                                title: $0.title,
                                categoryImage: $0.categoryImage
                            )
                        },
                        selectedCategory: selectedCategory
                    )
                },
                gridImages: categories[selectedCategory.wrappedValue].gridImages,
                slideshowImages: categories[selectedCategory.wrappedValue].slideshowImages,
                closeAccessibilityLabel: closeAccessibilityLabel,
                onImageTapped: onImageTapped,
                onCloseTapped: onCloseTapped,
                selectedCategoryIndex: selectedCategory,
                isPresented: isPresented
            )
        )
    }
    
    // swiftlint:disable function_parameter_count
    @ViewBuilder
    func bpkImageGalleryGrid<GridImage, SlideshowImage>(
        isPresented: Binding<Bool>,
        selectedCategory: Binding<Int>,
        categories: [BPKImageGalleryChipCategory<GridImage, SlideshowImage>],
        closeAccessibilityLabel: String,
        onImageTapped: @escaping (_ category: Int, _ image: Int) -> Void,
        onCloseTapped: @escaping () -> Void
    ) -> some View {
        modifier(
            ImageGalleryGrid(
                categories: {
                    ImageGalleryChipCategoryView(
                        categories: categories.map(\.title),
                        selectedCategoryIndex: selectedCategory
                    )
                },
                gridImages: categories[selectedCategory.wrappedValue].gridImages,
                slideshowImages: categories[selectedCategory.wrappedValue].slideshowImages,
                closeAccessibilityLabel: closeAccessibilityLabel,
                onImageTapped: onImageTapped,
                onCloseTapped: onCloseTapped,
                selectedCategoryIndex: selectedCategory,
                isPresented: isPresented
            )
        )
    }
}

struct BPKImageGalleryImageGrid_Previews: PreviewProvider {
    
    static var previews: some View {
        Color.clear
            .bpkImageGalleryGrid(
                isPresented: .constant(true),
                selectedCategory: .constant(0),
                categories: testImageCategories,
                closeAccessibilityLabel: "Close",
                onImageTapped: { _, _ in },
                onCloseTapped: {}
            )
            .previewDisplayName("Images")
        
        Color.clear
            .bpkImageGalleryGrid(
                isPresented: .constant(true),
                selectedCategory: .constant(0),
                categories: testChipCategories,
                closeAccessibilityLabel: "Close",
                onImageTapped: { _, _ in },
                onCloseTapped: {}
            )
            .previewDisplayName("Chips")
    }
    
    private static var testChipCategories: [BPKImageGalleryChipCategory<Color, Color>] {
        [
            .init(
                title: "Green but with very long title indeed (40)",
                gridImages: testGridImages(40, color: .green),
                slideshowImages: testSlideshowImages(40, color: .green)
            ),
            .init(
                title: "Blue photos (10)",
                gridImages: testGridImages(5, color: .blue),
                slideshowImages: testSlideshowImages(5, color: .blue)
            ),
            .init(
                title: "Red photos (10)",
                gridImages: testGridImages(6, color: .red),
                slideshowImages: testSlideshowImages(6, color: .red)
            )
        ]
    }
    
    private static var testImageCategories: [BPKImageGalleryImageCategory<Color, Color, Color>] {
        [
            .init(
                title: "Green but with very long title indeed (40)",
                gridImages: testGridImages(40, color: .green),
                slideshowImages: testSlideshowImages(40, color: .green),
                categoryImage: { Color.green }
            ),
            .init(
                title: "Blue photos (10)",
                gridImages: testGridImages(5, color: .blue),
                slideshowImages: testSlideshowImages(5, color: .blue),
                categoryImage: { Color.blue }
            ),
            .init(
                title: "Red photos (10)",
                gridImages: testGridImages(6, color: .red),
                slideshowImages: testSlideshowImages(6, color: .red),
                categoryImage: { Color.red }
            )
        ]
    }
    
    private static func testSlideshowImages(_ amount: Int, color: Color) -> [BPKSlideshowGalleryImage<Color>] {
        return (0..<amount).map { _ in
            BPKSlideshowGalleryImage(title: "image \(amount)") {
                color
            }
        }
    }
    
    private static func testGridImages(_ amount: Int, color: Color) -> [BPKGridGalleryImage<Color>] {
        return (0..<amount).map { _ in
            BPKGridGalleryImage { color }
        }
    }
}
