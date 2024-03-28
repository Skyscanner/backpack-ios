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
    static let categoryImageSize: CGFloat = 90
}

struct ImageGalleryImageGrid<ImageView: View>: ViewModifier {
    let categories: [BPKImageGalleryImageGridStyle<ImageView>.ImageCategory]
    let closeAccessibilityLabel: String
    let onItemTapped: (BPKImageGalleryImageGridStyle<ImageView>.ImageCategory, BPKImageGalleryImage<ImageView>) -> Void
    let onCloseTapped: () -> Void
    @Binding var category: Int
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ImageGalleryGridContentView(
                    categories: .image(categories),
                    closeAccessibilityLabel: closeAccessibilityLabel,
                    itemTapped: { item in
                        onItemTapped(selectedCategory, item)
                    },
                    onCloseTapped: onCloseTapped,
                    selectedCategoryIndex: $category
                )
            }
    }
    
    private var selectedCategory: BPKImageGalleryImageGridStyle<ImageView>.ImageCategory {
        categories[category]
    }
}

public extension View {
    
    // swiftlint:disable function_parameter_count
    func bpkImageGalleryImageGrid<Content>(
        isPresented: Binding<Bool>,
        category: Binding<Int>,
        categories: [BPKImageGalleryImageGridStyle<Content>.ImageCategory],
        closeAccessibilityLabel: String,
        onItemTapped: @escaping (
            BPKImageGalleryImageGridStyle<Content>.ImageCategory,
            BPKImageGalleryImage<Content>
        ) -> Void,
        onCloseTapped: @escaping () -> Void
    ) -> some View {
        
        modifier(
            ImageGalleryImageGrid(
                categories: categories,
                closeAccessibilityLabel: closeAccessibilityLabel,
                onItemTapped: onItemTapped,
                onCloseTapped: onCloseTapped,
                category: category,
                isPresented: isPresented
                )
            )
    }
}

struct BPKImageGalleryImageGrid_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ImageGalleryGridContentView(
            categories: testCategories,
            closeAccessibilityLabel: "close",
            itemTapped: { item in
                print("onItemTapped: \(item)")
            },
            onCloseTapped: { },
            selectedCategoryIndex: .constant(0)
        )
    }
    
    private static var testCategories: BPKImageGalleryImageGridStyle<Color> {
        return .image([
            BPKImageGalleryImageGridStyle.ImageCategory(
                title: "Green but with very long title indeed (40)",
                images: testImages(40, colour: .green),
                categoryImage: { Color.green }
            ),
            BPKImageGalleryImageGridStyle.ImageCategory(
                title: "Blue photos (10)",
                images: testImages(5, colour: .blue),
                categoryImage: { Color.blue }
            ),
            BPKImageGalleryImageGridStyle.ImageCategory(
                title: "Red photos (10)",
                images: testImages(6, colour: .red),
                categoryImage: { Color.red }
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
