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

struct ImageGalleryGrid<ImageView: View>: ViewModifier {
    let categories: BPKImageGalleryCategoriesTypeContainer<ImageView>
    let closeAccessibilityLabel: String
    let onCategoryChanged: (BPKImageGalleryCategoryType<ImageView>) -> Void
    let onItemTapped: (BPKImageGalleryCategoryType<ImageView>, BPKImageGalleryImage<ImageView>) -> Void
    let onCloseTapped: () -> Void
    let initialCategory: Int
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ContentView(
                    categories: categories,
                    closeAccessibilityLabel: closeAccessibilityLabel,
                    onCategoryChanged: onCategoryChanged,
                    onItemTapped: onItemTapped,
                    onCloseTapped: onCloseTapped,
                    selectedCategoryIndex: initialCategory
                )
            }
    }
    
    struct ContentView: View {
        let categories: BPKImageGalleryCategoriesTypeContainer<ImageView>
        let closeAccessibilityLabel: String
        let onCategoryChanged: (BPKImageGalleryCategoryType<ImageView>) -> Void
        let onItemTapped: (BPKImageGalleryCategoryType<ImageView>, BPKImageGalleryImage<ImageView>) -> Void
        let onCloseTapped: () -> Void
        @State var selectedCategoryIndex: Int?
        @State var presentSlideshow: Bool = false
        @State var imageIndexInCategory: Int = 0
        
        private let itemHeightInGrid: CGFloat = 192
        
        var body: some View {
            
            VStack(spacing: .md) {
                ImageGalleryHeader(
                    closeAccessibilityLabel: closeAccessibilityLabel,
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
                        .frame(height: itemHeightInGrid)
                        .onTapGesture {
                            onItemTapped(selectedCategory, item)
                            imageIndexInCategory = index
                            presentSlideshow.toggle()
                        }
                        .accessibilityAddTraits(.isButton)
                }
            }
            .padding([.leading, .trailing], .base)
            .onChange(of: selectedCategoryIndex) { _ in
                onCategoryChanged(selectedCategory)
            }
            .bpkImageGallerySlideshow(
                isPresented: $presentSlideshow,
                images: selectedCategory.images,
                closeAccessibilityLabel: closeAccessibilityLabel,
                currentIndex: $imageIndexInCategory,
                onCloseTapped: { presentSlideshow = false }
            )
        }
        
        private var selectedCategoryImages: [BPKImageGalleryImage<ImageView>] {
            switch categories {
            case .chip(let chips):
                chips[selectedCategoryIndex ?? 0].images
            case .image(let images):
                images[selectedCategoryIndex ?? 0].images
            }
        }
        
        private var selectedCategory: BPKImageGalleryCategoryType<ImageView> {
            switch categories {
            case .chip(let chips):
                .chip(chips[selectedCategoryIndex ?? 0])
            case .image(let images):
                .image(images[selectedCategoryIndex ?? 0])
            }
        }
    }
}

public extension View {
    
    // swiftlint:disable function_parameter_count
    func bpkImageGalleryGrid<Content>(
        isPresented: Binding<Bool>,
        initialCategory: Int = 0,
        categories: BPKImageGalleryCategoriesTypeContainer<Content>,
        closeAccessibilityLabel: String,
        onCategoryChanged: @escaping (BPKImageGalleryCategoryType<Content>) -> Void,
        onItemTapped: @escaping (BPKImageGalleryCategoryType<Content>, BPKImageGalleryImage<Content>) -> Void,
        onCloseTapped: @escaping () -> Void
    ) -> some View {
        modifier(
            ImageGalleryGrid(
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

struct BPKImageGalleryGrid_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryGrid<Color>.ContentView(
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
