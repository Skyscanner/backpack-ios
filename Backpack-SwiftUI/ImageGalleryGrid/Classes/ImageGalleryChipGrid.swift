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

struct ImageGalleryChipGrid<ImageView: View>: ViewModifier {
    let categories: [BPKImageGalleryImageGridStyle<ImageView>.ChipCategory]
    let closeAccessibilityLabel: String
    let onCategoryChanged: (BPKImageGalleryImageGridStyle<ImageView>.ChipCategory) -> Void
    let onItemTapped: (BPKImageGalleryImageGridStyle<ImageView>.ChipCategory, BPKImageGalleryImage<ImageView>) -> Void
    let onCloseTapped: () -> Void
    let initialCategory: Int
    @Binding var isPresented: Bool
    @State var selectedCategoryIndex: Int? = 0
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ImageGalleryGridContentView(
                    categories: .chip(categories),
                    closeAccessibilityLabel: closeAccessibilityLabel,
                    onCategoryChanged: {
                        onCategoryChanged(selectedCategory)
                    },
                    itemTapped: { item in
                        onItemTapped(selectedCategory, item)
                    },
                    onCloseTapped: onCloseTapped,
                    selectedCategoryIndex: $selectedCategoryIndex
                )
            }
    }
    
    private var selectedCategory: BPKImageGalleryImageGridStyle<ImageView>.ChipCategory {
        categories[selectedCategoryIndex ?? 0]
    }
}

public extension View {
    
    // swiftlint:disable function_parameter_count
    func bpkImageGalleryChipGrid<Content>(
        isPresented: Binding<Bool>,
        initialCategory: Int = 0,
        categories: [BPKImageGalleryImageGridStyle<Content>.ChipCategory],
        closeAccessibilityLabel: String,
        onCategoryChanged: @escaping (BPKImageGalleryImageGridStyle<Content>.ChipCategory) -> Void,
        onItemTapped: @escaping (
            BPKImageGalleryImageGridStyle<Content>.ChipCategory,
            BPKImageGalleryImage<Content>
        ) -> Void,
        onCloseTapped: @escaping () -> Void
    ) -> some View {
        
        modifier(
            ImageGalleryChipGrid(
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

struct BPKImageGalleryChipGrid_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ImageGalleryGridContentView(
            categories: testCategories,
            closeAccessibilityLabel: "close",
            onCategoryChanged: {
                print("onCategoryChanged")
            },
            itemTapped: { item in
                print("onItemTapped: \(item)")
            },
            onCloseTapped: { },
            selectedCategoryIndex: .constant(0)
        )
    }
    
    private static var testCategories: BPKImageGalleryImageGridStyle<Color> {
        return .chip([
            BPKImageGalleryImageGridStyle.ChipCategory(
                title: "Green but with very long title indeed (40)",
                images: testImages(40, colour: .green)
            ),
            BPKImageGalleryImageGridStyle.ChipCategory(
                title: "Blue photos (10)",
                images: testImages(5, colour: .blue)
            ),
            BPKImageGalleryImageGridStyle.ChipCategory(
                title: "Red photos (10)",
                images: testImages(6, colour: .red)
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
