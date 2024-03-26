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
    let categories: [BPKImageGalleryCategory<ImageView>]
    let closeAccessibilityLabel: String
    let onCloseTapped: () -> Void
    let initialCategory: Int
    
    // @Binding var currentIndex: Int // Category Selected binding?
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ContentView(
                    categories: categories,
                    closeAccessibilityLabel: closeAccessibilityLabel,
                    onCloseTapped: onCloseTapped,
                    selectedCategory: initialCategory
                )
            }
    }
    
    struct ContentView: View {
        let categories: [BPKImageGalleryCategory<ImageView>]
        let closeAccessibilityLabel: String
        let onCloseTapped: () -> Void
        @State var selectedCategory: Int
        
        private let itemHeightInGrid: CGFloat = 192
        
        var body: some View {
            VStack(spacing: .md) {
                ImageGalleryHeader(
                    closeAccessibilityLabel: closeAccessibilityLabel,
                    onCloseTapped: onCloseTapped
                )
                
                ImageGalleryGridCategoriesCarousel(
                    categories: categories,
                    selectedCategory: $selectedCategory
                )
                .fixedSize(horizontal: false, vertical: true)
                
                TwoRowGrid(
                    items: categories[(selectedCategory < categories.count ? selectedCategory : 0)].images
                ) { image in
                    image.content()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .frame(height: itemHeightInGrid)
                }
            }
            .padding([.leading, .trailing], .base)
        }
    }
}

public extension View {
    func bpkImageGalleryGrid<Content>(
        isPresented: Binding<Bool>,
        initialCategory: Int = 0,
        categories: [BPKImageGalleryCategory<Content>],
        closeAccessibilityLabel: String,
        // currentIndex: Binding<Int>, // Category Selected binding?
        onCloseTapped: @escaping () -> Void
    ) -> some View {
        modifier(
            ImageGalleryGrid(
                categories: categories,
                closeAccessibilityLabel: closeAccessibilityLabel,
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
            onCloseTapped: { },
            selectedCategory: 0
        )
    }
    
    private static var testCategories: [BPKImageGalleryCategory<Color>] {
        [
            BPKImageGalleryCategory(
                title: "Green but with very long title indeed (40)",
                images: testImages(40, colour: .green),
                categoryImage: testImages(1, colour: .green)[0]
            ),
            BPKImageGalleryCategory(
                title: "Blue photos (10)",
                images: testImages(5, colour: .blue),
                categoryImage: testImages(1, colour: .blue)[0]
            ),
            BPKImageGalleryCategory(
                title: "Red photos (10)",
                images: testImages(6, colour: .red),
                categoryImage: testImages(1, colour: .red)[0]
            )
        ]
    }
    
    private static func testImages(_ amount: Int, colour: Color) -> [BPKImageGalleryGridImage<Color>] {
        return (0..<amount).map { _ in
            BPKImageGalleryGridImage() {
                colour
            }
        }
    }
}
