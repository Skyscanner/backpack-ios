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

struct ImageGalleryGrid<Categories: View, ImageView: View>: ViewModifier {
    let categories: () -> Categories
    let images: [BPKImageGalleryImage<ImageView>]
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
                    images: images,
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

struct ImageGalleryChipGrid<ImageView: View>: ViewModifier {
    let categories: [BPKImageGalleryImageGridStyle<ImageView>.ChipCategory]
    let closeAccessibilityLabel: String
    let onImageTapped: (_ category: Int, _ image: Int) -> Void
    let onCloseTapped: () -> Void
    @Binding var isPresented: Bool
    @Binding var selectedCategoryIndex: Int
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ImageGalleryGridContentView(
                    categories: {
                        ImageGalleryChipCategoryView(
                            categories: categories.map(\.title),
                            selectedCategoryIndex: $selectedCategoryIndex
                        )
                    },
                    images: categories[selectedCategoryIndex].images,
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
    func bpkImageGalleryGrid<Content>(
        isPresented: Binding<Bool>,
        selectedCategory: Binding<Int>,
        style: BPKImageGalleryImageGridStyle<Content>,
        closeAccessibilityLabel: String,
        onImageTapped: @escaping (_ category: Int, _ image: Int) -> Void,
        onCloseTapped: @escaping () -> Void
    ) -> some View {
        switch style {
        case .chip(let categories):
            modifier(
                ImageGalleryGrid(
                    categories: {
                        ImageGalleryChipCategoryView(
                            categories: categories.map(\.title),
                            selectedCategoryIndex: selectedCategory
                        )
                    },
                    images: categories[selectedCategory.wrappedValue].images,
                    closeAccessibilityLabel: closeAccessibilityLabel,
                    onImageTapped: onImageTapped,
                    onCloseTapped: onCloseTapped,
                    selectedCategoryIndex: selectedCategory,
                    isPresented: isPresented
                )
            )
        case .image(let categories):
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
                    images: categories[selectedCategory.wrappedValue].images,
                    closeAccessibilityLabel: closeAccessibilityLabel,
                    onImageTapped: onImageTapped,
                    onCloseTapped: onCloseTapped,
                    selectedCategoryIndex: selectedCategory,
                    isPresented: isPresented
                )
            )
        }
    }
}

struct BPKImageGalleryImageGrid_Previews: PreviewProvider {
    
    static var previews: some View {
        Color.clear
            .bpkImageGalleryGrid(
                isPresented: .constant(true),
                selectedCategory: .constant(0),
                style: .image(testImageCategories),
                closeAccessibilityLabel: "Close",
                onImageTapped: { _, _ in },
                onCloseTapped: {}
            )
            .previewDisplayName("Images")
        
        Color.clear
            .bpkImageGalleryGrid(
                isPresented: .constant(true),
                selectedCategory: .constant(0),
                style: .chip(testChipCategories),
                closeAccessibilityLabel: "Close",
                onImageTapped: { _, _ in },
                onCloseTapped: {}
            )
            .previewDisplayName("Chips")
    }
    
    private static var testChipCategories: [BPKImageGalleryImageGridStyle<Color>.ChipCategory] {
        [
            BPKImageGalleryImageGridStyle.ChipCategory(
                title: "Green but with very long title indeed (40)",
                images: testImages(40, color: .green)
            ),
            BPKImageGalleryImageGridStyle.ChipCategory(
                title: "Blue photos (10)",
                images: testImages(5, color: .blue)
            ),
            BPKImageGalleryImageGridStyle.ChipCategory(
                title: "Red photos (10)",
                images: testImages(6, color: .red)
            )
        ]
    }
    
    private static var testImageCategories: [BPKImageGalleryImageGridStyle<Color>.ImageCategory] {
        [
            BPKImageGalleryImageGridStyle.ImageCategory(
                title: "Green but with very long title indeed (40)",
                images: testImages(40, color: .green),
                categoryImage: { Color.green }
            ),
            BPKImageGalleryImageGridStyle.ImageCategory(
                title: "Blue photos (10)",
                images: testImages(5, color: .blue),
                categoryImage: { Color.blue }
            ),
            BPKImageGalleryImageGridStyle.ImageCategory(
                title: "Red photos (10)",
                images: testImages(6, color: .red),
                categoryImage: { Color.red }
            )
        ]
    }
    
    private static func testImages(_ amount: Int, color: Color) -> [BPKImageGalleryImage<Color>] {
        return (0..<amount).map { _ in
            BPKImageGalleryImage(title: "image \(amount)") {
                color
            }
        }
    }
}
