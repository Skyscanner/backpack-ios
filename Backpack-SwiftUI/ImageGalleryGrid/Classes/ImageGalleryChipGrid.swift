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
    let categories: [BPKImageGalleryCategoryChip<ImageView>]
    let closeAccessibilityLabel: String
    let onCategoryChanged: (BPKImageGalleryCategoryChip<ImageView>) -> Void
    let onItemTapped: (BPKImageGalleryCategoryChip<ImageView>, BPKImageGalleryImage<ImageView>) -> Void
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
                    itemTapped: { item, _ in
                        onItemTapped(selectedCategory, item)
                    },
                    onCloseTapped: onCloseTapped,
                    selectedCategoryIndex: $selectedCategoryIndex
                )
            }
    }
    
    private var selectedCategory: BPKImageGalleryCategoryChip<ImageView> {
        categories[selectedCategoryIndex ?? 0]
    }
}

public extension View {
    
    // swiftlint:disable function_parameter_count
    func bpkImageGalleryChipGrid<Content>(
        isPresented: Binding<Bool>,
        initialCategory: Int = 0,
        categories: [BPKImageGalleryCategoryChip<Content>],
        closeAccessibilityLabel: String,
        onCategoryChanged: @escaping (BPKImageGalleryCategoryChip<Content>) -> Void,
        onItemTapped: @escaping (BPKImageGalleryCategoryChip<Content>, BPKImageGalleryImage<Content>) -> Void,
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
